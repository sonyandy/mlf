{-# LANGUAGE LambdaCase #-}
module Token (Token (..)) where

import Data.Text (Text)

import Text.PrettyPrint.Free

data Token
  = Arr
  | Bot
  | Flexible
  | Rigid
  | LeftParen
  | RightParen
  | Var Text
  | EOF deriving Show

instance Pretty Token where
  pretty = \ case
    Arr -> text "->"
    Bot -> text "_|_"
    Flexible -> char '>'
    Rigid -> char '='
    LeftParen -> char '('
    RightParen -> char ')'
    Var a -> pretty a
    EOF -> text "end" <+> text "of" <+> text "input"
