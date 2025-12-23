module 0xb277007a4c82616305b082775b5e504dc39f08361d1a11ada14dc782c54a0eb1::check_time {
    struct TimeEvent has copy, drop {
        time: u64,
    }

    public fun check_time(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = TimeEvent{time: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

