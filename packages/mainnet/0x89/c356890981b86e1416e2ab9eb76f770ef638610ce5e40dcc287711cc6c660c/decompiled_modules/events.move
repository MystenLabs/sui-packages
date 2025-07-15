module 0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::events {
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

    public fun emit_rebalanced<T0>(arg0: &0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::registry::Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u32, arg9: u32, arg10: u32, arg11: u32, arg12: u128, arg13: u128) {
        0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::registry::assert_witness<T0>(arg0);
        let v0 = Rebalanced{
            pool_id             : arg1,
            old_position_id     : arg2,
            new_position_id     : arg3,
            old_amount_x        : arg4,
            old_amount_y        : arg5,
            new_amount_x        : arg6,
            new_amount_y        : arg7,
            old_lower_tick_bits : arg8,
            old_upper_tick_bits : arg9,
            new_lower_tick_bits : arg10,
            new_upper_tick_bits : arg11,
            old_liquidity       : arg12,
            new_liquidity       : arg13,
        };
        0x2::event::emit<Rebalanced>(v0);
    }

    public fun emit_zapped_in<T0>(arg0: &0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::registry::Registry, arg1: 0x2::object::ID, arg2: 0x2::object::ID, arg3: u64, arg4: u64) {
        0x89c356890981b86e1416e2ab9eb76f770ef638610ce5e40dcc287711cc6c660c::registry::assert_witness<T0>(arg0);
        let v0 = ZappedIn{
            pool_id     : arg1,
            position_id : arg2,
            amount_x    : arg3,
            amount_y    : arg4,
        };
        0x2::event::emit<ZappedIn>(v0);
    }

    // decompiled from Move bytecode v6
}

