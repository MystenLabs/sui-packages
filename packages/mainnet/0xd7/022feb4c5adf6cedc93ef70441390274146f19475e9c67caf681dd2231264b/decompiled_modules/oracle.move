module 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::oracle {
    struct Observation has copy, drop, store {
        timestamp_s: u64,
        tick_cumulative: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::I64,
        seconds_per_liquidity_cumulative: u256,
        initialized: bool,
    }

    public fun binary_search(arg0: &vector<Observation>, arg1: u64, arg2: u64, arg3: u64) : (Observation, Observation) {
        let v0 = (arg2 + 1) % arg3;
        let v1 = v0 + arg3 - 1;
        default();
        default();
        let v2;
        let v3;
        loop {
            let v4 = (v0 + v1) / 2;
            v2 = try_get_observation(arg0, v4 % arg3);
            if (!v2.initialized) {
                v0 = v4 + 1;
                continue
            };
            v3 = try_get_observation(arg0, (v4 + 1) % arg3);
            if (v2.timestamp_s <= arg1 && arg1 <= v3.timestamp_s) {
                break
            };
            if (v2.timestamp_s < arg1) {
                v0 = v4 + 1;
                continue
            };
            v1 = v4 - 1;
        };
        (v2, v3)
    }

    fun default() : Observation {
        Observation{
            timestamp_s                      : 0,
            tick_cumulative                  : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::zero(),
            seconds_per_liquidity_cumulative : 0,
            initialized                      : false,
        }
    }

    public fun get_surrounding_observations(arg0: &vector<Observation>, arg1: u64, arg2: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32, arg3: u64, arg4: u128, arg5: u64) : (Observation, Observation) {
        let v0 = try_get_observation(arg0, arg3);
        if (v0.timestamp_s <= arg1) {
            if (v0.timestamp_s == arg1) {
                return (v0, default())
            };
            return (v0, transform(&v0, arg1, arg2, arg4))
        };
        v0 = try_get_observation(arg0, (arg3 + 1) % arg5);
        if (!v0.initialized) {
            v0 = *0x1::vector::borrow<Observation>(arg0, 0);
        };
        assert!(v0.timestamp_s <= arg1, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::invalid_observation_timestamp());
        binary_search(arg0, arg1, arg3, arg5)
    }

    public fun grow(arg0: &mut vector<Observation>, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0 && arg2 < 1000, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::grow_obs_check_failed());
        if (arg2 <= arg1) {
            return arg1
        };
        while (arg1 < arg2) {
            let v0 = Observation{
                timestamp_s                      : 1,
                tick_cumulative                  : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::zero(),
                seconds_per_liquidity_cumulative : 0,
                initialized                      : false,
            };
            0x1::vector::push_back<Observation>(arg0, v0);
            arg1 = arg1 + 1;
        };
        arg2
    }

    public fun initialize(arg0: &mut vector<Observation>, arg1: u64) : (u64, u64) {
        let v0 = Observation{
            timestamp_s                      : arg1,
            tick_cumulative                  : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::zero(),
            seconds_per_liquidity_cumulative : 0,
            initialized                      : true,
        };
        0x1::vector::push_back<Observation>(arg0, v0);
        (1, 1)
    }

    public fun is_initialized(arg0: &Observation) : bool {
        arg0.initialized
    }

    public fun observe(arg0: &vector<Observation>, arg1: u64, arg2: vector<u64>, arg3: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32, arg4: u64, arg5: u128, arg6: u64) : (vector<0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::I64>, vector<u256>) {
        assert!(arg6 > 0, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::error::observe_checks());
        let v0 = 0x1::vector::empty<u256>();
        let v1 = 0x1::vector::empty<0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::I64>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg2)) {
            let (v3, v4) = observe_single(arg0, arg1, *0x1::vector::borrow<u64>(&arg2, v2), arg3, arg4, arg5, arg6);
            0x1::vector::push_back<0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::I64>(&mut v1, v3);
            0x1::vector::push_back<u256>(&mut v0, v4);
            v2 = v2 + 1;
        };
        (v1, v0)
    }

    public fun observe_single(arg0: &vector<Observation>, arg1: u64, arg2: u64, arg3: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32, arg4: u64, arg5: u128, arg6: u64) : (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::I64, u256) {
        if (arg2 == 0) {
            let v0 = try_get_observation(arg0, arg4);
            if (v0.timestamp_s != arg1) {
                let v1 = &v0;
                v0 = transform(v1, arg1, arg3, arg5);
            };
            return (v0.tick_cumulative, v0.seconds_per_liquidity_cumulative)
        };
        let v2 = arg1 - arg2;
        let (v3, v4) = get_surrounding_observations(arg0, v2, arg3, arg4, arg5, arg6);
        let v5 = v4;
        let v6 = v3;
        if (v2 == v6.timestamp_s) {
            (v6.tick_cumulative, v6.seconds_per_liquidity_cumulative)
        } else if (v2 == v5.timestamp_s) {
            (v5.tick_cumulative, v5.seconds_per_liquidity_cumulative)
        } else {
            let v9 = v5.timestamp_s - v6.timestamp_s;
            let v10 = v2 - v6.timestamp_s;
            (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::add(v6.tick_cumulative, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::mul(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::div(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::sub(v5.tick_cumulative, v6.tick_cumulative), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::from(v9)), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::from(v10))), v6.seconds_per_liquidity_cumulative + (v5.seconds_per_liquidity_cumulative - v6.seconds_per_liquidity_cumulative) * (v10 as u256) / (v9 as u256))
        }
    }

    public fun seconds_per_liquidity_cumulative(arg0: &Observation) : u256 {
        arg0.seconds_per_liquidity_cumulative
    }

    public fun tick_cumulative(arg0: &Observation) : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::I64 {
        arg0.tick_cumulative
    }

    public fun timestamp_s(arg0: &Observation) : u64 {
        arg0.timestamp_s
    }

    public fun transform(arg0: &Observation, arg1: u64, arg2: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32, arg3: u128) : Observation {
        let v0 = if (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::is_neg(arg2)) {
            0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::neg_from((0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::abs_u32(arg2) as u64))
        } else {
            0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::from((0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::abs_u32(arg2) as u64))
        };
        let v1 = arg1 - arg0.timestamp_s;
        let v2 = if (arg3 == 0) {
            1
        } else {
            arg3
        };
        Observation{
            timestamp_s                      : arg1,
            tick_cumulative                  : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::add(arg0.tick_cumulative, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::mul(v0, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i64::from(v1))),
            seconds_per_liquidity_cumulative : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::math_u256::overflow_add(arg0.seconds_per_liquidity_cumulative, ((v1 as u256) << 128) / (v2 as u256)),
            initialized                      : true,
        }
    }

    fun try_get_observation(arg0: &vector<Observation>, arg1: u64) : Observation {
        if (arg1 > 0x1::vector::length<Observation>(arg0) - 1) {
            default()
        } else {
            *0x1::vector::borrow<Observation>(arg0, arg1)
        }
    }

    public fun write(arg0: &mut vector<Observation>, arg1: u64, arg2: u64, arg3: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32, arg4: u128, arg5: u64, arg6: u64) : (u64, u64) {
        let v0 = 0x1::vector::borrow<Observation>(arg0, arg1);
        if (v0.timestamp_s == arg2) {
            return (arg1, arg5)
        };
        let v1 = if (arg6 > arg5 && arg1 == arg5 - 1) {
            arg6
        } else {
            arg5
        };
        let v2 = (arg1 + 1) % v1;
        *0x1::vector::borrow_mut<Observation>(arg0, v2) = transform(v0, arg2, arg3, arg4);
        (v2, v1)
    }

    // decompiled from Move bytecode v6
}

