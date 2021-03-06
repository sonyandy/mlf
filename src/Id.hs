{-# LANGUAGE
    DeriveFoldable
  , DeriveFunctor
  , DeriveGeneric
  , DeriveTraversable
  , FlexibleInstances
  , MultiParamTypeClasses #-}
module Id (Id (..)) where

import Control.Applicative
import Control.Comonad
import Control.Lens

import Data.Foldable (Foldable)

import GHC.Generics (Generic)

import Text.PrettyPrint.Free

newtype Id a = Id { runId :: a } deriving ( Read
                                          , Show
                                          , Functor
                                          , Foldable
                                          , Generic
                                          , Traversable
                                          )

instance Comonad Id where
  {-# INLINE extract #-}
  extract = runId
  {-# INLINE duplicate #-}
  duplicate = Id

instance Applicative Id where
  {-# INLINE pure #-}
  pure = Id
  {-# INLINE (<*>) #-}
  f <*> a = Id $ runId f $ runId a

instance Monad Id where
  {-# INLINE return #-}
  return = Id
  {-# INLINE (>>=) #-}
  m >>= f = Id $ runId $ f $ runId m

instance Pretty a => Pretty (Id a) where
  {-# INLINE pretty #-}
  pretty = pretty . runId

instance Field1 (Id a) (Id b) a b
