module 0x5cfbfe7d863268b59dd7d1996185485ecedb23e0c5bf02c4f0407fad23ab0a0f::events {
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

    public fun emit_rebalanced(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u32, arg8: u32, arg9: u32, arg10: u32, arg11: u128, arg12: u128) {
        let v0 = Rebalanced{
            pool_id             : arg0,
            old_position_id     : arg1,
            new_position_id     : arg2,
            old_amount_x        : arg3,
            old_amount_y        : arg4,
            new_amount_x        : arg5,
            new_amount_y        : arg6,
            old_lower_tick_bits : arg7,
            old_upper_tick_bits : arg8,
            new_lower_tick_bits : arg9,
            new_upper_tick_bits : arg10,
            old_liquidity       : arg11,
            new_liquidity       : arg12,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun emit_zapped_in(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64) {
        let v0 = ZappedIn{
            pool_id     : arg0,
            position_id : arg1,
            amount_x    : arg2,
            amount_y    : arg3,
        };
        0x2::event::emit<ZappedIn>(v0);
    }

    // decompiled from Move bytecode v6
}

