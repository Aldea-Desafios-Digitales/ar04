/****** Object:  UserDefinedFunction [dbo].[GXPRFuncGetTax]    Script Date: 28/01/2020 15:02:12 ******/
DROP FUNCTION [dbo].[GXPRFuncGetTax]
GO

/****** Object:  UserDefinedFunction [dbo].[GXPRFuncGetTax]    Script Date: 28/01/2020 15:02:12 ******/
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
	SELECT @TaxImport=SUM(A.ORSLSTAX)	
	FROM SOP10105 A
	WHERE A.SOPTYPE = @INSopType
	  AND A.SOPNUMBE = @INSopNumbe
	  AND A.TAXDTLID LIKE '%'+ rtrim(@INTaxdtlid)+'%'
	  AND A.LNITMSEQ = 0
RETURN (@TaxImport)
END
GO


