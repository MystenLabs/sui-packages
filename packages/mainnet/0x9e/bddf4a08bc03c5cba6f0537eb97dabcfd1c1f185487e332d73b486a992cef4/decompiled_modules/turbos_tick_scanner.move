module 0x9ebddf4a08bc03c5cba6f0537eb97dabcfd1c1f185487e332d73b486a992cef4::turbos_tick_scanner {
    struct TickIdEvent has copy, drop, store {
        tick_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_id: 0x2::object::ID,
    }

    public entry fun emit_tick_id<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u32) {
        let v0 = if (arg1 < 2147483648) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg1)
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(4294967295 - arg1 + 1)
        };
        let v1 = TickIdEvent{
            tick_index : v0,
            tick_id    : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Tick>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v0)),
        };
        0x2::event::emit<TickIdEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

