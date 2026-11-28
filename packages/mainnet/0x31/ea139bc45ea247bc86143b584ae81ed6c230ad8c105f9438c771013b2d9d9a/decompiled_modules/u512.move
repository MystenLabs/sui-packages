module 0x31ea139bc45ea247bc86143b584ae81ed6c230ad8c105f9438c771013b2d9d9a::u512 {
    struct U512 has copy, drop, store {
        hi: u256,
        lo: u256,
    }

    public fun add(arg0: U512, arg1: U512) : U512 {
        let (v0, v1) = add_c(arg0.lo, arg1.lo);
        U512{
            hi : arg0.hi + arg1.hi + v1,
            lo : v0,
        }
    }

    fun add_c(arg0: u256, arg1: u256) : (u256, u256) {
        let v0 = 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1;
        if (arg0 > v0) {
            (arg0 - v0 - 1, 1)
        } else {
            (arg0 + arg1, 0)
        }
    }

    public fun cmp(arg0: U512, arg1: U512) : u8 {
        if (lt(arg0, arg1)) {
            0
        } else if (eq(arg0, arg1)) {
            1
        } else {
            2
        }
    }

    public fun div_down(arg0: U512, arg1: U512) : U512 {
        let (v0, _) = div_rem(arg0, arg1);
        v0
    }

    public fun div_rem(arg0: U512, arg1: U512) : (U512, U512) {
        assert!(arg1.hi != 0 || arg1.lo != 0, 2);
        if (arg1.hi == 0) {
            let (v2, v3) = div_rem_u256(arg0, arg1.lo);
            let v1 = U512{
                hi : 0,
                lo : v3,
            };
            (v2, v1)
        } else {
            let (v4, v5) = div_rem_slow(arg0, arg1);
            let v1 = v5;
            (v4, v1)
        }
    }

    fun div_rem_slow(arg0: U512, arg1: U512) : (U512, U512) {
        if (lt(arg0, arg1)) {
            return (zero(), arg0)
        };
        let v0 = arg1;
        let v1 = 0;
        let v2 = 256;
        while (v2 > 0) {
            if (le(v0, shr(arg0, v2))) {
                v0 = shl(v0, v2);
                v1 = v1 + v2;
            };
            v2 = v2 >> 1;
        };
        let v3 = zero();
        let v4 = arg0;
        let v5 = v1 + 1;
        while (v5 > 0) {
            let v6 = v3;
            v3 = shl(v6, 1);
            if (le(v0, v4)) {
                v4 = sub(v4, v0);
                let v7 = v3.hi;
                let v8 = v3.lo + 1;
                v3 = U512{hi: v7, lo: v8};
            };
            v0 = shr(v0, 1);
            v5 = v5 - 1;
        };
        (v3, v4)
    }

    public fun div_rem_u256(arg0: U512, arg1: u256) : (U512, u256) {
        assert!(arg1 != 0, 2);
        if (arg1 <= 340282366920938463463374607431768211455) {
            let v2 = arg0.hi >> 128;
            let v3 = (v2 % arg1 << 128) + (arg0.hi & 340282366920938463463374607431768211455);
            let v4 = (v3 % arg1 << 128) + (arg0.lo >> 128);
            let v5 = (v4 % arg1 << 128) + (arg0.lo & 340282366920938463463374607431768211455);
            let v6 = U512{
                hi : (v2 / arg1 << 128) + v3 / arg1,
                lo : (v4 / arg1 << 128) + v5 / arg1,
            };
            (v6, v5 % arg1)
        } else {
            let v7 = U512{
                hi : 0,
                lo : arg1,
            };
            let (v8, v9) = div_rem_slow(arg0, v7);
            let v10 = v9;
            (v8, v10.lo)
        }
    }

    public fun div_up(arg0: U512, arg1: U512) : U512 {
        let (v0, v1) = div_rem(arg0, arg1);
        let v2 = v1;
        if (v2.hi == 0 && v2.lo == 0) {
            v0
        } else {
            add(v0, one())
        }
    }

    public fun eq(arg0: U512, arg1: U512) : bool {
        arg0.hi == arg1.hi && arg0.lo == arg1.lo
    }

    public fun fits_u256(arg0: U512) : bool {
        arg0.hi == 0
    }

    public fun from_u256(arg0: u256) : U512 {
        U512{
            hi : 0,
            lo : arg0,
        }
    }

    public fun ge(arg0: U512, arg1: U512) : bool {
        le(arg1, arg0)
    }

    public fun gt(arg0: U512, arg1: U512) : bool {
        lt(arg1, arg0)
    }

    public fun hi(arg0: U512) : u256 {
        arg0.hi
    }

    public fun is_zero(arg0: U512) : bool {
        arg0.hi == 0 && arg0.lo == 0
    }

    public fun le(arg0: U512, arg1: U512) : bool {
        arg0.hi < arg1.hi || arg0.hi == arg1.hi && arg0.lo <= arg1.lo
    }

    public fun lo(arg0: U512) : u256 {
        arg0.lo
    }

    public fun lt(arg0: U512, arg1: U512) : bool {
        arg0.hi < arg1.hi || arg0.hi == arg1.hi && arg0.lo < arg1.lo
    }

    public fun max(arg0: U512, arg1: U512) : U512 {
        if (le(arg0, arg1)) {
            arg1
        } else {
            arg0
        }
    }

    public fun max_value() : U512 {
        U512{
            hi : 115792089237316195423570985008687907853269984665640564039457584007913129639935,
            lo : 115792089237316195423570985008687907853269984665640564039457584007913129639935,
        }
    }

    public fun min(arg0: U512, arg1: U512) : U512 {
        if (le(arg0, arg1)) {
            arg0
        } else {
            arg1
        }
    }

    public fun mul(arg0: U512, arg1: U512) : U512 {
        if (arg0.hi == 0) {
            mul_small(arg0.lo, arg1)
        } else {
            assert!(arg1.hi == 0, 1);
            mul_small(arg1.lo, arg0)
        }
    }

    fun mul_small(arg0: u256, arg1: U512) : U512 {
        let v0 = mul_u256(arg0, arg1.hi);
        assert!(v0.hi == 0, 1);
        let v1 = mul_u256(arg0, arg1.lo);
        U512{
            hi : v1.hi + v0.lo,
            lo : v1.lo,
        }
    }

    public fun mul_u256(arg0: u256, arg1: u256) : U512 {
        let v0 = arg0 & 340282366920938463463374607431768211455;
        let v1 = arg0 >> 128;
        let v2 = arg1 & 340282366920938463463374607431768211455;
        let v3 = arg1 >> 128;
        let v4 = v0 * v2;
        let v5 = v0 * v3 + (v4 >> 128);
        let v6 = (v5 & 340282366920938463463374607431768211455) + v1 * v2;
        U512{
            hi : v1 * v3 + (v5 >> 128) + (v6 >> 128),
            lo : ((v6 & 340282366920938463463374607431768211455) << 128) + (v4 & 340282366920938463463374607431768211455),
        }
    }

    public fun new(arg0: u256, arg1: u256) : U512 {
        U512{
            hi : arg0,
            lo : arg1,
        }
    }

    public fun one() : U512 {
        U512{
            hi : 0,
            lo : 1,
        }
    }

    public fun rem(arg0: U512, arg1: U512) : U512 {
        let (_, v1) = div_rem(arg0, arg1);
        v1
    }

    public fun shl(arg0: U512, arg1: u16) : U512 {
        assert!(arg1 < 512, 3);
        if (arg1 == 0) {
            arg0
        } else if (arg1 < 256) {
            let v1 = (arg1 as u8);
            U512{hi: (arg0.hi << v1) + (arg0.lo >> ((256 - arg1) as u8)), lo: arg0.lo << v1}
        } else {
            U512{hi: arg0.lo << ((arg1 - 256) as u8), lo: 0}
        }
    }

    public fun shr(arg0: U512, arg1: u16) : U512 {
        assert!(arg1 < 512, 3);
        if (arg1 == 0) {
            arg0
        } else if (arg1 < 256) {
            let v1 = (arg1 as u8);
            U512{hi: arg0.hi >> v1, lo: (arg0.lo >> v1) + (arg0.hi << ((256 - arg1) as u8))}
        } else {
            U512{hi: 0, lo: arg0.hi >> ((arg1 - 256) as u8)}
        }
    }

    public fun sub(arg0: U512, arg1: U512) : U512 {
        let (v0, v1) = sub_b(arg0.lo, arg1.lo);
        U512{
            hi : arg0.hi - arg1.hi - v1,
            lo : v0,
        }
    }

    fun sub_b(arg0: u256, arg1: u256) : (u256, u256) {
        if (arg0 >= arg1) {
            (arg0 - arg1, 0)
        } else {
            (115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1 - arg0 + 1, 1)
        }
    }

    public fun to_u256(arg0: U512) : u256 {
        assert!(arg0.hi == 0, 1);
        arg0.lo
    }

    public fun wrapping_add(arg0: U512, arg1: U512) : U512 {
        let (v0, v1) = add_c(arg0.lo, arg1.lo);
        let (v2, _) = add_c(arg0.hi, arg1.hi);
        let (v4, _) = add_c(v2, v1);
        U512{
            hi : v4,
            lo : v0,
        }
    }

    public fun wrapping_mul(arg0: U512, arg1: U512) : U512 {
        let v0 = mul_u256(arg0.lo, arg1.lo);
        let v1 = mul_u256(arg0.hi, arg1.lo);
        let v2 = mul_u256(arg0.lo, arg1.hi);
        let (v3, _) = add_c(v0.hi, v1.lo);
        let (v5, _) = add_c(v3, v2.lo);
        U512{
            hi : v5,
            lo : v0.lo,
        }
    }

    public fun wrapping_sub(arg0: U512, arg1: U512) : U512 {
        let (v0, v1) = sub_b(arg0.lo, arg1.lo);
        let (v2, _) = sub_b(arg0.hi, arg1.hi);
        let (v4, _) = sub_b(v2, v1);
        U512{
            hi : v4,
            lo : v0,
        }
    }

    public fun zero() : U512 {
        U512{
            hi : 0,
            lo : 0,
        }
    }

    // decompiled from Move bytecode v7
}

