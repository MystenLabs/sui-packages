module 0xb780bb84f7d370948b5a501ee4d4328804a9b51d7b86c67b7ad2fd4705c45f96::bluefin_adapter_event {
    struct NewBluefinVaultEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct NewBluefinPositionEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct BluefinSwapEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        input_amount1: u64,
        input_amount2: u64,
        output_amount1: u64,
        output_amount2: u64,
    }

    struct BluefinAddLiquidityEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        input_amount1: u64,
        input_amount2: u64,
        liquidity_changed: u128,
        current_liquidity: u128,
    }

    struct BluefinRemoveLiquidityEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        output_amount1: u64,
        output_amount2: u64,
        liquidity_changed: u128,
        current_liquidity: u128,
    }

    struct BluefinCollectFeeEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount1: u64,
        amount2: u64,
    }

    struct BluefinClaimEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    public fun add_liquidity_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128) {
        let v0 = BluefinAddLiquidityEvent<T0, T1>{
            vault_id          : arg0,
            pool_id           : arg1,
            input_amount1     : arg2,
            input_amount2     : arg3,
            liquidity_changed : arg4,
            current_liquidity : arg5,
        };
        0x2::event::emit<BluefinAddLiquidityEvent<T0, T1>>(v0);
    }

    public fun claim_event<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = BluefinClaimEvent<T0, T1, T2>{
            vault_id : arg0,
            pool_id  : arg1,
            amount   : arg2,
        };
        0x2::event::emit<BluefinClaimEvent<T0, T1, T2>>(v0);
    }

    public fun collect_fee_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = BluefinCollectFeeEvent<T0, T1>{
            vault_id : arg0,
            pool_id  : arg1,
            amount1  : arg2,
            amount2  : arg3,
        };
        0x2::event::emit<BluefinCollectFeeEvent<T0, T1>>(v0);
    }

    public fun new_bluefin_position_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u32, arg3: u32) {
        let v0 = NewBluefinPositionEvent<T0, T1>{
            vault_id   : arg0,
            pool_id    : arg1,
            tick_lower : arg2,
            tick_upper : arg3,
        };
        0x2::event::emit<NewBluefinPositionEvent<T0, T1>>(v0);
    }

    public fun new_bluefin_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewBluefinVaultEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewBluefinVaultEvent>(v0);
    }

    public fun remove_liquidity_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128) {
        let v0 = BluefinRemoveLiquidityEvent<T0, T1>{
            vault_id          : arg0,
            pool_id           : arg1,
            output_amount1    : arg2,
            output_amount2    : arg3,
            liquidity_changed : arg4,
            current_liquidity : arg5,
        };
        0x2::event::emit<BluefinRemoveLiquidityEvent<T0, T1>>(v0);
    }

    public fun swap_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = BluefinSwapEvent<T0, T1>{
            vault_id       : arg0,
            input_amount1  : arg1,
            input_amount2  : arg2,
            output_amount1 : arg3,
            output_amount2 : arg4,
        };
        0x2::event::emit<BluefinSwapEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v7
}

