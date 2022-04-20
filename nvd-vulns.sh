## 
# Grab recent NVD CVE's
# 
# Recent:  https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-recent.json.gz
# 2022:  https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-2022.json.gz
#
# A simple helper by Jemurai.
curl https://nvd.nist.gov/feeds/json/cve/1.1/nvdcve-1.1-recent.json.gz > nvdcve.json.gz
gunzip nvdcve.json.gz

DAT=$(date -v-14d +%Y-%m-%d)
echo "DAT is " $DAT
cat nvdcve.json | jq '.CVE_Items[] | (.lastModifiedDate) + " " + (.cve | .CVE_data_meta | .ID | tostring) + " " + (.cve | .description | .description_data[] | .value | tostring)' > nvdcve.1.txt
sed 's/T[0-9][0-9]:[0-9][0-9]Z//g' nvdcve.1.txt > nvdcve.2.txt
sed 's/\"//g' nvdcve.2.txt > nvdcve.3.txt
awk -v DAT="$DAT" ' $1 >= DAT ' nvdcve.3.txt > nvdcve.4.txt
cat nvdcve.4.txt

rm nvdcve.1.txt
rm nvdcve.2.txt
rm nvdcve.3.txt
rm nvdcve.4.txt
