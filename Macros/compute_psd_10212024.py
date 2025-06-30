#!/bin/python3
"""
Compute Power Spectral Density (PSD) for DPW8 Buffet TFG
Author: Eduardo Molina (Embraer SA)
Date: 10/20/2024
"""
import numpy as np
import argparse
import pandas as pd
import matplotlib.mlab as mlab
import matplotlib.pyplot as plt

parser = argparse.ArgumentParser(description='DPW8 Power Spectral Density Computation')
parser.add_argument('-f','--file', help='Input time csv file', required=True)
parser.add_argument('-o','--overlap', help='Overlap [0,1]', required=True, type=float)
parser.add_argument('-n','--nfft', help='Number of data points in each block of the FFT.', required=True, type=int)
parser.add_argument('-d','--df_target', help='Target frequency resolution in Hz (use to pad the FFT)', type=float)
parser.add_argument('-w','--window',action="store_true",help='Use Hanning window')
parser.print_help()
args = vars(parser.parse_args())

# Input file
infile = args['file']

# Read the time input file as pandas dataframe
df_time = pd.read_csv(infile)

# Delete the last column of the dataframe since there many commas at the end of random lines, suggesting a new variable.
# Please comment this line when the experimental data is fixed.
# df_time.drop(df_time.columns[len(df_time.columns)-1], axis=1, inplace=True)

# Number of samples
N = len(df_time)

# Number of channels
channels = df_time.keys()
Nchan    = len(channels) - 1

# Time step
dt = df_time.iloc[1,0] - df_time.iloc[0,0]

# Sampling frequency
fs = 1./dt

# Integer indicating the number of data points used in each block for the FFT.
nfft   = args['nfft']

# Overlap as a fraction of nw. Must be between 0 and 1.
nover  = args['overlap']

# Target frequency resolution, only used when pad to zeros.
df_target = args['df_target']
if df_target == None:
    is_pad_to = False
    pad_to    = nfft
else:
    is_pad_to = True
    # The number of points to which the data segment is padded when performing the FFT. 
    # This can be different from NFFT, which specifies the number of data points used. 
    # While not increasing the actual resolution of the spectrum (the minimum distance between resolvable peaks), this can give more points in the plot, allowing for more detail.
    # This corresponds to the n parameter in the call to fft(). The default is None, which sets pad_to equal to NFFT. See the mlab manual.
    pad_to = int(np.floor(fs/df_target))

D   = np.floor(nfft*(1-nover))
K   = np.floor((N + D-nfft)/D)
pxx = np.zeros((int(pad_to/2)+1,Nchan))

print("Number of Points of the FFT: %d"%pxx.shape[0])
print("Window Size: %d"%nfft)
print("Window Size (sec): %.4f s"%(nfft*dt))
print("Nfft = %d "%pad_to)
print("Number of Segments: %d"%K)

if args['window']:
    window = mlab.window_hanning
    print("Window: Hanning")
else:
    window = mlab.window_none
    print("Window: None")

# Compute PSD
for i in range(Nchan):
    pxx[:,i],freq=mlab.psd(df_time.iloc[:,i+1], NFFT=nfft, Fs=fs, detrend=mlab.detrend_mean, window=window,
            noverlap=round(nfft*nover), pad_to=pad_to, sides = 'default', scale_by_freq=None)

# Create Pandas Dataframe and write to csv file
data   = np.column_stack((freq, pxx))
header = ['freq']
for item in channels[1:]:
    header.append(item)
df_freq = pd.DataFrame(data, columns = header)
df_freq.to_csv('psd.csv')

# Please comment the lines below.
# df_ref = pd.read_csv('buffet_cp_psd_aoa589.csv')
# plt.figure()
# plt.title('CH4 AoA=5.89deg')
# plt.loglog(df_freq['freq'], df_freq['CH4'], label = 'Python Script')
# plt.loglog(df_ref['f[Hz]'], df_ref['CH4[1/Hz]'], label = 'JAXA PSD file')
# plt.xlim([1,1e5])
# plt.ylim([1e-12,1e-4])
# plt.xlabel('Frequency [Hz]')
# plt.ylabel('PSD of Cp [1/Hz]')
# plt.legend()
# plt.show()
# np.testing.assert_allclose(df_freq.to_numpy()[:-1,:], df_ref.to_numpy()[:,:])

