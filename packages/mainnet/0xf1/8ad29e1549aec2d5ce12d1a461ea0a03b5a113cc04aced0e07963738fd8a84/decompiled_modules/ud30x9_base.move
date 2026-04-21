module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9_base {
    public fun abs(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        arg0
    }

    public fun add(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        wrap_u256((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) + (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1) as u256))
    }

    public fun and(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: u128) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) & arg1)
    }

    public fun and2(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) & 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1))
    }

    public fun ceil(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256);
        let v1 = 1000000000;
        let v2 = v0 % v1;
        if (v2 == 0) {
            arg0
        } else {
            wrap_u256(v0 - v2 + v1)
        }
    }

    public fun div(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        div_trunc(arg0, arg1)
    }

    public fun div_away(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1) as u256);
        assert!(v0 != 0, 13835622723222765573);
        wrap_u256(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::div_away_u256((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) * 1000000000, v0))
    }

    public fun div_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1) as u256);
        assert!(v0 != 0, 13835622615848583173);
        wrap_u256((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) * 1000000000 / v0)
    }

    public fun eq(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) == 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1)
    }

    public fun floor(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        let v1 = v0 % 1000000000;
        if (v1 == 0) {
            arg0
        } else {
            0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(v0 - v1)
        }
    }

    public fun gt(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) > 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1)
    }

    public fun gte(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) >= 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1)
    }

    public fun into_SD29x9(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        assert!(v0 <= 170141183460469231731687303715884105727, 13835902669191249927);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(v0, false)
    }

    public fun is_zero(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) == 0
    }

    public fun lshift(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: u8) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        assert!(arg1 < 128, 13836184887197433865);
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        assert!(v0 <= 340282366920938463463374607431768211455 >> arg1, 13835058995880001537);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(v0 << arg1)
    }

    public fun lt(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) < 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1)
    }

    public fun lte(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) <= 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1)
    }

    public fun mod(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1);
        assert!(v0 != 0, 13835622212121657349);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) % v0)
    }

    public fun mul(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        mul_trunc(arg0, arg1)
    }

    public fun mul_away(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        wrap_u256(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::div_away_u256((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) * (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1) as u256), 1000000000))
    }

    public fun mul_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        wrap_u256((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) * (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1) as u256) / 1000000000)
    }

    public fun neq(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) != 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1)
    }

    public fun not(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) ^ 340282366920938463463374607431768211455)
    }

    public fun or(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) | 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1))
    }

    public fun pow(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: u8) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        if (arg1 == 0) {
            return 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::one()
        };
        if (arg1 == 1) {
            return arg0
        };
        let v0 = 1000000000;
        let v1 = 340282366920938463463374607431768211455;
        let v2 = (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256);
        let v3 = v0;
        let v4 = arg1;
        while (v4 != 0) {
            if (v4 & 1 == 1) {
                let v5 = v3 * v2 / v0;
                v3 = v5;
                assert!(v5 <= v1, 13835059966542610433);
            };
            v4 = v4 >> 1;
            if (v4 != 0) {
                v2 = v2 * v2 / v0;
                assert!(v2 <= v1, 13835059988017446913);
            };
        };
        wrap_u256(v3)
    }

    public fun rshift(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: u8) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        assert!(arg1 < 128, 13836186119853047817);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) >> arg1)
    }

    public fun sub(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        let v1 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1);
        assert!(v0 >= v1, 13835341853836312579);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(v0 - v1)
    }

    public fun try_into_SD29x9(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0x1::option::Option<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9> {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        if (v0 > 170141183460469231731687303715884105727) {
            0x1::option::none<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9>()
        } else {
            0x1::option::some<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9>(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(v0, false))
        }
    }

    public fun unchecked_add(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap((((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) + (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1) as u256) & 340282366920938463463374607431768211455) as u128))
    }

    public fun unchecked_lshift(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: u8) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        if (arg1 >= 128) {
            return 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::zero()
        };
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) << arg1)
    }

    public fun unchecked_rshift(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: u8) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        if (arg1 >= 128) {
            return 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::zero()
        };
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) >> arg1)
    }

    public fun unchecked_sub(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 340282366920938463463374607431768211455;
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap((((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) + v0 + 1 - (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1) as u256) & v0) as u128))
    }

    fun wrap_u256(arg0: u256) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        assert!(arg0 <= 340282366920938463463374607431768211455, 13835060627967574017);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap((arg0 as u128))
    }

    public fun xor(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) ^ 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1))
    }

    // decompiled from Move bytecode v7
}

