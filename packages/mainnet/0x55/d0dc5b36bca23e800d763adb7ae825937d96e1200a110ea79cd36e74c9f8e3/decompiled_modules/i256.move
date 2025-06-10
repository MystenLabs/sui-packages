module 0x55d0dc5b36bca23e800d763adb7ae825937d96e1200a110ea79cd36e74c9f8e3::i256 {
    struct I256 has copy, drop, store {
        bits: u256,
    }

    public(friend) fun abs(arg0: I256) : I256 {
        if (sign(arg0) == 0) {
            arg0
        } else {
            assert!(arg0.bits > 57896044618658097711785492504343953926634992332820282019728792003956564819968, 0);
            I256{bits: u256_neg(arg0.bits - 1)}
        }
    }

    public(friend) fun abs_u128(arg0: I256) : u128 {
        (abs_u256(arg0) as u128)
    }

    public(friend) fun abs_u256(arg0: I256) : u256 {
        if (sign(arg0) == 0) {
            arg0.bits
        } else {
            u256_neg(arg0.bits - 1)
        }
    }

    public(friend) fun abs_u64(arg0: I256) : u64 {
        (abs_u256(arg0) as u64)
    }

    public(friend) fun add(arg0: I256, arg1: I256) : I256 {
        let v0 = wrapping_add(arg0, arg1);
        assert!((sign(arg0) & sign(arg1) & u8_neg(sign(v0))) + (u8_neg(sign(arg0)) & u8_neg(sign(arg1)) & sign(v0)) == 0, 0);
        v0
    }

    public(friend) fun cmp(arg0: I256, arg1: I256) : u8 {
        if (arg0.bits == arg1.bits) {
            return 1
        };
        if (sign(arg0) > sign(arg1)) {
            return 0
        };
        if (sign(arg0) < sign(arg1)) {
            return 2
        };
        if (sign(arg0) == 0) {
            if (arg0.bits > arg1.bits) {
                return 2
            };
            return 0
        };
        if (arg0.bits < arg1.bits) {
            return 0
        };
        2
    }

    public(friend) fun div(arg0: I256, arg1: I256) : I256 {
        if (sign(arg0) != sign(arg1)) {
            return neg_from(abs_u256(arg0) / abs_u256(arg1))
        };
        from(abs_u256(arg0) / abs_u256(arg1))
    }

    public(friend) fun eq(arg0: I256, arg1: I256) : bool {
        arg0.bits == arg1.bits
    }

    public(friend) fun from(arg0: u256) : I256 {
        assert!(arg0 <= 57896044618658097711785492504343953926634992332820282019728792003956564819967, 0);
        I256{bits: arg0}
    }

    public(friend) fun from_u64(arg0: u64) : I256 {
        I256{bits: (arg0 as u256)}
    }

    public(friend) fun gt(arg0: I256, arg1: I256) : bool {
        cmp(arg0, arg1) == 2
    }

    public(friend) fun gte(arg0: I256, arg1: I256) : bool {
        cmp(arg0, arg1) >= 1
    }

    public(friend) fun is_neg(arg0: I256) : bool {
        sign(arg0) == 1
    }

    public(friend) fun lt(arg0: I256, arg1: I256) : bool {
        cmp(arg0, arg1) == 0
    }

    public(friend) fun lte(arg0: I256, arg1: I256) : bool {
        cmp(arg0, arg1) <= 1
    }

    public(friend) fun mul(arg0: I256, arg1: I256) : I256 {
        if (sign(arg0) != sign(arg1)) {
            return neg_from(abs_u256(arg0) * abs_u256(arg1))
        };
        from(abs_u256(arg0) * abs_u256(arg1))
    }

    public(friend) fun neg(arg0: I256) : I256 {
        if (is_neg(arg0)) {
            abs(arg0)
        } else {
            neg_from(arg0.bits)
        }
    }

    public(friend) fun neg_from(arg0: u256) : I256 {
        assert!(arg0 <= 57896044618658097711785492504343953926634992332820282019728792003956564819968, 0);
        if (arg0 == 0) {
            I256{bits: arg0}
        } else {
            I256{bits: u256_neg(arg0) + 1 | 57896044618658097711785492504343953926634992332820282019728792003956564819968}
        }
    }

    public(friend) fun sign(arg0: I256) : u8 {
        ((arg0.bits >> 255) as u8)
    }

    public(friend) fun sub(arg0: I256, arg1: I256) : I256 {
        let v0 = I256{bits: u256_neg(arg1.bits)};
        add(arg0, wrapping_add(v0, from(1)))
    }

    fun u256_neg(arg0: u256) : u256 {
        arg0 ^ 115792089237316195423570985008687907853269984665640564039457584007913129639935
    }

    fun u8_neg(arg0: u8) : u8 {
        arg0 ^ 255
    }

    public(friend) fun wrapping_add(arg0: I256, arg1: I256) : I256 {
        let v0 = arg0.bits ^ arg1.bits;
        let v1 = (arg0.bits & arg1.bits) << 1;
        while (v1 != 0) {
            let v2 = v0;
            v0 = v0 ^ v1;
            let v3 = v2 & v1;
            v1 = v3 << 1;
        };
        I256{bits: v0}
    }

    public(friend) fun zero() : I256 {
        I256{bits: 0}
    }

    // decompiled from Move bytecode v6
}

