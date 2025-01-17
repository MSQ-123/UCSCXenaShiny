% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ccle.R, R/get_pancan_value.R
\name{get_ccle_cn_value}
\alias{get_ccle_cn_value}
\alias{get_ccle_gene_value}
\alias{get_ccle_protein_value}
\alias{get_ccle_mutation_status}
\alias{get_pancan_value}
\alias{get_pancan_gene_value}
\alias{get_pancan_protein_value}
\alias{get_pancan_mutation_status}
\alias{get_pancan_cn_value}
\title{Fetch identifier value from pan-cancer dataset}
\usage{
get_ccle_cn_value(identifier)

get_ccle_gene_value(identifier)

get_ccle_protein_value(identifier)

get_ccle_mutation_status(identifier)

get_pancan_value(
  identifier,
  subtype = NULL,
  dataset = NULL,
  host = available_hosts(),
  samples = NULL
)

get_pancan_gene_value(identifier)

get_pancan_protein_value(identifier)

get_pancan_mutation_status(identifier)

get_pancan_cn_value(identifier)
}
\arguments{
\item{identifier}{a length-1 character representing a gene symbol, ensembl gene id, or probe id.
Gene symbol is highly recommended.}

\item{subtype}{a length-1 chracter representing a regular expression for matching
\code{DataSubtype} column of \link[UCSCXenaTools:XenaData]{UCSCXenaTools::XenaData}.}

\item{dataset}{a length-1 chracter representing a regular expression for matching
\code{XenaDatasets} of \link[UCSCXenaTools:XenaData]{UCSCXenaTools::XenaData}.}

\item{host}{a length-1 character representing host name, e.g. "toilHub".}

\item{samples}{a character vector representing samples want to be returned.}
}
\value{
a named vector or \code{list}
}
\description{
Identifier includes gene/probe etc.
}
\section{Functions}{
\itemize{
\item \code{get_ccle_cn_value}: Fetch copy number value from CCLE dataset

\item \code{get_ccle_gene_value}: Fetch gene expression value from CCLE dataset

\item \code{get_ccle_protein_value}: Fetch gene protein expression value from CCLE dataset

\item \code{get_ccle_mutation_status}: Fetch gene mutation info from CCLE dataset

\item \code{get_pancan_value}: Fetch identifier value from pan-cancer dataset

\item \code{get_pancan_gene_value}: Fetch gene expression value from pan-cancer dataset

\item \code{get_pancan_protein_value}: Fetch protein expression value from pan-cancer dataset

\item \code{get_pancan_mutation_status}: Fetch mutation status value from pan-cancer dataset

\item \code{get_pancan_cn_value}: Fetch gene copy number value from pan-cancer dataset processed by GISTIC 2.0
}}

\examples{
\donttest{
# Fetch TP53 expression value from pan-cancer dataset
t1 <- get_pancan_value("TP53",
  dataset = "TcgaTargetGtex_rsem_isoform_tpm",
  host = "toilHub"
)
t2 <- get_pancan_gene_value("TP53")
t3 <- get_pancan_protein_value("AKT")
t4 <- get_pancan_mutation_status("TP53")
t5 <- get_pancan_cn_value("TP53")
}

}
