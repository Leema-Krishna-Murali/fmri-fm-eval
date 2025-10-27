# ABIDE

Download source data

```bash
aws s3 sync --no-sign-request s3://fcp-indi/data/Projects/ABIDE/RawDataBIDS sourcedata/RawDataBIDS
```

```bash
aws s3 cp --no-sign-request 's3://fcp-indi/data/Projects/ABIDE/Phenotypic_V1_0b.csv' sourcedata/
aws s3 cp --no-sign-request 's3://fcp-indi/data/Projects/ABIDE/Phenotypic_V1_0b_preprocessed.csv' sourcedata/
aws s3 cp --no-sign-request 's3://fcp-indi/data/Projects/ABIDE/Phenotypic_V1_0b_preprocessed1.csv' sourcedata/
```