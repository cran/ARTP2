\name{options}
\alias{options}
\docType{data}
\title{options}
\description{
The list to describe the options that are used in \code{\link{sARTP}}, \code{\link{rARTP}}. It will be set by function \code{\link{options.default}} by default. 
}
\format{
  The format is a list. 
  
  \describe{
  \item{\code{out.dir}}{output directory for temporary and output files. The default is the working directory \code{\link[base]{getwd}}. }
  \item{\code{id.str}}{character string that is appended to temporary file names. The default is "PID". }
  \item{\code{seed}}{integer for random number generation. The default is 1. }
  }
  
  \bold{Options for testing an association: }
  \describe{
  \item{\code{method}}{1 = AdaJoint, 2 = AdaJoint2, 3 = ARTP. The default is 3. It can also be 'AdaJoint', 'AdaJoint2', or 'ARTP'. The package will convert it into upper case, so for example, 'Adajoint' is also accepted. The ARTP method was the proposed in Yu et al. (2009) Genet Epi, while AdaJoint and AdaJoint2 methods were proposed in Zhang et al. (2014) EJHG. Note that AdaJoint2 could be more powerful if (1) two functional SNPs are negative correlated and have effects in the same direction; or (2) two functional SNPs are positively correlated and have opposite directions of their effects. }
  \item{\code{nperm}}{the number of permutations. The default is 1E5. }
  \item{\code{nthread}}{the number of threads for multi-threaded processors in Unix/Linux OS. The default is \code{detectCores()} to use all available processors. }
  }
  
  \bold{Options for controlling data cleaning: }
  \describe{
    \item{\code{snp.miss.rate}}{any SNP with missing rate greater than \code{snp.miss.rate} will be removed from the analysis. The default is 0.05. }
    \item{\code{maf}}{any SNP with minor allele frequency less than \code{maf} will be removed from the analysis. The default is 0.05. }
    \item{\code{HWE.p}}{any SNP with HWE exact p-value less than \code{HWE.p} will be removed from the analysis. The test is applied to the genotype data or reference data. The test is ignored if the imputed genotype are not encoded as 0/1/2. The default is 1E-5. }
    \item{\code{gene.R2}}{a number between 0 and 1 to filter out SNPs that are highly correlated within each gene. The \code{\link[stats]{cor}} function will be called to compute the R^2 values between each pair of SNPs and remove one SNP with lower MAF in each pair with R^2 greater than \code{gene.R2}. The default is 0.95. }
    \item{\code{chr.R2}}{a number between 0 and 1 to filter out SNPs that are highly correlated within each chromosome. The \code{\link[stats]{cor}} function will be called to compute the R^2 values between each pair of SNPs and remove one SNP with lower MAF in each pair with R^2 greater than \code{chr.R2}. The default is 0.95. }
    \item{\code{gene.miss.rate}}{threshold to remove genes based on their missing rate. Genes with missing rate greater than \code{gene.miss.rate} will be removed from the analysis. The missing rate is calculated as the number of subjects with at least one missing genotype among all SNPs in the gene divided by the total number of subjects. The default is 1.0. }
    \item{\code{rm.gene.subset}}{\code{TRUE} to remove genes which are subsets of other genes. The default is \code{TRUE}. }
    \item{\code{turn.off.filters}}{a shortcut to turn off all SNP filters. If \code{TRUE}, it is equivalent to set \code{snp.miss.rate = 1}, \code{maf = 0}, \code{trim.huge.chr}, \code{gene.R2 = 1}, \code{chr.R2 = 1}, \code{huge.gene.R2 = 1}, \code{huge.chr.R2 = 1}, and \code{HWE.p = 0}. The default is \code{FALSE}. }
    \item{\code{impute}}{\code{TRUE} to impute missing genotypes with the mean of a SNP. \code{FALSE} to use another way other than imputation to handle missing data when constructing the score statistics, which is considered to be more power but also more time-consuming. The default is \code{FALSE}. If the pathway is large and the missing rates are expected to be low, consider to set it to be \code{TRUE} manually for reducing computational burden. It could be beneficial in terms of power with \code{impute} set as \code{FALSE} if the missing rate is high, e.g., the data are combined from multiple studies, and a SNP has missing genotypes because it is not measured or successfully imputed in some of the participating studies. }
    \item{\code{group.gap}}{an integer to regroup SNPs in a chromosome into independent groups. The unit is base-pair (bp). The position information will be collected from the fourth column of bim files. The default is \code{NULL}, i.e., regrouping is not performed. }
    \item{\code{delete}}{\code{TRUE} to delete temporary files containing the test statistics for each gene. The default is \code{TRUE}. }
    \item{\code{print}}{\code{TRUE} to print information to the console. The default is \code{TRUE}. }
    \item{\code{tidy}}{the data frame \code{deleted.snps} in the returned object of \code{\link{sARTP}} containing information of SNPs excluded from the analysis and their reasons. Possible reason codes include \code{RM_BY_SNP_NAMES}, \code{RM_BY_REGIONS}, \code{NO_SUM_STAT}, \code{NO_RAW_GENO}, \code{NO_REF}, \code{SNP_MISS_RATE}, \code{SNP_LOW_MAF}, \code{SNP_CONST}, \code{SNP_HWE}, \code{GENE_R2}, \code{HUGE_GENE_R2}, \code{CHR_R2}, \code{HUGE_CHR}, \code{HUGE_CHR2}, \code{HUGE_CHR3}, \code{GENE_MISS_RATE}, \code{GENE_SUBSET}, \code{CONF_ALLELE_INFO}, \code{LACK_OF_ACCU_BETA}. Set \code{tidy} as \code{TRUE} to hide the SNPs with codes \code{NO_SUM_STAT} and \code{NO_REF}. The default is \code{TRUE}. }
    \item{\code{save.setup}}{\code{TRUE} to save necessary data, e.g., working options, observed scores and covariance matrix, to local to repeat the analysis more quicly (skip loading and filtering data). It will be set to be \code{TRUE} if \code{only.setup} is \code{TRUE}. The default is \code{FALSE}. }
    \item{\code{path.setup}}{character string of file name to save the setup for \code{\link{warm.start}} if \code{save.setup} is \code{TRUE}. The default is \code{NULL} so that it is set as \code{paste(out.dir, "/setup.", id.str, ".rda", sep = "")}. }
    \item{\code{only.setup}}{\code{TRUE} if only the setup is needed while the testing procedure is not. The R code to create the setup uses single thread but the testing procedure can be multi-threaded. The best practice to use \code{ARTP2} on a multi-threaded cluster is to firstly create the setup in single-thread mode, and then call the \code{\link{warm.start}} to compute the p-values in multiple-thread mode, which uses the saved setup at \code{path.setup} as input. \code{save.setup} will be set to be \code{TRUE} if \code{only.setup} is \code{TRUE}. The default is \code{FALSE}. }
    \item{\code{keep.geno}}{\code{TRUE} if the reference genotypes of SNPs in pathway is returned. The default is \code{FALSE}. }
    \item{\code{excluded.snps}}{character vector of SNPs to be excluded in the analysis. \code{NULL} if no SNP is excluded. The default is \code{NULL}. }
    \item{\code{selected.snps}}{character vector of SNPs to be selected in the analysis. \code{NULL} if all SNPs are selected but other filters may be applied. The default is \code{NULL}. }
    \item{\code{excluded.regions}}{data frame with three columns \code{Chr}, \code{Start}, \code{End}, or three columns \code{Chr}, \code{Pos}, \code{Radius}. The unit is base-pair (bp). SNPs within \code{[Start, End]} or \code{[Pos - Radius, Pos + Radius]} will be excluded. See \code{Examples} in \code{sARTP}. This option is only available for \code{sARTP}. The default is \code{NULL}. }
    \item{\code{excluded.subs}}{character vector of subject IDs to be excluded in the analysis. These IDs must match with those in the second column (Individual ID) of the \code{fam} files in \code{reference}. The default is \code{NULL}. }
    \item{\code{selected.subs}}{character vector of subject IDs to be selected in the analysis. These IDs must match with those in the second column (Individual ID) of the \code{fam} files in \code{reference}. The default is \code{NULL}. }
    \item{\code{excluded.genes}}{character vector of genes to be excluded in the analysis. \code{NULL} if no gene is excluded. The default is \code{NULL}. }
    \item{\code{meta}}{\code{TRUE} if return meta-analysis summary data from \code{sARTP}. The default is \code{FALSE}. }
    \item{\code{ambig.by.AF}}{TRUE or FALSE to align SNPs with ambiguous alleles by allele frequency (see details). The default is FALSE. }
    }
  
  \bold{Options for handling huge pathways: }
  \describe{
    \item{\code{trim.huge.chr}}{oversized chromosomes could be further trimmed to accelerate the testing procedure. If \code{TRUE} the additional options below are in effect. The default is \code{TRUE}. }
    \item{\code{huge.gene.size}}{a gene with number of SNPs larger than \code{huge.gene.size} will be further trimmed with \code{huge.gene.R2} if \code{trim.huge.chr} is \code{TRUE}. The default is 1000. }
    \item{\code{huge.chr.size}}{a chromosome with number of SNPs larger than \code{huge.chr.size} will be further trimmed with \code{huge.chr.R2} if \code{trim.huge.chr} is \code{TRUE}. The default is 2000. }
    \item{\code{huge.gene.R2}}{more stringent R^2 threshold to filter out SNPs in a gene. Similar to \code{gene.R2}. The default is \code{gene.R2} - 0.05. }
    \item{\code{huge.chr.R2}}{more stringent R^2 threshold to filter out SNPs in a chromosome. Similar to \code{chr.R2}. The default is \code{chr.R2} - 0.05. }
  }
  
  
  \bold{Options for gene-based test: } 
  \describe{
    \item{\code{inspect.snp.n}}{the number of candidate truncation points to inspect the top SNPs in a gene. The default is 5. (See \code{Details}) }
    \item{\code{inspect.snp.percent}}{a value \code{x} between 0 and 1 such that a truncation point will be defined at every \code{x} percent of the top SNPs. The default is 0 so that the truncation points will be 1:\code{inspect.snp.n}. (See \code{Details}) }
  }
  
  \bold{Options for pathway-based test: } 
  \describe{
    \item{\code{inspect.gene.n}}{the number of candidate truncation points to inspect the top genes in the pathway. The default is 10. }
    \item{\code{inspect.gene.percent}}{a value \code{x} between 0 and 1 such that a truncation point will be defined at every \code{x} percent of the top genes. If 0 then the truncation points will be 1:\code{inspect.gene.n}. The default is 0.05. }
  }
}

