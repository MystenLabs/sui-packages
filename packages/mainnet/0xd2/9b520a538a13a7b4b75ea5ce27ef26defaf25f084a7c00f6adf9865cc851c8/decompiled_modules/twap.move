module 0xd29b520a538a13a7b4b75ea5ce27ef26defaf25f084a7c00f6adf9865cc851c8::twap {
    struct Observation has copy, drop, store {
        price: u64,
        ts_ms: u64,
    }

    struct TwapBuffer has store {
        observations: vector<Observation>,
        window_ms: u64,
        capacity: u64,
        u64_padding: vector<u64>,
    }

    public fun length(arg0: &TwapBuffer) : u64 {
        0x1::vector::length<Observation>(&arg0.observations)
    }

    public fun is_empty(arg0: &TwapBuffer) : bool {
        0x1::vector::is_empty<Observation>(&arg0.observations)
    }

    public fun calculate(arg0: &TwapBuffer, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<Observation>(&arg0.observations);
        assert!(v0 > 0, 1202);
        assert!(arg1 >= 0x1::vector::borrow<Observation>(&arg0.observations, v0 - 1).ts_ms, 1201);
        if (v0 == 1) {
            return 0x1::vector::borrow<Observation>(&arg0.observations, 0).price
        };
        let v1 = if (arg1 > arg0.window_ms) {
            arg1 - arg0.window_ms
        } else {
            0
        };
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0x1::vector::borrow<Observation>(&arg0.observations, v4);
            let v6 = if (v4 + 1 < v0) {
                0x1::vector::borrow<Observation>(&arg0.observations, v4 + 1).ts_ms
            } else if (arg1 >= v5.ts_ms) {
                arg1
            } else {
                v5.ts_ms
            };
            let v7 = if (v5.ts_ms >= v1) {
                v5.ts_ms
            } else {
                v1
            };
            let v8 = if (v6 > v7) {
                ((v6 - v7) as u128)
            } else {
                0
            };
            v2 = v2 + (v5.price as u128) * v8;
            v3 = v3 + v8;
            v4 = v4 + 1;
        };
        if (v3 == 0) {
            return 0x1::vector::borrow<Observation>(&arg0.observations, v0 - 1).price
        };
        ((v2 / v3) as u64)
    }

    public fun calculate_mark_price(arg0: &TwapBuffer, arg1: u64, arg2: u64) : u64 {
        if (!is_fresh(arg0, arg2)) {
            return arg1
        };
        ((((arg1 as u128) + (calculate(arg0, arg2) as u128)) / 2) as u64)
    }

    public fun capacity(arg0: &TwapBuffer) : u64 {
        arg0.capacity
    }

    public fun consume(arg0: TwapBuffer) {
        let TwapBuffer {
            observations : _,
            window_ms    : _,
            capacity     : _,
            u64_padding  : _,
        } = arg0;
    }

    public fun coverage_ms(arg0: &TwapBuffer, arg1: u64) : u64 {
        if (0x1::vector::length<Observation>(&arg0.observations) < 2) {
            return 0
        };
        let v0 = 0x1::vector::borrow<Observation>(&arg0.observations, 0).ts_ms;
        let v1 = if (arg1 > arg0.window_ms) {
            arg1 - arg0.window_ms
        } else {
            0
        };
        let v2 = if (v0 >= v1) {
            v0
        } else {
            v1
        };
        if (arg1 > v2) {
            arg1 - v2
        } else {
            0
        }
    }

    public fun is_fresh(arg0: &TwapBuffer, arg1: u64) : bool {
        let v0 = 0x1::vector::length<Observation>(&arg0.observations);
        if (v0 == 0) {
            return false
        };
        let v1 = 0x1::vector::borrow<Observation>(&arg0.observations, v0 - 1).ts_ms;
        arg1 >= v1 && arg1 - v1 <= arg0.window_ms
    }

    public fun is_usable(arg0: &TwapBuffer, arg1: u64, arg2: u64) : bool {
        is_fresh(arg0, arg1) && coverage_ms(arg0, arg1) >= arg2
    }

    public fun new(arg0: u64, arg1: u64) : TwapBuffer {
        assert!(arg0 > 0, 1200);
        assert!(arg1 >= 2 && arg1 <= 1024, 1200);
        TwapBuffer{
            observations : 0x1::vector::empty<Observation>(),
            window_ms    : arg0,
            capacity     : arg1,
            u64_padding  : vector[],
        }
    }

    public fun observation_at(arg0: &TwapBuffer, arg1: u64) : (u64, u64) {
        let v0 = 0x1::vector::borrow<Observation>(&arg0.observations, arg1);
        (v0.price, v0.ts_ms)
    }

    fun prune(arg0: &mut TwapBuffer, arg1: u64) {
        let v0 = if (arg1 > arg0.window_ms) {
            arg1 - arg0.window_ms
        } else {
            0
        };
        while (0x1::vector::length<Observation>(&arg0.observations) > 1) {
            if (0x1::vector::borrow<Observation>(&arg0.observations, 1).ts_ms > v0) {
                break
            };
            0x1::vector::remove<Observation>(&mut arg0.observations, 0);
        };
        while (0x1::vector::length<Observation>(&arg0.observations) > arg0.capacity) {
            0x1::vector::remove<Observation>(&mut arg0.observations, 0);
        };
    }

    public fun record(arg0: &mut TwapBuffer, arg1: u64, arg2: u64) {
        assert!(arg1 != 0, 1302);
        let v0 = 0x1::vector::length<Observation>(&arg0.observations);
        if (v0 > 0) {
            let v1 = 0x1::vector::borrow<Observation>(&arg0.observations, v0 - 1).ts_ms;
            assert!(arg2 >= v1, 1201);
            if (arg2 == v1) {
                0x1::vector::borrow_mut<Observation>(&mut arg0.observations, v0 - 1).price = arg1;
                return
            };
            if (arg2 - v1 > arg0.window_ms) {
                arg0.observations = 0x1::vector::empty<Observation>();
            };
        };
        let v2 = Observation{
            price : arg1,
            ts_ms : arg2,
        };
        0x1::vector::push_back<Observation>(&mut arg0.observations, v2);
        prune(arg0, arg2);
    }

    public fun window_ms(arg0: &TwapBuffer) : u64 {
        arg0.window_ms
    }

    // decompiled from Move bytecode v7
}

