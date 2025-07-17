module 0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::events {
    struct Rebalanced has copy, drop {
        pool_id: 0x2::object::ID,
        old_position_id: 0x2::object::ID,
        new_position_id: 0x2::object::ID,
        old_amount_x: u64,
        old_amount_y: u64,
        new_amount_x: u64,
        new_amount_y: u64,
        old_lower_tick_bits: u32,
        old_upper_tick_bits: u32,
        new_lower_tick_bits: u32,
        new_upper_tick_bits: u32,
        old_liquidity: u128,
        new_liquidity: u128,
    }

    struct ZappedIn has copy, drop {
        pool_id: 0x2::object::ID,
        position_id: 0x2::object::ID,
        amount_x: u64,
        amount_y: u64,
    }

    public fun emit_rebalanced<T0>(arg0: &0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u32, arg10: u32, arg11: u32, arg12: u32, arg13: u128, arg14: u128) {
        0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::registry::assert_witness<T0>(arg0);
        let v0 = Rebalanced{
            pool_id             : arg2,
            old_position_id     : arg3,
            new_position_id     : arg4,
            old_amount_x        : arg5,
            old_amount_y        : arg6,
            new_amount_x        : arg7,
            new_amount_y        : arg8,
            old_lower_tick_bits : arg9,
            old_upper_tick_bits : arg10,
            new_lower_tick_bits : arg11,
            new_upper_tick_bits : arg12,
            old_liquidity       : arg13,
            new_liquidity       : arg14,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun emit_zapped_in<T0>(arg0: &0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::registry::Registry, arg1: &T0, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        0xa7a50fcd8b3afbf1c0b518dae95bb21113f19ed0ed71de8a0d09cc260775e7ef::registry::assert_witness<T0>(arg0);
        let v0 = ZappedIn{
            pool_id     : arg2,
            position_id : arg3,
            amount_x    : arg4,
            amount_y    : arg5,
        };
        0x2::event::emit<ZappedIn>(v0);
    }

    // decompiled from Move bytecode v6
}

