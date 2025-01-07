module 0x59ce9ba6f3e67294630a80f46693f6c9e1a356bd3c5928652c7dac96ad24f467::clock {
    struct TimeEvent has copy, drop {
        timestamp_ms: u64,
    }

    public entry fun get_time(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

