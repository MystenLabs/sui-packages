module 0xc5e95051a7fb49b09c0b545e08c0da16cb19fff9ac9be844b6ee46fdfc487639::events_v2 {
    struct NewStakePositionEvent has copy, drop {
        farm_id: 0x2::object::ID,
        balance: u256,
        liquidity: u128,
        tick_lower_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
        tick_upper_index: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32,
    }

    public fun emit_new_stake_position_event_v2(arg0: 0x2::object::ID, arg1: u256, arg2: u128, arg3: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32, arg4: 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::i32::I32) {
        let v0 = NewStakePositionEvent{
            farm_id          : arg0,
            balance          : arg1,
            liquidity        : arg2,
            tick_lower_index : arg3,
            tick_upper_index : arg4,
        };
        0x2::event::emit<NewStakePositionEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

