grammar NQP::Grammar is HLL::Grammar;

token TOP { <EXPR> [ $ || <.panic: 'Confused'> ] }

## Terms

proto token term { <...> }

token term:sym<identifier> {
    <ident> <args>
}

token args {
    | '(' <arglist> ')'
}

token arglist {
    <.ws> 
    [ 
    | <EXPR>
    | <?>
    ]
}


token term:sym<value> { <value> }

token value {
    | <integer>
    | <quote>
}

proto token quote { <...> }
token quote:sym<apos> { <?[']>            <quote_EXPR: ':q'>  }
token quote:sym<dblq> { <?["]>            <quote_EXPR: ':qq'> }
token quote:sym<q>    { 'q'  <![(]> <.ws> <quote_EXPR: ':q'>  }
token quote:sym<qq>   { 'qq' <![(]> <.ws> <quote_EXPR: ':qq'> }
token quote:sym<Q>    { 'Q'  <![(]> <.ws> <quote_EXPR> }

token circumfix:sym<( )> { '(' <EXPR> ')' }
token circumfix:sym<ang> { <?[<]>  <quote_EXPR: ':q', ':w'>  }

## Operators

token nulltermish { 
    | <OPER=noun=noun> 
    | <?>
}

token postcircumfix:sym<[ ]> { 
    '[' <EXPR> ']' 
    <O('%methodop')>
}

token prefix:sym<-->  { $<sym>=['--'] <O('%autoincrement')> }
token postfix:sym<++> { $<sym>=['++'] <O('%autoincrement')> }

token infix:sym<**>   { $<sym>=['**'] <O('%exponentiation, :pirop<pow>')> }

token prefix:sym<->   { $<sym>=['-']  <O('%symbolic_unary')> }

token infix:sym<*>    { $<sym>=['*']  <O('%multiplicative, :pirop<mul>')> }
token infix:sym</>    { $<sym>=['/']  <O('%multiplicative, :pirop<div>')> }
token infix:sym<%>    { $<sym>=['%']  <O('%multiplicative, :pirop<mod>')> }

token infix:sym<+>    { $<sym>=['+']  <O('%additive, :pirop<add>')> }
token infix:sym<->    { $<sym>=['-']  <O('%additive, :pirop<sub>')> }

token infix:sym<~>    { $<sym>=['~']  <O('%concatenation , :pirop<concat>')> }

token infix:sym<:=>   { $<sym>=[':=']  <O('%assignment, :pasttype<bind>')> }

token infix:sym<,>    { $<sym>=[',']  <O('%comma')> }
