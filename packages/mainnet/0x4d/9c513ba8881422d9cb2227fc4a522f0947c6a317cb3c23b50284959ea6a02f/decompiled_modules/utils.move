module 0x9889e6e46d0850e8fa820954dbb8a48702677ed02ad4c467c45790d3a062dac0::utils {
    struct ClockTimeEvent {
        timestamp: u64,
    }

    struct TimeEvent has copy, drop, store {
        timestamp_ms: u64,
    }

    public fun check_amount_threshold<T0>(arg0: 0x2::coin::Coin<T0>, arg1: u64) : 0x2::coin::Coin<T0> {
        assert!(0x2::coin::value<T0>(&arg0) >= arg1, 7001);
        arg0
    }

    public fun div(arg0: u64, arg1: u64) : u64 {
        arg0 / arg1
    }

    public entry fun emit_timestamp(arg0: &0x2::clock::Clock) {
        let v0 = TimeEvent{timestamp_ms: 0x2::clock::timestamp_ms(arg0)};
        0x2::event::emit<TimeEvent>(v0);
    }

    public fun mul(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1
    }

    public fun now_ms(arg0: &0x2::clock::Clock) : u64 {
        0x2::clock::timestamp_ms(arg0)
    }

    public fun partition_amount(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 100
    }

    public fun plus(arg0: u64, arg1: u64) : u64 {
        arg0 + arg1
    }

    public fun sub(arg0: u64, arg1: u64) : u64 {
        arg0 - arg1
    }

    public fun sum(arg0: &vector<u64>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v1);
            v1 = v1 + 1;
        };
        v0
    }

    // decompiled from Move bytecode v6
}

