module 0x535a5b6ed844e0b67b2f5e75acb9118e79e096bf3747ba0c6c145f0273398001::clock {
    struct TimeEvent has copy, drop {
        timestamp_ms: u64,
    }

    public entry fun get_time(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

