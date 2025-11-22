module 0x279e6fd888d58959ae16f7f75ae6d457db088440f4b3f08b3411946c8c344986::momentum_adapter_event {
    struct NewMomentumVaultEvent has copy, drop {
        id: 0x2::object::ID,
        of: 0x2::object::ID,
    }

    struct NewMomentumPositionEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        tick_lower: u32,
        tick_upper: u32,
    }

    struct MomentumSwapEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        input_amount1: u64,
        input_amount2: u64,
        output_amount1: u64,
        output_amount2: u64,
    }

    struct MomentumAddLiquidityEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        input_amount1: u64,
        input_amount2: u64,
        liquidity_changed: u128,
        current_liquidity: u128,
    }

    struct MomentumRemoveLiquidityEvent<phantom T0, phantom T1> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        output_amount1: u64,
        output_amount2: u64,
        liquidity_changed: u128,
        current_liquidity: u128,
    }

    struct MomentumClaimEvent<phantom T0, phantom T1, phantom T2> has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        amount: u64,
    }

    public fun add_liquidity_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128) {
        let v0 = MomentumAddLiquidityEvent<T0, T1>{
            vault_id          : arg0,
            pool_id           : arg1,
            input_amount1     : arg2,
            input_amount2     : arg3,
            liquidity_changed : arg4,
            current_liquidity : arg5,
        };
        0x2::event::emit<MomentumAddLiquidityEvent<T0, T1>>(v0);
    }

    public fun claim_event<T0, T1, T2>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = MomentumClaimEvent<T0, T1, T2>{
            vault_id : arg0,
            pool_id  : arg1,
            amount   : arg2,
        };
        0x2::event::emit<MomentumClaimEvent<T0, T1, T2>>(v0);
    }

    public fun new_momentum_position_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u32, arg3: u32) {
        let v0 = NewMomentumPositionEvent<T0, T1>{
            vault_id   : arg0,
            pool_id    : arg1,
            tick_lower : arg2,
            tick_upper : arg3,
        };
        0x2::event::emit<NewMomentumPositionEvent<T0, T1>>(v0);
    }

    public fun new_momentum_vault_event(arg0: 0x2::object::ID, arg1: 0x2::object::ID) {
        let v0 = NewMomentumVaultEvent{
            id : arg0,
            of : arg1,
        };
        0x2::event::emit<NewMomentumVaultEvent>(v0);
    }

    public fun remove_liquidity_event<T0, T1>(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u128, arg5: u128) {
        let v0 = MomentumRemoveLiquidityEvent<T0, T1>{
            vault_id          : arg0,
            pool_id           : arg1,
            output_amount1    : arg2,
            output_amount2    : arg3,
            liquidity_changed : arg4,
            current_liquidity : arg5,
        };
        0x2::event::emit<MomentumRemoveLiquidityEvent<T0, T1>>(v0);
    }

    public fun swap_event<T0, T1>(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = MomentumSwapEvent<T0, T1>{
            vault_id       : arg0,
            input_amount1  : arg1,
            input_amount2  : arg2,
            output_amount1 : arg3,
            output_amount2 : arg4,
        };
        0x2::event::emit<MomentumSwapEvent<T0, T1>>(v0);
    }

    // decompiled from Move bytecode v6
}

