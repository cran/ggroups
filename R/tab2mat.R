#' @title Tabular to matrix
#'
#' @description Converts tabular data to matrix data.
#'
#' @param tab : \code{data.frame} with 2 integer (IDs) and 1 numeric (values) columns.
#'
#' @return Converted \code{data.frame} to \code{matrix}
#'
#' @examples
#' ped = data.frame(ID=1:6, SIRE=c(0,0,1,3,1,4), DAM=c(0,0,2,2,2,5))
#' tab2mat(tabA(ped))
#'
#' @export
tab2mat = function(tab) {
   colnames(tab) = c("ID1", "ID2", "val")
   theset = unique(sort(tab$ID1))
   mat = matrix(0, nrow=length(theset), ncol=length(theset))
   rownames(mat) = colnames(mat) = paste0('x', theset)
   for(i in theset) mat[paste0('x', i), paste0('x', tab[tab$ID1==i,]$ID2)] = tab[tab$ID1==i,]$val
   rownames(mat) = colnames(mat) = theset
   mat = mat + t(mat)
   diag(mat) = diag(mat)/2
   return(mat)
}
