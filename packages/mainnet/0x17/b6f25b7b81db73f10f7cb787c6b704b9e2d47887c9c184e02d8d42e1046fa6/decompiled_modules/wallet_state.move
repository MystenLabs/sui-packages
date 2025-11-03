module 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::wallet_state {
    struct WalletState has store {
        mint_cumulative_amount: u64,
        instant_withdrawal_remaining: u64,
        instant_withdrawal_last_reset_time: u64,
    }

    public(friend) fun destroy(arg0: WalletState) {
        let WalletState {
            mint_cumulative_amount             : _,
            instant_withdrawal_remaining       : _,
            instant_withdrawal_last_reset_time : _,
        } = arg0;
    }

    public(friend) fun instant_withdrawal_last_reset_time(arg0: &WalletState) : u64 {
        arg0.instant_withdrawal_last_reset_time
    }

    public(friend) fun instant_withdrawal_remaining(arg0: &WalletState) : u64 {
        arg0.instant_withdrawal_remaining
    }

    public(friend) fun mint_cumulative_amount(arg0: &WalletState) : u64 {
        arg0.mint_cumulative_amount
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64) : WalletState {
        WalletState{
            mint_cumulative_amount             : arg0,
            instant_withdrawal_remaining       : arg1,
            instant_withdrawal_last_reset_time : arg2,
        }
    }

    public(friend) fun set_instant_withdrawal_last_reset_time(arg0: &mut WalletState, arg1: u64) {
        arg0.instant_withdrawal_last_reset_time = arg1;
    }

    public(friend) fun set_instant_withdrawal_remaining(arg0: &mut WalletState, arg1: u64) {
        arg0.instant_withdrawal_remaining = arg1;
    }

    public(friend) fun set_mint_cumulative_amount(arg0: &mut WalletState, arg1: u64) {
        arg0.mint_cumulative_amount = arg1;
    }

    // decompiled from Move bytecode v6
}

