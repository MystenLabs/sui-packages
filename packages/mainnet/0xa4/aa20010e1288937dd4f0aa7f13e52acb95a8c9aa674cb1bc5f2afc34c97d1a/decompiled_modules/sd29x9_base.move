module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9_base {
    struct Components has copy, drop {
        neg: bool,
        mag: u256,
    }

    public fun log10(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        assert!(!v0 && v1 > 0, 13836185913694617609);
        if (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u256::is_power_of_ten(v1)) {
            let v2 = 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u256::log10(v1, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down());
            let (v3, v4) = if (v2 >= 9) {
                (false, ((v2 - 9) as u256) * 1000000000)
            } else {
                (true, ((9 - v2) as u256) * 1000000000)
            };
            let v5 = Components{
                neg : v3,
                mag : v4,
            };
            return wrap_components(v5)
        };
        let (v6, v7) = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::raw_log2((v1 as u128));
        let v8 = Components{
            neg : v6,
            mag : (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::apply_log2_factor(v7, 301029995663981195) as u256),
        };
        wrap_components(v8)
    }

    public fun sqrt(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        assert!(!v0, 13835905886121754631);
        let v2 = Components{
            neg : false,
            mag : 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u256::sqrt(v1 * 1000000000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()),
        };
        wrap_components(v2)
    }

    public fun cdf(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v2 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::cdf::cdf_nonneg_raw((v1 as u128));
        let v3 = if (v0) {
            assert!(v2 >= 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::cdf::half_raw(), 13836466310634668043);
            1000000000 - v2
        } else {
            v2
        };
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(v3, false)
    }

    public fun inverse_cdf(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        assert!(!v0, 13836748288122683405);
        let v2 = (v1 as u128);
        assert!(v2 <= 1000000000, 13836748296712617997);
        if (v2 >= 500000000) {
            0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf::inverse_cdf_upper_raw(v2), false)
        } else {
            0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf::inverse_cdf_upper_raw(1000000000 - v2), true)
        }
    }

    public fun pdf(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : _,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::pdf::pdf_nonneg_raw((v1 as u128)), false)
    }

    public fun abs(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let v0 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        v0.neg = false;
        wrap_components(v0)
    }

    public fun add(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        wrap_components(add_components(decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0)), decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1))))
    }

    fun add_components(arg0: Components, arg1: Components) : Components {
        if (arg0.neg == arg1.neg) {
            Components{neg: arg0.neg, mag: arg0.mag + arg1.mag}
        } else if (arg0.mag >= arg1.mag) {
            Components{neg: arg0.neg, mag: arg0.mag - arg1.mag}
        } else {
            Components{neg: arg1.neg, mag: arg1.mag - arg0.mag}
        }
    }

    public fun ceil(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v2 = 1000000000;
        if (v1 % v2 == 0) {
            return arg0
        };
        let v3 = if (!v0) {
            Components{neg: false, mag: (v1 / v2 + 1) * v2}
        } else {
            Components{neg: true, mag: v1 / v2 * v2}
        };
        wrap_components(v3)
    }

    fun decompose(arg0: u128) : Components {
        if (arg0 & 170141183460469231731687303715884105728 != 0) {
            Components{neg: true, mag: (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::two_complement(arg0) as u256)}
        } else {
            Components{neg: false, mag: (arg0 as u256)}
        }
    }

    public fun div(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        div_trunc(arg0, arg1)
    }

    public fun div_away(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1);
        assert!(v0 != 0, 13835624067547529221);
        let v1 = decompose(v0);
        let v2 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v3 = Components{
            neg : v2.neg != v1.neg,
            mag : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::div_away_u256(v2.mag * 1000000000, v1.mag),
        };
        wrap_components(v3)
    }

    public fun div_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1);
        assert!(v0 != 0, 13835623938698510341);
        let v1 = decompose(v0);
        let v2 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v3 = Components{
            neg : v2.neg != v1.neg,
            mag : v2.mag * 1000000000 / v1.mag,
        };
        wrap_components(v3)
    }

    public fun eq(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0) == 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1)
    }

    public fun floor(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v2 = 1000000000;
        if (v1 % v2 == 0) {
            return arg0
        };
        let v3 = if (!v0) {
            Components{neg: false, mag: v1 / v2 * v2}
        } else {
            Components{neg: true, mag: (v1 / v2 + 1) * v2}
        };
        wrap_components(v3)
    }

    fun greater_than_bits(arg0: u128, arg1: u128) : bool {
        if (arg0 == arg1) {
            return false
        };
        let v0 = decompose(arg0);
        let v1 = decompose(arg1);
        v0.neg != v1.neg && !v0.neg || !v0.neg && v0.mag > v1.mag || v0.mag < v1.mag
    }

    public fun gt(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : bool {
        greater_than_bits(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1))
    }

    public fun gte(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : bool {
        !lt(arg0, arg1)
    }

    public fun into_UD30x9(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        assert!(!v0, 13835339848086585347);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap((v1 as u128))
    }

    public fun is_negative(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0) & 170141183460469231731687303715884105728 != 0
    }

    public fun is_zero(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0) == 0
    }

    public fun ln(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        assert!(!v0 && v1 > 0, 13836185814910369801);
        let (v2, v3) = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::raw_log2((v1 as u128));
        let v4 = Components{
            neg : v2,
            mag : (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::apply_log2_factor(v3, 693147180559945309) as u256),
        };
        wrap_components(v4)
    }

    public fun log2(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        assert!(!v0 && v1 > 0, 13836186089788276745);
        let (v2, v3) = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::raw_log2((v1 as u128));
        let v4 = Components{
            neg : v2,
            mag : ((v3 / 1000000000) as u256),
        };
        wrap_components(v4)
    }

    public fun lt(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : bool {
        greater_than_bits(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0))
    }

    public fun lte(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : bool {
        !gt(arg0, arg1)
    }

    public fun mod(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1);
        assert!(v0 != 0, 13835623453367205893);
        let v1 = decompose(v0);
        let v2 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v3 = v2.mag % v1.mag;
        let v4 = if (v2.neg && v3 > 0) {
            v1.mag - v3
        } else {
            v3
        };
        let v5 = Components{
            neg : false,
            mag : v4,
        };
        wrap_components(v5)
    }

    public fun mul(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        mul_trunc(arg0, arg1)
    }

    public fun mul_away(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let v0 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v1 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1));
        let v2 = Components{
            neg : v0.neg != v1.neg,
            mag : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::div_away_u256(v0.mag * v1.mag, 1000000000),
        };
        wrap_components(v2)
    }

    public fun mul_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let v0 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v1 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1));
        let v2 = Components{
            neg : v0.neg != v1.neg,
            mag : v0.mag * v1.mag / 1000000000,
        };
        wrap_components(v2)
    }

    public fun negate(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        wrap_components(negate_components(decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0))))
    }

    fun negate_components(arg0: Components) : Components {
        if (arg0.mag == 0) {
            Components{neg: false, mag: 0}
        } else {
            Components{neg: !arg0.neg, mag: arg0.mag}
        }
    }

    public fun neq(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : bool {
        !eq(arg0, arg1)
    }

    public fun pow(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: u8) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        if (arg1 == 0) {
            return 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::one()
        };
        if (arg1 == 1) {
            return arg0
        };
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v2 = v0 && arg1 % 2 != 0;
        let v3 = 1000000000;
        let v4 = 170141183460469231731687303715884105728;
        let v5 = v3;
        let v6 = v1;
        let v7 = arg1;
        while (v7 != 0) {
            if (v7 & 1 == 1) {
                let v8 = v5 * v6 / v3;
                v5 = v8;
                assert!(v8 < v4 || v2 && v8 == v4, 13835061336637177857);
            };
            v7 = v7 >> 1;
            if (v7 != 0) {
                v6 = v6 * v6 / v3;
                assert!(v6 <= v4, 13835061358112014337);
            };
        };
        let v9 = Components{
            neg : v2,
            mag : v5,
        };
        wrap_components(v9)
    }

    public fun rem(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1);
        assert!(v0 != 0, 13835623350287990789);
        let v1 = decompose(v0);
        let v2 = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        let v3 = Components{
            neg : v2.neg,
            mag : v2.mag % v1.mag,
        };
        wrap_components(v3)
    }

    public fun sub(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        wrap_components(add_components(decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0)), negate_components(decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1)))))
    }

    public fun try_into_UD30x9(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0x1::option::Option<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9> {
        let Components {
            neg : v0,
            mag : v1,
        } = decompose(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0));
        if (v0) {
            0x1::option::none<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9>()
        } else {
            0x1::option::some<0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9>(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap((v1 as u128)))
        }
    }

    public fun unchecked_add(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::from_bits(wrapping_add_bits(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1)))
    }

    public fun unchecked_sub(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::from_bits(wrapping_sub_bits(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg0), 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::unwrap(arg1)))
    }

    fun wrap_components(arg0: Components) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::SD29x9 {
        if (arg0.mag == 0) {
            return 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::zero()
        };
        let v0 = 170141183460469231731687303715884105728;
        if (arg0.neg && arg0.mag == v0) {
            0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::min()
        } else {
            assert!(arg0.mag < v0, 13835061937932599297);
            0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap((arg0.mag as u128), arg0.neg)
        }
    }

    fun wrapping_add_bits(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) + (arg1 as u256) & 340282366920938463463374607431768211455) as u128)
    }

    fun wrapping_sub_bits(arg0: u128, arg1: u128) : u128 {
        wrapping_add_bits(arg0, 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::two_complement(arg1))
    }

    // decompiled from Move bytecode v7
}

