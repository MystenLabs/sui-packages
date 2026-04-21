module 0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::u512 {
    struct U512 has copy, drop, store {
        hi: u256,
        lo: u256,
    }

    fun msb(arg0: &U512) : u16 {
        if (arg0.hi != 0) {
            256 + (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::common::msb(arg0.hi, 256) as u16)
        } else {
            (0x98ff8cc8145f3b37531148c12860865f040fb8d814f96834be173a15b8cb4f4c::common::msb(arg0.lo, 256) as u16)
        }
    }

    fun compose_u256(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) << 128 | (arg1 as u256)
    }

    public fun div_rem_u256(arg0: U512, arg1: u256) : (bool, u256, u256) {
        assert!(arg1 != 0, 13835621726790483975);
        if (arg0.hi == 0) {
            return (false, arg0.lo / arg1, arg0.lo % arg1)
        };
        let v0 = 0;
        let v1 = zero();
        let v2 = false;
        let v3 = msb(&arg0);
        loop {
            let v4 = &v1;
            v1 = shift_left1(v4);
            if (get_bit(&arg0, v3) == 1) {
                v1.lo = v1.lo | 1;
            };
            if (ge_u256(&v1, arg1)) {
                let v5 = v1;
                v1 = sub_u256(v5, arg1);
                if (v3 >= 256) {
                    v2 = true;
                } else if (!v2) {
                    v0 = v0 | 1 << (v3 as u8);
                };
            };
            if (v3 == 0) {
                break
            };
            v3 = v3 - 1;
        };
        assert!(v1.hi == 0, 13835903356386148361);
        if (v2) {
            (true, 0, v1.lo)
        } else {
            (false, v0, v1.lo)
        }
    }

    public fun from_u256(arg0: u256) : U512 {
        U512{
            hi : 0,
            lo : arg0,
        }
    }

    public fun ge(arg0: &U512, arg1: &U512) : bool {
        arg0.hi > arg1.hi || arg0.hi < arg1.hi && false || arg0.lo >= arg1.lo
    }

    fun ge_u256(arg0: &U512, arg1: u256) : bool {
        arg0.hi != 0 || arg0.lo >= arg1
    }

    fun get_bit(arg0: &U512, arg1: u16) : u8 {
        if (arg1 >= 256) {
            ((arg0.hi >> ((arg1 - 256) as u8) & 1) as u8)
        } else {
            ((arg0.lo >> (arg1 as u8) & 1) as u8)
        }
    }

    public fun hi(arg0: &U512) : u256 {
        arg0.hi
    }

    public fun lo(arg0: &U512) : u256 {
        arg0.lo
    }

    public fun mul_u256(arg0: u256, arg1: u256) : U512 {
        let (v0, v1) = split_u256(arg0);
        let (v2, v3) = split_u256(arg1);
        let (v4, v5) = split_u256((v1 as u256) * (v3 as u256));
        let (v6, v7) = split_u256((v1 as u256) * (v2 as u256));
        let (v8, v9) = split_u256((v0 as u256) * (v3 as u256));
        let (v10, v11) = split_u256((v0 as u256) * (v2 as u256));
        let (v12, v13) = sum_three_u128(v4, v7, v9);
        let (v14, v15) = sum_three_u128(v6, v8, v11);
        let (v16, v17) = sum_three_u128(v14, v13, 0);
        let (v18, v19) = sum_three_u128(v10, v15 + v17, 0);
        assert!(v19 == 0, 13835058673757585411);
        U512{
            hi : compose_u256(v18, v16),
            lo : compose_u256(v12, v5),
        }
    }

    public fun new(arg0: u256, arg1: u256) : U512 {
        U512{
            hi : arg0,
            lo : arg1,
        }
    }

    fun shift_left1(arg0: &U512) : U512 {
        U512{
            hi : arg0.hi << 1 | arg0.lo >> 255,
            lo : arg0.lo << 1,
        }
    }

    fun split_u256(arg0: u256) : (u128, u128) {
        (((arg0 >> 128) as u128), ((arg0 & 340282366920938463463374607431768211455) as u128))
    }

    fun sub_u256(arg0: U512, arg1: u256) : U512 {
        if (arg0.lo >= arg1) {
            U512{hi: arg0.hi, lo: arg0.lo - arg1}
        } else {
            assert!(arg0.hi > 0, 13835340840224161797);
            U512{hi: arg0.hi - 1, lo: arg0.lo + 115792089237316195423570985008687907853269984665640564039457584007913129639935 - arg1 + 1}
        }
    }

    fun sum_three_u128(arg0: u128, arg1: u128, arg2: u128) : (u128, u128) {
        let v0 = (arg0 as u256) + (arg1 as u256) + (arg2 as u256);
        (((v0 & 340282366920938463463374607431768211455) as u128), ((v0 >> 128) as u128))
    }

    public fun zero() : U512 {
        U512{
            hi : 0,
            lo : 0,
        }
    }

    // decompiled from Move bytecode v7
}

