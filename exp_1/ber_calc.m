% init snr values 

for  i = 0:15
    snr(i+1) = 10^(2*i)/10;
end
 for i= 1:length(snr)
    % generate transimited sequence 
    cur_snr = snr(1);
    tx_sequence = randi([0,1],1,cur_snr*10e6);
    % calc ptx 
    ptx = mean(tx_sequence.^2);
    
    % calc noise
    noise = sqrt(ptx /(2 * cur_snr))*(randn(size(tx_sequence))+i*randn(size(tx_sequence)));
    
    % generate rx_sequence
    rx_sequence = tx_sequence + noise;
    % decision making to one and zero bits
    for j = 1:length(rx_sequence)
         if rx_sequence(j) >= 0.5
             rx_sequence(j) = 1;
         else
             rx_sequence(j) = 0;
         end
        
    end
    [x,y] = biterr(rx_sequence, tx_sequence);
    ber(i) = y;

 end
  semilogy(ber, snr)
