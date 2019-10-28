import requests
import collections
import logging

logging.basicConfig(level=logging.DEBUG, format=' %(asctime)s - %(levelname)s - %(message)s')
#logging.disable(logging.CRITICAL)

def get_staff_report_new():

    baseURL = "https://publicstaffreports.dpi.wi.gov/PubStaffReport/Public/PublicReport/AllStaffReportDownload"

    ## ?selectedYear=2019&
    #hiringLea=&
    #workingLea=&
    #position=&
    #assignmentArea=&
    #licenseType=&
    #firstNameContains=&
    #lastNameContains=&
    #criteria=Filter%20Criteria:%20Selected%20Year:%202018%20-%202019;%20Selected%20Hiring%20Agencies:%20none;%20Selected%20Working%20Agencies:%20none;%20Selected%20Assignment%20Position:%20--%20All%20Positions%20--;%20Selected%20Assignment%20Area:%20--%20All%20Areas%20--;%20Selected%20First%20Name:%20none;%20Selected%20Last%20Name:%20none;%20Selected%20License%20Type:%20--%20All%20License%20Types%20--

    params = collections.OrderedDict([('selectedYear', 2019), ('lastNameContains', 'Jackson')])

    r = requests.get(baseURL, params=params)
    r.raise_for_status()

    #weatherData = json.loads(r.text)

    # Save the data to disk
    #fileDownload = open(os.path.join(directory, os.path.basename(comicUrl)), 'wb')
    file_download = open('test_download.xlsx', 'wb')
    for chunk in r.iter_content(100000):
        file_download.write(chunk)
    file_download.close()

def get_staff_report_zip():
    fileList = [
        ('2013', '2013.zip', 'https://dpi.wi.gov/sites/default/files/imce/cst/exe/13Staff.zip'),
        ('2014', '2014.zip', 'https://dpi.wi.gov/sites/default/files/imce/cst/exe/14staff.zip'),
        ('2015', '2015.zip', 'https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2015rev10-31-2016.zip'),
        ('2016', '2016.zip', 'https://dpi.wi.gov/sites/default/files/imce/cst/exe/AllStaff2016rev11-01-16.zip')
    ]
    for f in fileList:
        logging.debug(f[1])

        r = requests.get(f[1])
        r.raise_for_status()

        file_download = open(f[0], 'wb')
        for chunk in r.iter_content(100000):
            file_download.write(chunk)
        file_download.close()

if __name__ == "__main__":
   get_staff_report_zip()