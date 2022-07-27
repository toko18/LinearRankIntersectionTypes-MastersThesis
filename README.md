# LinearRankIntersectionTypes-MastersThesis
##### Practical work developed in the context of my Master's Thesis at DCC-FCUP (Faculdade de Ciências da Universidade do Porto) in 2022

## Getting Started

### Prerequisites

 - You need to have the Glasgow Haskell Compiler (GHC) installed in your machine. You can download it from https://www.haskell.org/ghc/download.html.

## Content

* `LambdaCalculus.hs`: contains the data constructors that define lambda-terms.

* `SimpleTypes.hs`: defines simple types and includes the implementation of Robinson's Unification Algorithm (function `unify`) and Milner's Type Inference Algorithm (function `simpleTypeInf`).

* `Rank2IntersectionTypes.hs`: defines rank 2 intersection types and includes the implementation of the algorithm that transforms <=2,1-satisfaction problems into equivalent unification problems (function `transformSat`) and Trevor Jim's Type Inference Algorithm (function `r2typeInf`).

* `LinearTypes.hs`: defines linear types and includes the implementation of our Quantitative Unification Algorithm (function `unifyQ`).

* `LinearRank2QuantitativeTypes.hs`: defines linear rank 1 and 2 intersection types and includes the implementation of our Quantitative Type Inference Algorithm (function `quantR2typeInf`).

* `Reductions.hs`: defines the functions `maximal`, `normal` and `applicative` that are called by the `reduce` function to reduce terms to normal form using the maximal, normal and applicative evaluation strategies, respectively.

* `parser.y`: description of the parser to be generated with Happy.
* `parser.hs`: parser generated with Happy.

* `inputs`: folder with example input files.

## How to Use It
 
 In order to use the parser, you first need to **compile** `parser.hs` with `ghc -o parser parser.hs` in the terminal, and then you can **execute** the `parser` file generated with the command `./parser`.
 
 The parser accepts **isolated lambda-terms** and **calls to the reduction function** `reduce` and **to the type inference functions** `simpleTypeInf`, `r2typeInf` and `quantR2typeInf`, applied to lambda-terms.
 
 - The **allowed type inference functions** are `ti0` (calls `simpleTypeInf`), `ti2` (calls `r2typeInf`) and `qti2` (calls `quantR2typeInf`), which infer the type of terms for simple types, rank 2 intersection types and linear rank 2 intersection types with quantitative information, respectively. They should be used in the following way: `ti0 (Term)`,  `ti2 (Term)` and `qti2 (Term) count`, where `Term` is a lambda-term and `count` is an optional argument that, when passed, makes it not display the environment and type inferred, but only the term and the quantitative measure given by the algorithm.

- The **allowed reduction functions** are `reduceMax`, `reduceNorm` and  `reduceApp`, which call `reduce` to reduce a term to normal form using the maximal, normal and applicative evaluation strategies, respectively. They should be used in the following way: `reduceMax (Term) Mode`,  `reduceNorm (Term) Mode` and `reduceApp (Term) Mode`, where `Term` is a lambda-term and `Mode` is an optional argument that can be either `steps` or `count` - when passed, `steps` makes it also display all the evaluation steps of the term to normal form, and `count` makes it not display the term's normal form, but only the initial term and the length of the evaluation (number of reduction steps).

 - Regarding the **format of the lambda-terms**, applications correspond to 2 terms separated by a space (`Term Term`) and abstractions to `\Var.Term`, where `Var` is an alphanumeric string and `Term` is a lambda-term. Terms can also be written between parentheses, for precedence purposes.
 
To see some examples of input, including the ones used to obtain the experimental results presented in the Thesis, check the example input files in the folder `inputs`.

---

**Author:** Fábio Reis
