module 0x5b292254594ef4eccaf59adca040d7b9c9340d65b246dc7d46253706b49268a7::clock {
    struct TimeEvent has copy, drop {
        timestamp_ms: u64,
    }

    public entry fun get_time(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

