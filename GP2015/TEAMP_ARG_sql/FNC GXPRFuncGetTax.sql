USE [TPOPE]
GO

/****** Object:  UserDefinedFunction [dbo].[GXPRFuncGetTax]    Script Date: 8/16/2018 11:32:29 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO








CREATE FUNCTION [dbo].[GXPRFuncGetTax] (@INSopType smallint
									   ,@INSopNumbe CHAR(21)
									   ,@INTaxdtlid CHAR(15))
RETURNS numeric(19,5)
AS
BEGIN
	DECLARE @TaxImport numeric(19,5)
	DECLARE @FEI_LETRA varchar(2)

	SELECT @TaxImport=SUM(A.STAXAMNT)	
	FROM SOP10105 A
	WHERE A.SOPTYPE = @INSopType
	  AND A.SOPNUMBE = @INSopNumbe
	  AND A.TAXDTLID LIKE '%'+ rtrim(@INTaxdtlid)+'%'
	  AND A.LNITMSEQ = 0
    
	SELECT @FEI_LETRA=FE.FEI_LETRA1
	FROM FEI_SOP30200 FE
	WHERE  FE.SOPTYPE	= @INSopType 
	  AND  FE.SOPNUMBE  = @INSopNumbe

    IF @FEI_LETRA = 'B' set @TaxImport = 0;
	
	RETURN (@TaxImport)
END







GO


