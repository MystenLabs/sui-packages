module 0xab27fec9ae69508a274eac9d8c68d6f32b3233f9b23bb974236f86fe70725826::route {
    struct Route has copy, drop {
        p: u256,
        q: u256,
        r: u256,
    }

    public fun amount(arg0: &0xab27fec9ae69508a274eac9d8c68d6f32b3233f9b23bb974236f86fe70725826::config::Config, arg1: Route, arg2: u64, arg3: u64, arg4: &0x2::tx_context::TxContext) : u64 {
        0xab27fec9ae69508a274eac9d8c68d6f32b3233f9b23bb974236f86fe70725826::config::assert_trader(arg0, arg4);
        let (v0, v1, v2) = shrink(arg1.p, arg1.q, arg1.r);
        assert!(v0 > v1, 100);
        let v3 = if (v2 == 0) {
            (arg2 as u256)
        } else {
            0x1::u256::min((sqrt(v0 * v1) - v1) / v2, (arg2 as u256))
        };
        assert!(v3 > 0 && v0 * v3 / (v1 + v2 * v3) >= v3 + (arg3 as u256), 100);
        (v3 as u64)
    }

    fun bits(arg0: u256) : u16 {
        let v0 = arg0;
        let v1 = 0;
        let v2 = v1;
        if (arg0 >> 128 > 0) {
            v0 = arg0 >> 128;
            v2 = v1 + 128;
        };
        if (v0 >> 64 > 0) {
            v0 = v0 >> 64;
            v2 = v2 + 64;
        };
        if (v0 >> 32 > 0) {
            v0 = v0 >> 32;
            v2 = v2 + 32;
        };
        if (v0 >> 16 > 0) {
            v0 = v0 >> 16;
            v2 = v2 + 16;
        };
        if (v0 >> 8 > 0) {
            v0 = v0 >> 8;
            v2 = v2 + 8;
        };
        if (v0 >> 4 > 0) {
            v0 = v0 >> 4;
            v2 = v2 + 4;
        };
        if (v0 >> 2 > 0) {
            v0 = v0 >> 2;
            v2 = v2 + 2;
        };
        if (v0 >> 1 > 0) {
            v0 = v0 >> 1;
            v2 = v2 + 1;
        };
        v2 + (v0 as u16)
    }

    public fun clmm(arg0: Route, arg1: u128, arg2: u128, arg3: bool, arg4: u64) : Route {
        assert!(arg1 > 0 && arg2 > 0, 101);
        let v0 = (arg1 as u256);
        let v1 = (arg2 as u256);
        if (arg3) {
            pool(arg0, (v1 << 64) / v0, v1 * v0 >> 64, arg4)
        } else {
            pool(arg0, v1 * v0 >> 64, (v1 << 64) / v0, arg4)
        }
    }

    public fun constant_product(arg0: Route, arg1: u64, arg2: u64, arg3: u64) : Route {
        assert!(arg1 > 0 && arg2 > 0, 101);
        pool(arg0, (arg1 as u256), (arg2 as u256), arg3)
    }

    public fun linear(arg0: Route, arg1: u64, arg2: u64) : Route {
        assert!(arg1 > 0, 101);
        then(arg0, (arg2 as u256), (arg1 as u256), 0)
    }

    public fun new() : Route {
        Route{
            p : 1,
            q : 1,
            r : 0,
        }
    }

    public fun out(arg0: &Route, arg1: u64) : u64 {
        let (v0, v1, v2) = shrink(arg0.p, arg0.q, arg0.r);
        let v3 = (arg1 as u256);
        let v4 = v0 * v3 / (v1 + v2 * v3);
        if (v4 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v4 as u64)
        }
    }

    fun pool(arg0: Route, arg1: u256, arg2: u256, arg3: u64) : Route {
        let v0 = 1000000 - (arg3 as u256);
        then(arg0, arg2 * v0, arg1 * 1000000, v0)
    }

    fun shrink(arg0: u256, arg1: u256, arg2: u256) : (u256, u256, u256) {
        let v0 = bits(0x1::u256::max(0x1::u256::max(arg0, arg1), arg2));
        if (v0 <= 126) {
            return (arg0, arg1, arg2)
        };
        let v1 = ((v0 - 126) as u8);
        let v2 = arg1 >> v1;
        let v3 = if (v2 == 0) {
            1
        } else {
            v2
        };
        (arg0 >> v1, v3, arg2 >> v1)
    }

    public fun spot(arg0: Route, arg1: u128, arg2: bool, arg3: u64) : Route {
        assert!(arg1 > 0, 101);
        let v0 = (arg1 as u256);
        let (v1, v2) = if (arg2) {
            (v0 * v0, 340282366920938463463374607431768211456)
        } else {
            (340282366920938463463374607431768211456, v0 * v0)
        };
        let (v3, v4, _) = shrink(v1, v2, 0);
        then(arg0, v3 * (1000000 - (arg3 as u256)), v4 * 1000000, 0)
    }

    fun sqrt(arg0: u256) : u256 {
        if (arg0 == 0) {
            return 0
        };
        let v0 = 1 << (((bits(arg0) + 1) / 2) as u8);
        loop {
            let v1 = v0 + arg0 / v0 >> 1;
            if (v1 >= v0) {
                break
            };
            v0 = v1;
        };
        v0
    }

    fun then(arg0: Route, arg1: u256, arg2: u256, arg3: u256) : Route {
        let (v0, v1, v2) = shrink(arg1, arg2, arg3);
        let (v3, v4, v5) = shrink(arg0.p, arg0.q, arg0.r);
        Route{
            p : v0 * v3,
            q : v1 * v4,
            r : v1 * v5 + v2 * v3,
        }
    }

    public fun widen(arg0: u64) : u128 {
        (arg0 as u128)
    }

    // decompiled from Move bytecode v7
}

