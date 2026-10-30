module 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::vault_params {
    struct VaultParams has copy, drop {
        owner: address,
        operators: vector<address>,
        min_deposit: u64,
        deposit_cap: u64,
        max_deposit_amount: u64,
        max_withdrawal_amount: u64,
        aum_increase_limit_bps: u64,
        aum_decrease_limit_bps: u64,
        cooldown_ms: u64,
        fulfillment_window_ms: u64,
        timelock_delay_ms: u64,
        fees: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::FeeParams,
    }

    public(friend) fun fees(arg0: &VaultParams) : &0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::FeeParams {
        &arg0.fees
    }

    public(friend) fun aum_decrease_limit_bps(arg0: &VaultParams) : u64 {
        arg0.aum_decrease_limit_bps
    }

    public(friend) fun aum_increase_limit_bps(arg0: &VaultParams) : u64 {
        arg0.aum_increase_limit_bps
    }

    public(friend) fun cooldown_ms(arg0: &VaultParams) : u64 {
        arg0.cooldown_ms
    }

    public(friend) fun deposit_cap(arg0: &VaultParams) : u64 {
        arg0.deposit_cap
    }

    public(friend) fun fulfillment_window_ms(arg0: &VaultParams) : u64 {
        arg0.fulfillment_window_ms
    }

    public(friend) fun max_deposit_amount(arg0: &VaultParams) : u64 {
        arg0.max_deposit_amount
    }

    public(friend) fun max_withdrawal_amount(arg0: &VaultParams) : u64 {
        arg0.max_withdrawal_amount
    }

    public(friend) fun min_deposit(arg0: &VaultParams) : u64 {
        arg0.min_deposit
    }

    public fun new(arg0: address, arg1: vector<address>, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: 0x6a34ab419e1e287dbd4ceff5a38b84b0cbaaa868b8803697bead501771a02026::fees::FeeParams) : VaultParams {
        VaultParams{
            owner                  : arg0,
            operators              : arg1,
            min_deposit            : arg2,
            deposit_cap            : arg3,
            max_deposit_amount     : arg4,
            max_withdrawal_amount  : arg5,
            aum_increase_limit_bps : arg6,
            aum_decrease_limit_bps : arg7,
            cooldown_ms            : arg8,
            fulfillment_window_ms  : arg9,
            timelock_delay_ms      : arg10,
            fees                   : arg11,
        }
    }

    public(friend) fun operators(arg0: &VaultParams) : &vector<address> {
        &arg0.operators
    }

    public(friend) fun owner(arg0: &VaultParams) : address {
        arg0.owner
    }

    public(friend) fun timelock_delay_ms(arg0: &VaultParams) : u64 {
        arg0.timelock_delay_ms
    }

    // decompiled from Move bytecode v7
}

