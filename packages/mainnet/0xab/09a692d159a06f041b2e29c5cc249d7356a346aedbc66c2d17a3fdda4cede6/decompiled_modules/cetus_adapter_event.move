module 0xab09a692d159a06f041b2e29c5cc249d7356a346aedbc66c2d17a3fdda4cede6::cetus_adapter_event {
    struct CetusSwapEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        input_amount1: u64,
        input_amount2: u64,
        output_amount1: u64,
        output_amount2: u64,
    }

    struct CetusAddLiquidityEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        input_amount1: u64,
        input_amount2: u64,
        liquidity_changed: u128,
        current_liquidity: u128,
    }

    struct CetusRemoveLiquidityEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        output_amount1: u64,
        output_amount2: u64,
        liquidity_changed: u128,
        current_liquidity: u128,
    }

    struct CetusClaimEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    public fun add_liquidity_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128) {
        let v0 = CetusAddLiquidityEvent<T0, T1>{
            vault_id          : arg0,
            pool_id           : arg1,
            input_amount1     : arg2,
            input_amount2     : arg3,
            liquidity_changed : arg4,
            current_liquidity : arg5,
        };
        0x2::event::emit<CetusAddLiquidityEvent<T0, T1>>(v0);
    }

    public fun claim_event<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = CetusClaimEvent<T0, T1, T2>{
            vault_id : arg0,
            pool_id  : arg1,
            amount   : arg2,
        };
        0x2::event::emit<CetusClaimEvent<T0, T1, T2>>(v0);
    }

    public fun remove_liquidity_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128) {
        let v0 = CetusRemoveLiquidityEvent<T0, T1>{
            vault_id          : arg0,
            pool_id           : arg1,
            output_amount1    : arg2,
            output_amount2    : arg3,
            liquidity_changed : arg4,
            current_liquidity : arg5,
        };
        0x2::event::emit<CetusRemoveLiquidityEvent<T0, T1>>(v0);
    }

    public fun swap_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = CetusSwapEvent<T0, T1>{
            vault_id       : arg0,
            input_amount1  : arg1,
            input_amount2  : arg2,
            output_amount1 : arg3,
            output_amount2 : arg4,
        };
        0x2::event::emit<CetusSwapEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

