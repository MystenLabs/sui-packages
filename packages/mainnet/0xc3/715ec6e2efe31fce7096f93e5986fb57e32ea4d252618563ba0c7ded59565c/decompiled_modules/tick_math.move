module 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::tick_math {
    struct Tick has copy, drop, store {
        mag: u32,
        neg: bool,
    }

    public fun add_u32(arg0: Tick, arg1: u32) : Tick {
        if (arg0.neg) {
            if (arg0.mag > arg1) {
                Tick{mag: arg0.mag - arg1, neg: true}
            } else {
                Tick{mag: arg1 - arg0.mag, neg: false}
            }
        } else {
            Tick{mag: arg0.mag + arg1, neg: false}
        }
    }

    public fun bitwise_not(arg0: Tick) : Tick {
        if (arg0.neg) {
            Tick{mag: arg0.mag - 1, neg: false}
        } else {
            Tick{mag: arg0.mag + 1, neg: true}
        }
    }

    public fun cold_tick() : Tick {
        Tick{
            mag : 2147483648,
            neg : true,
        }
    }

    public fun diff_u32(arg0: Tick, arg1: Tick) : u32 {
        assert!(ge(arg0, arg1), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::overflow());
        if (arg0.neg) {
            arg1.mag - arg0.mag
        } else if (arg1.neg) {
            arg0.mag + arg1.mag
        } else {
            arg0.mag - arg1.mag
        }
    }

    public fun ge(arg0: Tick, arg1: Tick) : bool {
        !lt(arg0, arg1)
    }

    public fun get_ratio_at_tick(arg0: Tick) : u128 {
        assert!(is_in_bounds(arg0), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::tick_out_of_bounds());
        let v0 = arg0.mag;
        let v1 = 18446744073709551616;
        if (v0 & 1 != 0) {
            v1 = 18419115400608638658;
        };
        if (v0 & 2 != 0) {
            v1 = mul_shift_64(v1, 18391528108445969703);
        };
        if (v0 & 4 != 0) {
            v1 = mul_shift_64(v1, 18336477419114433396);
        };
        if (v0 & 8 != 0) {
            v1 = mul_shift_64(v1, 18226869890870665593);
        };
        if (v0 & 16 != 0) {
            v1 = mul_shift_64(v1, 18009616477100071088);
        };
        if (v0 & 32 != 0) {
            v1 = mul_shift_64(v1, 17582847377087825313);
        };
        if (v0 & 64 != 0) {
            v1 = mul_shift_64(v1, 16759408633341240198);
        };
        if (v0 & 128 != 0) {
            v1 = mul_shift_64(v1, 15226414841393184936);
        };
        if (v0 & 256 != 0) {
            v1 = mul_shift_64(v1, 12568272644527235157);
        };
        if (v0 & 512 != 0) {
            v1 = mul_shift_64(v1, 8563108841104354677);
        };
        if (v0 & 1024 != 0) {
            v1 = mul_shift_64(v1, 3975055583337633975);
        };
        if (v0 & 2048 != 0) {
            v1 = mul_shift_64(v1, 856577552520149366);
        };
        if (v0 & 4096 != 0) {
            v1 = mul_shift_64(v1, 39775317560084773);
        };
        if (v0 & 8192 != 0) {
            v1 = mul_shift_64(v1, 85764505686420);
        };
        let v2 = 0;
        if (!arg0.neg) {
            let v3 = 340282366920938463463374607431768211455 / v1;
            v1 = v3;
            if (v3 % 65536 != 0) {
                v2 = 1;
            };
        };
        (v1 >> 16) + v2
    }

    public fun get_tick_at_ratio(arg0: u128) : (Tick, u128) {
        assert!(arg0 >= 6093 && arg0 <= 13002088162051014298412982, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::tick_ratio_out_of_bounds());
        let v0 = arg0 < 281474976710656;
        let v1 = if (v0) {
            0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(281474976710656, 10000000000000, arg0)
        } else {
            0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0, 10000000000000, 281474976710656)
        };
        let v2 = v1;
        let v3 = 0;
        let v4 = v3;
        if (v1 >= 2150859953785115391) {
            v4 = v3 | 8192;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v1, 10000000000000, 2150859953785115391);
        };
        if (v2 >= 4637736467054931) {
            v4 = v4 | 4096;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 4637736467054931);
        };
        if (v2 >= 215354044936586) {
            v4 = v4 | 2048;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 215354044936586);
        };
        if (v2 >= 46406254420777) {
            v4 = v4 | 1024;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 46406254420777);
        };
        if (v2 >= 21542110950596) {
            v4 = v4 | 512;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 21542110950596);
        };
        if (v2 >= 14677230989051) {
            v4 = v4 | 256;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 14677230989051);
        };
        if (v2 >= 12114962232319) {
            v4 = v4 | 128;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 12114962232319);
        };
        if (v2 >= 11006798913544) {
            v4 = v4 | 64;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 11006798913544);
        };
        if (v2 >= 10491329235871) {
            v4 = v4 | 32;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 10491329235871);
        };
        if (v2 >= 10242718992470) {
            v4 = v4 | 16;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 10242718992470);
        };
        if (v2 >= 10120631893548) {
            v4 = v4 | 8;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 10120631893548);
        };
        if (v2 >= 10060135135051) {
            v4 = v4 | 4;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 10060135135051);
        };
        if (v2 >= 10030022500000) {
            v4 = v4 | 2;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 10030022500000);
        };
        if (v2 >= 10015000000000) {
            v4 = v4 | 1;
            v2 = 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(v2, 10000000000000, 10015000000000);
        };
        let v5 = Tick{
            mag : v4,
            neg : false,
        };
        let (v6, v7) = if (v0) {
            (bitwise_not(v5), 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0, v2, 10015000000000))
        } else {
            (v5, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::math::mul_div_u128(arg0, 10000000000000, v2))
        };
        assert!(v7 <= arg0, 0xc3715ec6e2efe31fce7096f93e5986fb57e32ea4d252618563ba0c7ded59565c::errors::tick_invalid_perfect_ratio());
        (v6, v7)
    }

    public fun gt(arg0: Tick, arg1: Tick) : bool {
        !le(arg0, arg1)
    }

    public fun is_cold(arg0: Tick) : bool {
        arg0.mag == 2147483648 && arg0.neg
    }

    public fun is_in_bounds(arg0: Tick) : bool {
        arg0.mag <= 16383
    }

    public fun is_negative(arg0: Tick) : bool {
        arg0.neg
    }

    public fun le(arg0: Tick, arg1: Tick) : bool {
        lt(arg0, arg1) || arg0 == arg1
    }

    public fun lt(arg0: Tick, arg1: Tick) : bool {
        arg0.neg != arg1.neg && arg0.neg || arg0.neg && arg0.mag > arg1.mag || arg0.mag < arg1.mag
    }

    public fun mag(arg0: Tick) : u32 {
        arg0.mag
    }

    public fun max_ratio_x48() : u128 {
        13002088162051014298412982
    }

    public fun max_tick() : Tick {
        Tick{
            mag : 16383,
            neg : false,
        }
    }

    public fun min_ratio_x48() : u128 {
        6093
    }

    public fun min_tick() : Tick {
        Tick{
            mag : 16383,
            neg : true,
        }
    }

    fun mul_shift_64(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) >> 64) as u128)
    }

    public fun shift() : u8 {
        48
    }

    public fun tick(arg0: u32, arg1: bool) : Tick {
        let v0 = arg1 && arg0 != 0;
        Tick{
            mag : arg0,
            neg : v0,
        }
    }

    public fun tick_spacing() : u128 {
        10015
    }

    public fun zero_tick() : Tick {
        Tick{
            mag : 0,
            neg : false,
        }
    }

    public fun zero_tick_scaled_ratio() : u128 {
        281474976710656
    }

    // decompiled from Move bytecode v7
}

