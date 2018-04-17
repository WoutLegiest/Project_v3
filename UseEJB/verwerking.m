pkg load signal 
data = [-0.15575218, 0.004767418, 0.026238441, 0.09940815, -0.050434113, -0.12369728, -0.11561775, -0.16653919, -0.021520615, 0.098958015, 0.11931229, -0.1188221, -0.19196224, -0.09226227, 0.07058239, 0.098195076, 0.04976368, 0.04228401, 0.06339073, -0.09295368, -0.15467739, -0.09006214, 0.057222366, 0.09856415, 0.1235857, 0.016111374, -0.034870148, -0.076052666, -0.02453804, 0.0015668869, 0.07649326, 0.1221571, 0.027226448, -0.11269188, -0.18059826, -0.044436455, 1.369545, 0.21556187, -0.7822151, 1.5591145, -1.4118919, -7.386939, -0.17256546, -0.85807705, 0.4780035, 2.1156702, 2.6347418, 1.6107101, 0.73710155, 1.5070944, 4.289178, 6.5103617, 5.355878, 5.0457973, 3.7492733, 1.9505234, -3.2506056, -7.105695, -14.072577, -17.456635, -5.149108, 7.0750847, 15.147504, 10.814219, -1.7043667, -6.9189734, -6.514746, -3.0464401, -4.1261, -2.360334, -0.5213232, -0.14603281, 2.281569, 12.021181, 9.88235, 4.5312977, -1.5329905, -8.38666, -12.860445, -13.851835, -9.759515, 0.4461093, 10.429035, 13.278578, 5.8748503, -5.687422, -9.703043, -11.91349, -6.858506, 11.43037, 20.160267, 16.075281, 0.46273947, -8.244173, -13.533188, -14.639564, -10.712086, 3.361229, 12.947666, 8.209546, 4.724661, -0.63291407, -8.812599, -13.783871, -3.8303905, 15.406916, 13.502991, 6.8724647, 0.010748386, -6.86706, -13.998389, -16.151985, -1.1834121, 14.64258, 10.154853, -2.6464453, -4.7661147, -10.339979, -23.383434, -14.771315, 15.87365, 22.889399, 10.460485, -5.5765176, -4.9587846, -1.6149831, 1.1334634, 4.941731, 8.764534, 18.000572, 17.453262, -1.2668505, -16.031713, -17.51768, -16.801943, -3.788052, 9.234051, 7.863299, 0.71896124, 1.9460082, 2.0475378, 4.6042204, -4.7783446, -7.012344, -0.9634471, -1.1008439, -5.929788, -6.8397956, 3.004826, 11.087143, 9.947552, -2.0770802, -4.0799823, 0.8396244, 5.0801754, -0.89120007, -0.5195732, 2.2809267, 1.4907823, -3.2683978, -2.7255397, 3.6920166, 5.7161984, 8.949446, 12.824567, 2.0743647, -8.385265, -13.804734, -22.077614, -20.082779, -4.5392575, 21.449265, 33.540928, 20.310497, -3.8006706, -15.163189, -20.848495, -20.486082, -14.07761, 7.3082027, 19.315247, 10.636445, 0.50394726, -4.613981, -8.690945, -4.5536995, 0.2317729, 5.4199367, 11.332016, 11.608879, 4.639309, -1.3426385, -3.4966087, -4.3501005, -2.1488867, 1.6652098, 3.5581732, 2.968186, -2.2413163, -7.866225, -6.7246284, -4.2048516, 3.218, 4.0794816, 6.350076, 3.355595, -1.5282774, -4.4556956, -6.5597863, -0.9750924, 4.472367, 13.867369, 11.767413, 3.8854828, -2.267743, -7.2226095, -4.46436, 4.3115206, 1.144722, -5.218721, -9.440312, -12.271319, -8.582926, -5.3718705, 3.2313194, 4.129491, 4.536105, 3.607748, -2.8830857, -12.490333, -7.932491, 14.644815, 22.872349, 15.172852, -1.5600853, -9.690127, -11.274902, -6.820367, -0.062132835, 1.9498644, 0.24801159, -0.54671764, 1.619792, 3.2707396, 2.695076, 0.13382816, -0.35753727, -0.58500195, 0.004436493, -0.24911976, 0.7423134, 0.9977617, 0.81686974, 0.20524311, 0.04951191, -0.14363956, -0.23303986, -0.21587849, -0.26991844, 0.343997, 0.47129822, -0.08322334, -0.546196, -0.7346754, -3.2343178, -2.487134, 0.3681059, 3.7868624, 1.1224327]; 
endData = length(data) -1 ; 
 endData = endData*0.01; 
 t = 0:0.01:endData; 
 %% Step 1: resample at fixed time step 
Fs = 100.; % desired (fixed) sample rate 
%[data_resampled,t_resampled] = resample(data,t,Fs); 
t_resampled = t(1):1/Fs:t(end); 
data_resampled = interp1(t, data, t_resampled, 'spline'); 
% to make sure time starts at t = 0s: 
t_resampled = t_resampled - t_resampled(1); 
%% Step 2: Compute amplitude spectrum of the signal 
L = length(data_resampled); 
f = Fs*(0:(L/2))/L; 
A2_data = fft(data_resampled); A2 = abs(A2_data/L); 
A_data = A2(1:L/2+1); A_data(2:end-1) = 2*A_data(2:end-1); 
maxi = max(A_data); 
k = find(A_data==maxi); 
disp(f(k)); 
disp('fase'); 
disp(A_data); 
disp('fase'); 
disp(f); 
disp('fase'); 
%% Step 3: Apply bandbass filter 
% Lowerbound and upperbound cutoff bandpass filter (relative to Nyquist frequency) 
f1 = 1/Fs*2; f2 = 4/Fs*2; 
% [b,a] = butter(n,Wn,ftype) 
filter_order = 4; 
[b,a] = butter(filter_order,[f1 f2]); 
data_filtered = filtfilt(b,a,data_resampled); 
A2_data = fft(data_filtered); A2 = abs(A2_data/L); 
A_data = A2(1:L/2+1); A_data(2:end-1) = 2*A_data(2:end-1); 
maxi = max(A_data); 
k = find(A_data==maxi); 
disp(f(k)); 
disp('fase'); 
disp(A_data); 
