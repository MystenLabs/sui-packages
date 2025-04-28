module 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::flow_limiter {
    struct FlowLimiter has store {
        flow_delta: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_update: u64,
        max_rate: u64,
        window_duration: u64,
    }

    public(friend) fun check_and_update(arg0: &mut FlowLimiter, arg1: u64, arg2: &0x2::clock::Clock) {
        if (arg0.max_rate == 0) {
            return
        };
        let v0 = 0x2::clock::timestamp_ms(arg2);
        if (arg0.last_update != 0) {
            let v1 = v0 - arg0.last_update;
            let v2 = if (v1 >= arg0.window_duration) {
                0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
            } else {
                0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::min(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(v1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0.window_duration))))
            };
            arg0.flow_delta = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0.flow_delta, v2);
        };
        arg0.flow_delta = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::add(arg0.flow_delta, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg1));
        assert!(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::to_u64(arg0.flow_delta) <= arg0.max_rate, 13906834436336386049);
        arg0.last_update = v0;
    }

    public(friend) fun new(arg0: u64, arg1: u64, arg2: &0x2::clock::Clock) : FlowLimiter {
        FlowLimiter{
            flow_delta      : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            last_update     : 0x2::clock::timestamp_ms(arg2),
            max_rate        : arg0,
            window_duration : arg1,
        }
    }

    public(friend) fun update_config(arg0: &mut FlowLimiter, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        arg0.max_rate = arg1;
        arg0.window_duration = arg2;
        arg0.last_update = 0x2::clock::timestamp_ms(arg3);
    }

    // decompiled from Move bytecode v6
}

