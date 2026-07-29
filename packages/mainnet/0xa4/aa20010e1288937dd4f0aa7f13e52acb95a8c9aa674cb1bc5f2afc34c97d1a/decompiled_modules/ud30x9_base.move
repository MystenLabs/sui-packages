module 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9_base {
    public fun log10(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        assert!(v0 > 0, 13836467435916099595);
        assert!(v0 >= 1000000000, 13836748915187908621);
        if (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::is_power_of_ten(v0)) {
            return 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(((0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u128::log10(v0, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()) - 9) as u128) * 1000000000)
        };
        let (_, v2) = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::raw_log2(v0);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::apply_log2_factor(v2, 301029995663981195))
    }

    public fun sqrt(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap((0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u256::sqrt((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) * 1000000000, 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::rounding::down()) as u128))
    }

    public fun cdf(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::cdf::cdf_nonneg_raw(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0)))
    }

    public fun inverse_cdf(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        assert!(v0 <= 1000000000, 13837029617070637071);
        assert!(v0 >= 500000000, 13837311096342446097);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::inverse_cdf::inverse_cdf_upper_raw(v0))
    }

    public fun pdf(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::pdf::pdf_nonneg_raw(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0)))
    }

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
        assert!(v0 != 0, 13835623848504197125);
        wrap_u256(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::div_away_u256((0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) as u256) * 1000000000, v0))
    }

    public fun div_trunc(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = (0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1) as u256);
        assert!(v0 != 0, 13835623741130014725);
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
        assert!(v0 <= 170141183460469231731687303715884105727, 13835902780860399623);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::sd29x9::wrap(v0, false)
    }

    public fun is_zero(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : bool {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) == 0
    }

    public fun ln(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        assert!(v0 > 0, 13836467315657015307);
        assert!(v0 >= 1000000000, 13836748794928824333);
        let (_, v2) = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::raw_log2(v0);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::apply_log2_factor(v2, 693147180559945309))
    }

    public fun log2(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        assert!(v0 > 0, 13836467569060085771);
        assert!(v0 >= 1000000000, 13836749048331894797);
        let (_, v2) = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::common::raw_log2(v0);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(v2 / 1000000000)
    }

    public fun lshift(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: u8) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        assert!(arg1 < 128, 13836185643111677961);
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        assert!(v0 <= 340282366920938463463374607431768211455 >> arg1, 13835059751794245633);
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
        assert!(v0 != 0, 13835623337403088901);
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
                assert!(v5 <= v1, 13835061091824041985);
            };
            v4 = v4 >> 1;
            if (v4 != 0) {
                v2 = v2 * v2 / v0;
                assert!(v2 <= v1, 13835061113298878465);
            };
        };
        wrap_u256(v3)
    }

    public fun rshift(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: u8) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        assert!(arg1 < 128, 13836187322443890697);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) >> arg1)
    }

    public fun sub(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        let v0 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0);
        let v1 = 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1);
        assert!(v0 >= v1, 13835343056427155459);
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
        assert!(arg0 <= 340282366920938463463374607431768211455, 13835061830558416897);
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap((arg0 as u128))
    }

    public fun xor(arg0: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9, arg1: 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9) : 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::UD30x9 {
        0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::wrap(0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg0) ^ 0xf18ad29e1549aec2d5ce12d1a461ea0a03b5a113cc04aced0e07963738fd8a84::ud30x9::unwrap(arg1))
    }

    // decompiled from Move bytecode v7
}

