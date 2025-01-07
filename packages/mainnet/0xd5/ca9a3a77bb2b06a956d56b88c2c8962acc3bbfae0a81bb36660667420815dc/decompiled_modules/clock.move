module 0xd5ca9a3a77bb2b06a956d56b88c2c8962acc3bbfae0a81bb36660667420815dc::clock {
    struct TimeEvent has copy, drop {
        timestamp_ms: u64,
    }

    public entry fun get_time(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

