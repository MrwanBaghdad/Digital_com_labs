% init snr values 

snr = 0:2:30;

tx_sequence = randi([0,1],1,1e6);
    % calc ptx
ptx = mean(tx_sequence.^2);

 for s= 1:length(snr)
    % generate transimited sequence
    s
    cur_snr = 10.^(snr(s)/10);    
    
    % calc noise
    noise = sqrt(ptx /(2 * cur_snr))* ( randn(size(tx_sequence)) + (i*randn(size(tx_sequence))));
    % generate rx_sequence
    rx_sequence = tx_sequence + noise;
    % decision making to one and zero 

    for k = 1:length(rx_sequence)
         if (rx_sequence(k)) >= 0.5
             rx(k) = 1;
         else
             rx(k) = 0;
         end
    end
    [x,y] = biterr(tx_sequence,rx);
    ber(s) = y;
 end
 snr = 0:2:30;
semilogy(snr, ber);
