module 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::float {
    struct Float has copy, drop, store {
        is_negative: bool,
        exp: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64,
        mant: u64,
    }

    public fun add(arg0: Float, arg1: Float) : Float {
        if (arg0.mant == 0) {
            return arg1
        };
        if (arg1.mant == 0) {
            return arg0
        };
        if (arg0.is_negative == arg1.is_negative) {
            let (v1, v2) = add_magnitudes(arg0.exp, arg0.mant, arg1.exp, arg1.mant);
            normalize_checked(arg0.is_negative, v1, v2)
        } else {
            match_sub(arg0, neg(arg1))
        }
    }

    fun add_magnitudes(arg0: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, arg1: u64, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, arg3: u64) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, u64) {
        let (v0, v1, v2, v3) = order_by_exp(arg0, arg1, arg2, arg3);
        let v4 = v0;
        let v5 = if (v3) {
            arg0
        } else {
            arg2
        };
        let v6 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::abs_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::sub(v0, v5));
        if (v6 == 0) {
            let v7 = v1 + v2;
            let v8 = v7;
            if (v7 > 9007199254740991) {
                v8 = v7 >> 1;
                v4 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(v0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1));
            };
            return (v4, v8)
        };
        let v9 = if (v6 >= 64) {
            0
        } else {
            v2 >> (v6 as u8)
        };
        let v10 = if (v6 == 0) {
            0
        } else if (v6 >= 65) {
            0
        } else {
            v2 >> ((v6 - 1) as u8) & 1
        };
        let v11 = if (v6 <= 1) {
            0
        } else if (v6 >= 66) {
            0
        } else {
            v2 >> ((v6 - 2) as u8) & 1
        };
        let v12 = if (v6 <= 2) {
            false
        } else if (v6 >= 67) {
            v2 != 0
        } else {
            let v13 = if (v6 - 2 >= 64) {
                v2
            } else {
                v2 & (1 << ((v6 - 2) as u8)) - 1
            };
            v13 != 0
        };
        let v14 = (v1 as u128) + (v9 as u128);
        let v15 = v14;
        let v16 = if (v10 == 1) {
            if (v11 == 1) {
                true
            } else if (v12) {
                true
            } else {
                (v14 as u64) & 1 == 1
            }
        } else {
            false
        };
        if (v16) {
            v15 = v14 + 1;
        };
        let v17 = (v15 as u64);
        let v18 = v17;
        if (v17 > 9007199254740991) {
            v18 = v17 >> 1;
            v4 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(v0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1));
        };
        (v4, v18)
    }

    fun cmp_magnitude(arg0: &Float, arg1: &Float) : u8 {
        if (arg0.mant == 0 && arg1.mant == 0) {
            return 1
        };
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::gt(arg0.exp, arg1.exp)) {
            return 2
        };
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::lt(arg0.exp, arg1.exp)) {
            return 0
        };
        if (arg0.mant > arg1.mant) {
            return 2
        };
        if (arg0.mant < arg1.mant) {
            return 0
        };
        1
    }

    public fun div(arg0: Float, arg1: Float) : Float {
        assert!(arg1.mant != 0, 13836185265154424839);
        if (arg0.mant == 0) {
            return zero()
        };
        let v0 = (arg0.mant as u128) << 52;
        let v1 = v0 / (arg1.mant as u128);
        let v2 = v0 % (arg1.mant as u128);
        let v3 = v1;
        if (2 * v2 > (arg1.mant as u128) || 2 * v2 == (arg1.mant as u128) && v1 & 1 == 1) {
            v3 = v1 + 1;
        };
        let v4 = (v3 as u64);
        let v5 = v4;
        let v6 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::sub(arg0.exp, arg1.exp);
        let v7 = v6;
        if (v4 > 9007199254740991) {
            v5 = v4 >> 1;
            v7 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(v6, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1));
        } else if (v4 < 4503599627370496 && v4 != 0) {
            let (v8, v9) = normalize_left(v6, v4);
            v7 = v8;
            v5 = v9;
        };
        normalize_checked(arg0.is_negative != arg1.is_negative, v7, v5)
    }

    public fun eq(arg0: &Float, arg1: &Float) : bool {
        if (arg0.mant == 0 && arg1.mant == 0) {
            return true
        };
        if (arg0.is_negative == arg1.is_negative) {
            if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::eq(arg0.exp, arg1.exp)) {
                arg0.mant == arg1.mant
            } else {
                false
            }
        } else {
            false
        }
    }

    fun eq_or_one_ulp(arg0: &Float, arg1: &Float) : bool {
        if (eq(arg0, arg1)) {
            return true
        };
        if (arg0.mant == 0 || arg1.mant == 0) {
            return false
        };
        if (arg0.is_negative != arg1.is_negative) {
            return false
        };
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::eq(arg0.exp, arg1.exp)) {
            let v0 = arg0.mant;
            let v1 = arg1.mant;
            let v2 = if (v0 >= v1) {
                v0 - v1
            } else {
                v1 - v0
            };
            return v2 == 1
        };
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::eq(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(arg0.exp, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1)), arg1.exp)) {
            return arg0.mant == 9007199254740991 && arg1.mant == 4503599627370496
        };
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::eq(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(arg1.exp, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1)), arg0.exp)) {
            return arg1.mant == 9007199254740991 && arg0.mant == 4503599627370496
        };
        false
    }

    public fun floor_to_u64(arg0: Float) : u64 {
        assert!(!is_negative(&arg0), 13836466903340023817);
        if (arg0.mant == 0) {
            return 0
        };
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::gt(arg0.exp, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(63))) {
            abort 13836748399791702027
        };
        if (!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::lt(arg0.exp, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(52))) {
            return arg0.mant << (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::abs_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::sub(arg0.exp, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(52))) as u8)
        };
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::abs_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::sub(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(52), arg0.exp));
        if (v0 >= 64) {
            return 0
        };
        arg0.mant >> (v0 as u8)
    }

    public fun from_fraction(arg0: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64) : Float {
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::eq(arg1, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::zero()), 13836184474880442375);
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::eq(arg0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::zero())) {
            return zero()
        };
        let v0 = (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::abs_u64(arg0) as u128);
        let v1 = (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::abs_u64(arg1) as u128);
        let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::as_u64(msb_u128(v0));
        let v3 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::as_u64(msb_u128(v1));
        let v4 = 52 + 2;
        let v5 = if (v3 >= v2) {
            v4 + v3 - v2
        } else {
            let v6 = v2 - v3;
            if (v4 > v6) {
                v4 - v6
            } else {
                0
            }
        };
        let v7 = 127 - v2;
        if (v5 > v7) {
            v5 = v7;
        };
        let v8 = (v5 as u8);
        let v9 = v0 << v8;
        let v10 = v9 / v1;
        assert!(v10 != 0, 13835621675250614275);
        let v11 = 127;
        while (v10 >> v11 & 1 == 0) {
            v11 = v11 - 1;
        };
        let v12 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::sub(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from((v11 as u64)), 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from((v8 as u64)));
        let v13 = v12;
        let v14 = if (v11 > 52) {
            let v15 = v11 - 52;
            let v16 = (1 << v15) - 1;
            let v17 = v10 >> v15;
            let v14 = v17;
            let v18 = if (v10 >> v15 - 1 & 1 == 1) {
                if (v10 & v16 & v16 >> 1 != 0) {
                    true
                } else if (v9 % v1 != 0) {
                    true
                } else {
                    v17 & 1 == 1
                }
            } else {
                false
            };
            if (v18) {
                v14 = v17 + 1;
            };
            if (v14 > (9007199254740991 as u128)) {
                v14 = v14 >> 1;
                v13 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(v12, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1));
            };
            v14
        } else if (v11 < 52) {
            v10 << 52 - v11
        } else {
            v10
        };
        normalize_checked(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::is_neg(arg0) != 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::is_neg(arg1), v13, (v14 as u64))
    }

    public fun from_i64(arg0: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64) : Float {
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::eq(arg0, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::zero())) {
            return zero()
        };
        let v0 = from_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::abs_u64(arg0));
        let v1 = v0;
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::is_neg(arg0)) {
            v1 = neg(v0);
        };
        v1
    }

    public fun from_scientific(arg0: bool, arg1: u64, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64) : Float {
        if (arg1 == 0) {
            return zero()
        };
        let v0 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::abs_u64(arg2);
        assert!(v0 <= 19, 13835340445086908417);
        let v1 = if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::is_neg(arg2)) {
            div(from_u64(arg1), from_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::math::pow_u64(10, v0)))
        } else {
            mul(from_u64(arg1), from_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::math::pow_u64(10, v0)))
        };
        let v2 = v1;
        if (arg0) {
            v2 = neg(v1);
        };
        v2
    }

    public fun from_u64(arg0: u64) : Float {
        if (arg0 == 0) {
            return zero()
        };
        let v0 = 63;
        while (arg0 >> (v0 as u8) & 1 == 0) {
            v0 = v0 - 1;
        };
        let v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(v0);
        let v2 = v1;
        let v3 = if (v0 <= 52) {
            arg0 << ((52 - v0) as u8)
        } else {
            let v4 = rshift_nearest_even_u64(arg0, ((v0 - 52) as u8));
            let v3 = v4;
            if (v4 > 9007199254740991) {
                v3 = v4 >> 1;
                v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(v1, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1));
            };
            v3
        };
        normalize_checked(false, v2, v3)
    }

    public fun gt(arg0: &Float, arg1: &Float) : bool {
        if (eq(arg0, arg1)) {
            return false
        };
        if (arg0.mant == 0 && arg1.mant != 0) {
            return arg1.is_negative
        };
        if (arg1.mant == 0 && arg0.mant != 0) {
            return !arg0.is_negative
        };
        if (arg0.is_negative != arg1.is_negative) {
            return arg1.is_negative
        };
        !arg0.is_negative && cmp_magnitude(arg0, arg1) == 2 || cmp_magnitude(arg0, arg1) == 0
    }

    public fun gte(arg0: &Float, arg1: &Float) : bool {
        !lt(arg0, arg1)
    }

    public fun is_negative(arg0: &Float) : bool {
        arg0.mant != 0 && arg0.is_negative
    }

    public fun is_negative_or_zero(arg0: &Float) : bool {
        is_non_positive(arg0)
    }

    public fun is_non_negative(arg0: &Float) : bool {
        arg0.mant == 0 || !arg0.is_negative
    }

    public fun is_non_positive(arg0: &Float) : bool {
        arg0.mant == 0 || arg0.is_negative
    }

    public fun is_positive(arg0: &Float) : bool {
        arg0.mant != 0 && !arg0.is_negative
    }

    public fun is_positive_or_zero(arg0: &Float) : bool {
        is_non_negative(arg0)
    }

    public fun is_zero(arg0: &Float) : bool {
        arg0.mant == 0
    }

    public fun le(arg0: &Float, arg1: &Float) : bool {
        !gt(arg0, arg1)
    }

    public fun lt(arg0: &Float, arg1: &Float) : bool {
        gt(arg1, arg0)
    }

    public fun lte(arg0: &Float, arg1: &Float) : bool {
        le(arg0, arg1)
    }

    fun match_sub(arg0: Float, arg1: Float) : Float {
        let v0 = cmp_magnitude(&arg0, &arg1);
        if (v0 == 1) {
            return zero()
        };
        let (v1, v2, v3, v4, v5) = if (v0 == 2) {
            (arg0.is_negative, arg0.exp, arg0.mant, arg1.mant, arg1.exp)
        } else {
            (!arg0.is_negative, arg1.exp, arg1.mant, arg0.mant, arg0.exp)
        };
        let v6 = v4;
        let v7 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::abs_u64(0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::sub(v2, v5));
        if (v7 != 0) {
            v6 = rshift_sticky_round_u64_big(v4, v7);
        };
        let v8 = if (v3 >= v6) {
            v3 - v6
        } else {
            0
        };
        if (v8 == 0) {
            return zero()
        };
        let (v9, v10) = normalize_left(v2, v8);
        normalize_checked(v1, v9, v10)
    }

    fun msb_u128(arg0: u128) : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64 {
        assert!(arg0 != 0, 13835905211811758085);
        let v0 = 127;
        while (arg0 >> v0 & 1 == 0) {
            v0 = v0 - 1;
        };
        0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from((v0 as u64))
    }

    public fun mul(arg0: Float, arg1: Float) : Float {
        if (arg0.mant == 0 || arg1.mant == 0) {
            return zero()
        };
        let v0 = (arg0.mant as u128) * (arg1.mant as u128);
        let v1 = v0 >> 52;
        let v2 = v0 & (1 << 52) - 1;
        let v3 = v1;
        if (2 * v2 > 1 << 52 || 2 * v2 == 1 << 52 && v1 & 1 == 1) {
            v3 = v1 + 1;
        };
        let v4 = (v3 as u64);
        let v5 = v4;
        let v6 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(arg0.exp, arg1.exp);
        let v7 = v6;
        if (v4 > 9007199254740991) {
            v5 = v4 >> 1;
            v7 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(v6, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1));
        };
        normalize_checked(arg0.is_negative != arg1.is_negative, v7, v5)
    }

    public fun multiple_mul(arg0: vector<Float>) : Float {
        if (0x1::vector::length<Float>(&arg0) == 0) {
            abort 13837029625660440589
        };
        if (0x1::vector::length<Float>(&arg0) == 1) {
            return *0x1::vector::borrow<Float>(&arg0, 0)
        };
        let v0 = mul(*0x1::vector::borrow<Float>(&arg0, 0), *0x1::vector::borrow<Float>(&arg0, 1));
        let v1 = 2;
        while (v1 < 0x1::vector::length<Float>(&arg0)) {
            v0 = mul(v0, *0x1::vector::borrow<Float>(&arg0, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun neg(arg0: Float) : Float {
        if (arg0.mant == 0) {
            arg0
        } else {
            Float{is_negative: !arg0.is_negative, exp: arg0.exp, mant: arg0.mant}
        }
    }

    fun normalize_checked(arg0: bool, arg1: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, arg2: u64) : Float {
        if (arg2 == 0) {
            return zero()
        };
        let v0 = arg2;
        let v1 = arg1;
        if (arg2 > 9007199254740991) {
            v0 = arg2 >> 1;
            v1 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::add(arg1, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1));
        } else if (arg2 < 4503599627370496) {
            let (v2, v3) = normalize_left(arg1, arg2);
            v1 = v2;
            v0 = v3;
        };
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::lt(v1, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::neg_from(1022)), 13835623655230537731);
        assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::gt(v1, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1023)), 13835342184548663297);
        Float{
            is_negative : arg0,
            exp         : v1,
            mant        : v0,
        }
    }

    fun normalize_left(arg0: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, arg1: u64) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, u64) {
        let v0 = arg1;
        let v1 = arg0;
        while (v0 > 0 && v0 < 4503599627370496) {
            v0 = v0 << 1;
            let v2 = 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::sub(v1, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::from(1));
            v1 = v2;
            assert!(!0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::lt(v2, 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::neg_from(1022)), 13835623706770145283);
        };
        (v1, v0)
    }

    fun order_by_exp(arg0: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, arg1: u64, arg2: 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, arg3: u64) : (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::I64, u64, u64, bool) {
        if (0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::gt(arg0, arg2) || 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::eq(arg0, arg2) && arg1 >= arg3) {
            (arg0, arg1, arg3, false)
        } else {
            (arg2, arg3, arg1, true)
        }
    }

    public fun positive_part(arg0: Float) : Float {
        if (is_positive(&arg0)) {
            arg0
        } else {
            zero()
        }
    }

    fun rshift_nearest_even_u64(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        if (arg1 >= 64) {
            return 0
        };
        let v0 = (1 << arg1) - 1;
        let v1 = arg0 >> arg1;
        if (arg0 >> arg1 - 1 & 1 == 1 && (arg0 & v0 & v0 >> 1 != 0 || v1 & 1 == 1)) {
            v1 + 1
        } else {
            v1
        }
    }

    fun rshift_sticky_round(arg0: u64, arg1: u8) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        if (arg1 >= 64) {
            return 0
        };
        let v0 = (1 << arg1) - 1;
        let v1 = arg0 >> arg1;
        if (arg0 >> arg1 - 1 & 1 == 1 && (arg0 & v0 & v0 >> 1 != 0 || v1 & 1 == 1)) {
            let v3 = v1 + 1;
            if (v3 > 9007199254740991) {
                v3 >> 1
            } else {
                v3
            }
        } else {
            v1
        }
    }

    fun rshift_sticky_round_u64_big(arg0: u64, arg1: u64) : u64 {
        if (arg1 == 0) {
            return arg0
        };
        if (arg1 >= 64) {
            return 0
        };
        rshift_sticky_round(arg0, (arg1 as u8))
    }

    public fun sub(arg0: Float, arg1: Float) : Float {
        if (arg1.mant == 0) {
            return arg0
        };
        if (arg0.mant == 0) {
            return Float{
                is_negative : !arg1.is_negative,
                exp         : arg1.exp,
                mant        : arg1.mant,
            }
        };
        if (arg0.is_negative != arg1.is_negative) {
            let (v1, v2) = add_magnitudes(arg0.exp, arg0.mant, arg1.exp, arg1.mant);
            normalize_checked(arg0.is_negative, v1, v2)
        } else {
            match_sub(arg0, arg1)
        }
    }

    public fun zero() : Float {
        Float{
            is_negative : false,
            exp         : 0xcbb0929f21450013ebe5e86e7139f2409da2e3ed212c51126a7e6448b795a43f::i64::zero(),
            mant        : 0,
        }
    }

    // decompiled from Move bytecode v6
}

