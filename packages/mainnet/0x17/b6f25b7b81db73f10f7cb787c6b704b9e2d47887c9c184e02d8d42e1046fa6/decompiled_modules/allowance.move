module 0x17b6f25b7b81db73f10f7cb787c6b704b9e2d47887c9c184e02d8d42e1046fa6::allowance {
    struct Allowance has store {
        max_supply: u64,
        daily_system_withdraw_limit: u64,
        daily_wallet_withdraw_limit: u64,
        per_wallet_mint_limit: u64,
        min_withdrawal_amount: u64,
    }

    struct MaxSupplyUpdated has copy, drop {
        max_supply: u64,
    }

    struct DailySystemWithdrawLimitUpdated has copy, drop {
        daily_system_withdraw_limit: u64,
    }

    struct DailyWalletWithdrawLimitUpdated has copy, drop {
        daily_wallet_withdraw_limit: u64,
    }

    struct PerWalletMintLimitUpdated has copy, drop {
        per_wallet_mint_limit: u64,
    }

    struct MinWithdrawalAmountUpdated has copy, drop {
        min_withdrawal_amount: u64,
    }

    public(friend) fun daily_system_withdraw_limit(arg0: &Allowance) : u64 {
        arg0.daily_system_withdraw_limit
    }

    public(friend) fun daily_wallet_withdraw_limit(arg0: &Allowance) : u64 {
        arg0.daily_wallet_withdraw_limit
    }

    public(friend) fun max_supply(arg0: &Allowance) : u64 {
        arg0.max_supply
    }

    public(friend) fun min_withdrawal_amount(arg0: &Allowance) : u64 {
        arg0.min_withdrawal_amount
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : Allowance {
        Allowance{
            max_supply                  : arg0,
            daily_system_withdraw_limit : arg1,
            daily_wallet_withdraw_limit : arg2,
            per_wallet_mint_limit       : arg3,
            min_withdrawal_amount       : arg4,
        }
    }

    public(friend) fun per_wallet_mint_limit(arg0: &Allowance) : u64 {
        arg0.per_wallet_mint_limit
    }

    public(friend) fun set_daily_system_withdraw_limit(arg0: &mut Allowance, arg1: u64) {
        arg0.daily_system_withdraw_limit = arg1;
        let v0 = DailySystemWithdrawLimitUpdated{daily_system_withdraw_limit: arg1};
        0x2::event::emit<DailySystemWithdrawLimitUpdated>(v0);
    }

    public(friend) fun set_daily_wallet_withdraw_limit(arg0: &mut Allowance, arg1: u64) {
        arg0.daily_wallet_withdraw_limit = arg1;
        let v0 = DailyWalletWithdrawLimitUpdated{daily_wallet_withdraw_limit: arg1};
        0x2::event::emit<DailyWalletWithdrawLimitUpdated>(v0);
    }

    public(friend) fun set_max_supply(arg0: &mut Allowance, arg1: u64) {
        arg0.max_supply = arg1;
        let v0 = MaxSupplyUpdated{max_supply: arg1};
        0x2::event::emit<MaxSupplyUpdated>(v0);
    }

    public(friend) fun set_min_withdrawal_amount(arg0: &mut Allowance, arg1: u64) {
        arg0.min_withdrawal_amount = arg1;
        let v0 = MinWithdrawalAmountUpdated{min_withdrawal_amount: arg1};
        0x2::event::emit<MinWithdrawalAmountUpdated>(v0);
    }

    public(friend) fun set_per_wallet_mint_limit(arg0: &mut Allowance, arg1: u64) {
        arg0.per_wallet_mint_limit = arg1;
        let v0 = PerWalletMintLimitUpdated{per_wallet_mint_limit: arg1};
        0x2::event::emit<PerWalletMintLimitUpdated>(v0);
    }

    // decompiled from Move bytecode v6
}

