module 0x5dbe7ac885a796a823c7241d190e6a0aa7404b30848465cafa226acccbe01fec::event {
    struct DepositEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        st_minted: u64,
    }

    struct WithdrawEvent<phantom T0, phantom T1> has copy, drop {
        amount: u64,
        st_burned: u64,
    }

    struct StrategyProfitEvent<phantom T0, phantom T1> has copy, drop {
        strategy_id: 0x2::object::ID,
        profit: u64,
        fee_amt_st: u64,
    }

    struct StrategyLossEvent<phantom T0, phantom T1> has copy, drop {
        strategy_id: 0x2::object::ID,
        to_withdraw: u64,
        withdrawn: u64,
    }

    public fun deposit<T0, T1>(arg0: u64, arg1: u64) {
        let v0 = DepositEvent<T0, T1>{
            amount    : arg0,
            st_minted : arg1,
        };
        0x2::event::emit<DepositEvent<T0, T1>>(v0);
    }

    public fun strategy_loss<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StrategyLossEvent<T0, T1>{
            strategy_id : arg0,
            to_withdraw : arg1,
            withdrawn   : arg2,
        };
        0x2::event::emit<StrategyLossEvent<T0, T1>>(v0);
    }

    public fun strategy_profit<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = StrategyProfitEvent<T0, T1>{
            strategy_id : arg0,
            profit      : arg1,
            fee_amt_st  : arg2,
        };
        0x2::event::emit<StrategyProfitEvent<T0, T1>>(v0);
    }

    public fun withdraw<T0, T1>(arg0: u64, arg1: u64) {
        let v0 = WithdrawEvent<T0, T1>{
            amount    : arg0,
            st_burned : arg1,
        };
        0x2::event::emit<WithdrawEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

