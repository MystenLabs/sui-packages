module 0x6fea415a5e53b87fb6849969139a3e02ee2d7c157a1f5ab26e12a61e4211c5e0::event {
    struct DepositEvent<phantom T0> has copy, drop {
        amount: u64,
        lp_minted: u64,
    }

    struct WithdrawEvent<phantom T0> has copy, drop {
        amount: u64,
        lp_burned: u64,
    }

    struct StrategyProfitEvent<phantom T0> has copy, drop {
        strategy_id: 0x2::object::ID,
        profit: u64,
        fee_amt_t: u64,
    }

    struct StrategyLossEvent<phantom T0> has copy, drop {
        strategy_id: 0x2::object::ID,
        to_withdraw: u64,
        withdrawn: u64,
    }

    struct BorrowEvent<phantom T0, phantom T1> has copy, drop {
        strategy_id: 0x2::object::ID,
        borrow: u64,
    }

    struct DepositByAssetEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        lp_minted: u64,
    }

    public fun borrow<T0, T1>(arg0: 0x2::object::ID, arg1: u64) {
        let v0 = BorrowEvent<T0, T1>{
            strategy_id : arg0,
            borrow      : arg1,
        };
        0x2::event::emit<BorrowEvent<T0, T1>>(v0);
    }

    public(friend) fun deposit_by_asset_event<T0, T1>(arg0: u64, arg1: u64) {
        let v0 = DepositByAssetEvent<T0, T1>{
            amount    : arg0,
            lp_minted : arg1,
        };
        0x2::event::emit<DepositByAssetEvent<T0, T1>>(v0);
    }

    public(friend) fun deposit_event<T0>(arg0: u64, arg1: u64) {
        let v0 = DepositEvent<T0>{
            amount    : arg0,
            lp_minted : arg1,
        };
        0x2::event::emit<DepositEvent<T0>>(v0);
    }

    public(friend) fun strategy_loss_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StrategyLossEvent<T0>{
            strategy_id : arg0,
            to_withdraw : arg1,
            withdrawn   : arg2,
        };
        0x2::event::emit<StrategyLossEvent<T0>>(v0);
    }

    public(friend) fun strategy_profit_event<T0>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StrategyProfitEvent<T0>{
            strategy_id : arg0,
            profit      : arg1,
            fee_amt_t   : arg2,
        };
        0x2::event::emit<StrategyProfitEvent<T0>>(v0);
    }

    public(friend) fun withdraw_event<T0>(arg0: u64, arg1: u64) {
        let v0 = WithdrawEvent<T0>{
            amount    : arg0,
            lp_burned : arg1,
        };
        0x2::event::emit<WithdrawEvent<T0>>(v0);
    }

    // decompiled from Move bytecode v6
}

