USE [TPOPE]
GO

/****** Object:  UserDefinedFunction [dbo].[GXPRFuncGetTaxItm]    Script Date: 8/16/2018 11:32:34 AM ******/
SET ANSI_NULLS ON
GO

SET QUOTED_IDENTIFIER ON
GO











CREATE FUNCTION [dbo].[GXPRFuncGetTaxItm] (@INSopType smallint
		 							      ,@INSopNumbe CHAR(21)
									      ,@INLnItmSeq CHAR(15))
RETURNS numeric(19,5)
AS
BEGIN
	DECLARE @TaxImport numeric(19,5)
	SELECT @TaxImport=SUM(convert(decimal(3,1),Substring(A.TAXDTLID,charindex('V-IV-',A.TAXDTLID,1)+5,5) ))
	FROM SOP10105 A
	WHERE A.SOPTYPE = @INSopType
	  AND A.SOPNUMBE = @INSopNumbe
	  AND A.TAXDTLID LIKE '%'+ rtrim('V-IV-')+'%' AND A.TAXDTLID NOT LIKE '%EXENTO%'
	  AND A.LNITMSEQ = @INLnItmSeq
RETURN (@TaxImport)
END


GO


