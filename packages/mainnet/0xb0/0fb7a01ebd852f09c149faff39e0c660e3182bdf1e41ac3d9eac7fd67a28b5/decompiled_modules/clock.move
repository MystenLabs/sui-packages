module 0xb00fb7a01ebd852f09c149faff39e0c660e3182bdf1e41ac3d9eac7fd67a28b5::clock {
    struct TimeEvent has copy, drop {
        timestamp_ms: u64,
    }

    public entry fun get_time(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

