module 0x29f3354d23d5ae39515a37c39ffec3b5af0a11ab0b9c20dc314b2f632403f29f::turbos_tick_scanner {
    struct TickIdEvent has copy, drop, store {
        tick_index: 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32,
        tick_id: 0x2::object::ID,
    }

    public entry fun emit_tick_id<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: u32) {
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(arg1);
        let v1 = TickIdEvent{
            tick_index : v0,
            tick_id    : 0x2::object::id<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Tick>(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, v0)),
        };
        0x2::event::emit<TickIdEvent>(v1);
    }

    // decompiled from Move bytecode v6
}

