
# verify-vpts-completeness

<!-- badges: start -->
<!-- badges: end -->



## Goal

Check if there are daily vpts files for all hdf5 files

## Input

Compares two data frames:
1. https://aloftdata.s3-eu-west-1.amazonaws.com/coverage.csv which contains the directories of hdf5 files
2 Text output of an aws list function which contains the paths of vpts data:

```
2023-09-06 13:03:55    1452222 baltrad/daily/bejab/2018/bejab_vpts_20181026.csv
2023-09-06 13:04:13    1324124 baltrad/daily/bejab/2018/bejab_vpts_20181027.csv
2023-09-06 13:04:31    1571060 baltrad/daily/bejab/2018/bejab_vpts_20181028.csv
2023-09-06 13:04:49    1555603 baltrad/daily/bejab/2018/bejab_vpts_20181029.csv
2023-09-06 13:05:07    1138093 baltrad/daily/bejab/2018/bejab_vpts_20181030.csv
2023-09-06 13:05:24    1554778 baltrad/daily/bejab/2018/bejab_vpts_20181031.csv
2023-09-06 13:05:41    1566588 baltrad/daily/bejab/2018/bejab_vpts_20181101.csv
```
## Output

For each directory in the input first data frame, indicate TRUE / FALSE if there is a corresponding daily file in the second data frame.