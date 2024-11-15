module Data.Hashable
  ( HashCode
  , hashCode
  , class Hashable
  , hash
  , hashEqual
  , combineHashes
  ) where

import Prelude

import Data.Char (toCharCode)
import Data.Either (Either(..))
import Data.Foldable (foldl)
import Data.Function (on)
import Data.Maybe (Maybe(..))
import Data.String.CodeUnits (toCharArray)
import Data.Tuple (Tuple(..))

newtype HashCode = HashCode Int

instance Eq HashCode where
  eq (HashCode a) (HashCode b) = a == b

hashCode ∷ Int → HashCode
hashCode h = HashCode (h `mod` 65535)

class Eq a ⇐ Hashable a where
  hash ∷ a → HashCode

instance Show HashCode where
  show (HashCode h) = "(HashCode " <> show h <> ")"

combineHashes ∷ HashCode → HashCode → HashCode
combineHashes (HashCode h1) (HashCode h2) = hashCode (73 * h1 + 51 * h2)

hashEqual ∷ ∀ a. Hashable a ⇒ a → a → Boolean
hashEqual = eq `on` hash

instance Hashable Char where
  hash = hash <<< toCharCode

instance Hashable String where
  hash = hash <<< toCharArray

instance Hashable Int where
  hash = hashCode

instance Hashable Boolean where
  hash false = hashCode 0
  hash true = hashCode 1

instance Hashable a ⇒ Hashable (Array a) where
  hash = foldl combineHashes (hashCode 0) <<< map hash

instance Hashable a ⇒ Hashable (Maybe a) where
  hash Nothing = hashCode 0
  hash (Just a) = hashCode 1 `combineHashes` hash a

instance (Hashable a, Hashable b) ⇒ Hashable (Tuple a b) where
  hash (Tuple a b) = hash a `combineHashes` hash b

instance (Hashable a, Hashable b) ⇒ Hashable (Either a b) where
  hash (Left a) = hashCode 0 `combineHashes` hash a
  hash (Right b) = hashCode 1 `combineHashes` hash b