\details{ 
  \bold{Order of removing SNPs, genes and subjects:} \cr
   1. Apply the options \code{excluded.snps} and \code{selected.snps} if non-NULL. Code: \code{RM_BY_SNP_NAMES}.\cr
   2. Apply the option \code{excluded.regions} if non-NULL and if \code{sARTP} is used. Code: \code{RM_BY_REGIONS}.\cr
   3. Remove SNPs without summary statistics in \code{summary.files}. Code: \code{NO_SUM_STAT}; or remove SNPs without raw genotype data in \code{data} or \code{geno.files}. Code: \code{NO_RAW_GENO}. \cr
   4. Remove SNPs not in \code{bim} files in \code{reference} if \code{sARTP} is used. Code: \code{NO_REF}. \cr
   5. Remove SNPs with conflictive allele information in summary and reference data if \code{sARTP} is used. Code: \code{CONF_ALLELE_INFO}. \cr
   6. Remove SNPs with missing RAF or EAF if \code{sARTP} and \code{options$ambig.by.AF} are used. Code: \code{NO_VALID_EAF_RAF}. \cr
   7. Remove SNPs with high missing rate. Code: \code{SNP_MISS_RATE}. \cr
   8. Remove SNPs with low MAF. Code: \code{SNP_LOW_MAF}. \cr
   9. Remove constant SNPs. Code: \code{SNP_CONST}. \cr
   10. Remove SNPs fail to pass HWE test. Code: \code{SNP_HWE}. \cr
   11. Remove highly correlated SNPs within each gene. Code: \code{GENE_R2} or \code{HUGE_GENE_R2}. \cr
   12. Remove highly correlated SNPs within each chromosome. Code: \code{CHR_R2}, \code{HUGE_CHR}, \code{HUGE_CHR2} or \code{HUGE_CHR3}. \cr
   13. Remove genes with high missing rate. Code: \code{GENE_MISS_RATE}. \cr
   14. Remove genes which are subsets of other genes. Code: \code{GENE_SUBSET}. \cr
   
  \bold{Example truncation points defined by \code{inspect.snp.n} and \code{inspect.snp.percent}: } 
  Assume the number of SNPs in a gene is 100. Below are examples of the truncation points for different values of \code{inspect.snp.n} and \code{inspect.snp.percent}. Similar values are applied to \code{inspect.gene.n} and \code{inspect.gene.percent}. 

\tabular{rrr}{
inspect.snp.n \tab inspect.snp.percent \tab truncation points \cr
1 \tab 0 \tab 1 \cr
1 \tab 0.05 \tab 5 \cr
1 \tab 0.25 \tab 25 \cr
1 \tab 1 \tab 100 \cr
2 \tab 0 \tab 1, 2 \cr
2 \tab 0.05 \tab 5, 10 \cr
2 \tab 0.25 \tab 25, 50 \cr
2 \tab 1 \tab 100 \cr
3 \tab 0.2 \tab 20, 40, 60 
} % END: tabular

  \bold{SNPs with ambiguous alleles:} \cr
  A SNP with alleles A and T (or C and G) is ambiguous because the strand cannot be determined. Without
  strand information, it is sometimes better to match SNPs with ambiguous alleles by allele frequency
  instead of by matching the alleles. By default, this package matches all SNPs by alleles. If matching
  by allele frequency for the SNPs with ambiguous alleles is desired, then summary files must contain
  a variable called "RAF" (reference allele frequency) or a variable "EAF" (effect allele frequency). 

}

\seealso{
\code{\link{options.default}}
}

\examples{
options <- options.default()
str(options)
names(options)
}

