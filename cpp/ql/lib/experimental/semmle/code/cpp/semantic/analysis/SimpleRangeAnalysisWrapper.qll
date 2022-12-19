import cpp
import RangeAnalysis
import experimental.semmle.code.cpp.semantic.SemanticExpr
import experimental.semmle.code.cpp.semantic.SemanticExprSpecific
import semmle.code.cpp.rangeanalysis.RangeAnalysisUtils

float lowerBound(Expr expr) {
  exists(SemExpr se, SemZeroBound bound, int delta |
    semBounded(se, bound, delta, false, _) and
    result = delta and
    getCppInstruction(se).getConvertedResultExpression() = expr
  )
}

float upperBound(Expr expr) {
  exists(SemExpr se, SemZeroBound bound, int delta |
    semBounded(se, bound, delta, true, _) and
    result = delta and
    getCppInstruction(se).getConvertedResultExpression() = expr
  )
}

predicate exprMightOverflowPositively(Expr expr) { upperBound(expr) > exprMaxVal(expr) }

predicate exprMightOverflowNegatively(Expr expr) { lowerBound(expr) < exprMinVal(expr) }
