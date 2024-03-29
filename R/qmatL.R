#' @title Matrix \strong{Q} for large pedigrees
#'
#' @description Creates the genetic group contribution matrix for large pedigrees.
#'
#' @param ped2 : The output \code{data.frame} from \code{\link{gghead}} (for more details: \code{?\link{gghead}})
#'
#' @return \strong{Q} \code{matrix}
#'
#' @examples
#' ped = data.frame(ID=c(3,4,6,5), SIRE=c(1,3,4,1), DAM=c(2,2,5,2))
#' ped2 = gghead(ped)
#' qmatL(ped2)
#'
#' @export
qmatL = function(ped2) {
   colnames(ped2) = c("ID", "SIRE", "DAM")
   Ngg = nrow(ped2[ped2$SIRE==0 & ped2$DAM==0,])
   message("Found ", Ngg, " genetic groups")
   ggID = ped2[1:Ngg,]$ID
   animID = ped2[(Ngg+1):nrow(ped2),]$ID
   Q = matrix(0, nrow=nrow(ped2)-Ngg, ncol=Ngg, dimnames=list(animID, ggID))
   for(i in ggID)
   {
      message("Processing genetic group ", i)
      descendants = peddown(ped2, i)
      A.row1 = Arow1(descendants)[-1,]
      for(j in 1:nrow(A.row1)) Q[as.character(A.row1[j,]$ID), as.character(i)] = A.row1[j,]$rg
   }
   return(Q)
}
