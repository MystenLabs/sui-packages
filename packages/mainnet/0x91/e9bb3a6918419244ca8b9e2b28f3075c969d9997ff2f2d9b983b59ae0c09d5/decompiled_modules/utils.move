module 0xf95cf480d0dd219f6582f71b28ed4dc29a3b1380bcf3ce276ea248676ef99508::utils {
    struct U256 has copy, drop, store {
        limb0: u64,
        limb1: u64,
        limb2: u64,
        limb3: u64,
    }

    struct DU256 has copy, drop, store {
        limb0: u64,
        limb1: u64,
        limb2: u64,
        limb3: u64,
        limb4: u64,
        limb5: u64,
        limb6: u64,
        limb7: u64,
    }

    public fun to_bytes(arg0: &U256) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = 0;
        while (v1 < 4) {
            let v2 = get(arg0, v1);
            0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&v2));
            v1 = v1 + 1;
        };
        v0
    }

    public fun add(arg0: U256, arg1: U256) : U256 {
        let v0 = zero();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 4) {
            let (v3, v4) = overflowing_add(get(&arg0, v2), get(&arg1, v2));
            let (v5, v6) = overflowing_add(v3, v1);
            let v7 = &mut v0;
            put(v7, v2, v5);
            let v8 = 0;
            v1 = v8;
            if (v4) {
                v1 = v8 + 1;
            };
            if (v6) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        assert!(v1 == 0, 2);
        v0
    }

    public fun and(arg0: &U256, arg1: &U256) : U256 {
        let v0 = zero();
        let v1 = 0;
        while (v1 < 4) {
            let v2 = &mut v0;
            put(v2, v1, get(arg0, v1) & get(arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun as_u128(arg0: U256) : u128 {
        assert!(arg0.limb2 == 0 && arg0.limb3 == 0, 0);
        ((arg0.limb1 as u128) << 64) + (arg0.limb0 as u128)
    }

    public fun as_u64(arg0: U256) : u64 {
        let v0 = if (arg0.limb1 == 0) {
            if (arg0.limb2 == 0) {
                arg0.limb3 == 0
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 0);
        arg0.limb0
    }

    fun bits(arg0: &U256) : u64 {
        let v0 = 1;
        while (v0 < 4) {
            let v1 = get(arg0, 4 - v0);
            if (v1 > 0) {
                return 64 * (4 - v0 + 1) - (leading_zeros_u64(v1) as u64)
            };
            v0 = v0 + 1;
        };
        64 - (leading_zeros_u64(get(arg0, 0)) as u64)
    }

    public fun compare(arg0: &U256, arg1: &U256) : u8 {
        let v0 = 4;
        while (v0 > 0) {
            let v1 = v0 - 1;
            v0 = v1;
            let v2 = get(arg0, v1);
            let v3 = get(arg1, v1);
            if (v2 != v3) {
                return if (v2 < v3) {
                    1
                } else {
                    2
                }
            };
        };
        0
    }

    public fun div(arg0: U256, arg1: U256) : U256 {
        let v0 = zero();
        let v1 = bits(&arg0);
        let v2 = bits(&arg1);
        assert!(v2 != 0, 3);
        if (v1 < v2) {
            return v0
        };
        let v3 = v1 - v2;
        let v4 = arg1;
        arg1 = shl(v4, (v3 as u8));
        loop {
            let v5 = compare(&arg0, &arg1);
            if (v5 == 2 || v5 == 0) {
                let v6 = v3 / 64;
                let v7 = &mut v0;
                put(v7, v6, get(&v0, v6) | 1 << ((v3 % 64) as u8));
                arg0 = sub(arg0, arg1);
            };
            let v8 = arg1;
            arg1 = shr(v8, 1);
            if (v3 == 0) {
                break
            };
            v3 = v3 - 1;
        };
        v0
    }

    fun du256_to_u256(arg0: DU256) : (U256, bool) {
        let v0 = U256{
            limb0 : arg0.limb0,
            limb1 : arg0.limb1,
            limb2 : arg0.limb2,
            limb3 : arg0.limb3,
        };
        let v1 = if (arg0.limb4 != 0) {
            true
        } else if (arg0.limb5 != 0) {
            true
        } else if (arg0.limb6 != 0) {
            true
        } else {
            arg0.limb7 != 0
        };
        (v0, v1)
    }

    public fun from_bytes(arg0: &vector<u8>) : U256 {
        assert!(0x1::vector::length<u8>(arg0) == 32, 4);
        let v0 = zero();
        let v1 = 0;
        while (v1 < 4) {
            let v2 = 0x1::vector::empty<u8>();
            let v3 = 0;
            while (v3 < 8) {
                0x1::vector::push_back<u8>(&mut v2, *0x1::vector::borrow<u8>(arg0, v1 * 8 + v3));
                v3 = v3 + 1;
            };
            let v4 = &mut v0;
            put(v4, v1, from_le_bytes(v2));
            v1 = v1 + 1;
        };
        v0
    }

    fun from_le_bytes(arg0: vector<u8>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 8) {
            v0 = v0 + ((*0x1::vector::borrow<u8>(&arg0, v1) as u64) << ((v1 * 8) as u8));
            v1 = v1 + 1;
        };
        v0
    }

    public fun from_u128(arg0: u128) : U256 {
        let (v0, v1) = split_u128(arg0);
        U256{
            limb0 : v1,
            limb1 : v0,
            limb2 : 0,
            limb3 : 0,
        }
    }

    public fun from_u64(arg0: u64) : U256 {
        from_u128((arg0 as u128))
    }

    public fun get(arg0: &U256, arg1: u64) : u64 {
        if (arg1 == 0) {
            arg0.limb0
        } else if (arg1 == 1) {
            arg0.limb1
        } else if (arg1 == 2) {
            arg0.limb2
        } else {
            assert!(arg1 == 3, 1);
            arg0.limb3
        }
    }

    fun get_d(arg0: &DU256, arg1: u64) : u64 {
        assert!(arg1 < 8, 1);
        if (arg1 == 0) {
            return arg0.limb0
        };
        if (arg1 == 1) {
            return arg0.limb1
        };
        if (arg1 == 2) {
            return arg0.limb2
        };
        if (arg1 == 3) {
            return arg0.limb3
        };
        if (arg1 == 4) {
            return arg0.limb4
        };
        if (arg1 == 5) {
            return arg0.limb5
        };
        if (arg1 == 6) {
            return arg0.limb6
        };
        arg0.limb7
    }

    public fun get_equal() : u8 {
        0
    }

    public fun get_greater_than() : u8 {
        2
    }

    public fun get_less_than() : u8 {
        1
    }

    fun leading_zeros_u64(arg0: u64) : u8 {
        if (arg0 == 0) {
            return 64
        };
        if (arg0 >> 32 == 0) {
            let v0 = 32;
            while (v0 >= 1) {
                if ((arg0 & 4294967295) >> v0 - 1 & 1 != 0) {
                    break
                };
                v0 = v0 - 1;
            };
            return 32 - v0 + 32
        };
        let v1 = 64;
        while (v1 >= 1) {
            if (arg0 >> v1 - 1 & 1 != 0) {
                break
            };
            v1 = v1 - 1;
        };
        64 - v1
    }

    public fun mul(arg0: U256, arg1: U256) : U256 {
        let v0 = DU256{
            limb0 : 0,
            limb1 : 0,
            limb2 : 0,
            limb3 : 0,
            limb4 : 0,
            limb5 : 0,
            limb6 : 0,
            limb7 : 0,
        };
        let v1 = 0;
        while (v1 < 4) {
            let v2 = 0;
            let v3 = 0;
            while (v3 < 4) {
                let v4 = get(&arg0, v3);
                if (v4 != 0 || v2 != 0) {
                    let (v5, v6) = split_u128((v4 as u128) * (get(&arg1, v1) as u128));
                    let (v7, v8) = overflowing_add(v6, get_d(&v0, v1 + v3));
                    let v9 = &mut v0;
                    put_d(v9, v1 + v3, v7);
                    let v10 = if (v8) {
                        1
                    } else {
                        0
                    };
                    let (v11, v12) = overflowing_add(v5 + v10, v2);
                    let (v13, v14) = overflowing_add(v11, get_d(&v0, v1 + v3 + 1));
                    let v15 = &mut v0;
                    put_d(v15, v1 + v3 + 1, v13);
                    let v16 = if (v12 || v14) {
                        1
                    } else {
                        0
                    };
                    v2 = v16;
                };
                v3 = v3 + 1;
            };
            v1 = v1 + 1;
        };
        let (v17, v18) = du256_to_u256(v0);
        assert!(!v18, 2);
        v17
    }

    public fun or(arg0: &U256, arg1: &U256) : U256 {
        let v0 = zero();
        let v1 = 0;
        while (v1 < 4) {
            let v2 = &mut v0;
            put(v2, v1, get(arg0, v1) | get(arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    fun overflowing_add(arg0: u64, arg1: u64) : (u64, bool) {
        let v0 = (((arg0 as u128) + (arg1 as u128)) as u128);
        if (v0 > 18446744073709551615) {
            (((v0 - 18446744073709551615 - 1) as u64), true)
        } else {
            ((v0 as u64), false)
        }
    }

    fun overflowing_sub(arg0: u64, arg1: u64) : (u64, bool) {
        if (arg0 < arg1) {
            ((18446744073709551615 as u64) - arg1 - arg0 + 1, true)
        } else {
            (arg0 - arg1, false)
        }
    }

    fun put(arg0: &mut U256, arg1: u64, arg2: u64) {
        assert!(arg1 < 4, 1);
        if (arg1 == 0) {
            arg0.limb0 = arg2;
            return
        };
        if (arg1 == 1) {
            arg0.limb1 = arg2;
            return
        };
        if (arg1 == 2) {
            arg0.limb2 = arg2;
            return
        };
        arg0.limb3 = arg2;
    }

    fun put_d(arg0: &mut DU256, arg1: u64, arg2: u64) {
        assert!(arg1 < 8, 1);
        if (arg1 == 0) {
            arg0.limb0 = arg2;
            return
        };
        if (arg1 == 1) {
            arg0.limb1 = arg2;
            return
        };
        if (arg1 == 2) {
            arg0.limb2 = arg2;
            return
        };
        if (arg1 == 3) {
            arg0.limb3 = arg2;
            return
        };
        if (arg1 == 4) {
            arg0.limb4 = arg2;
            return
        };
        if (arg1 == 5) {
            arg0.limb5 = arg2;
            return
        };
        if (arg1 == 6) {
            arg0.limb6 = arg2;
            return
        };
        arg0.limb7 = arg2;
    }

    public fun shl(arg0: U256, arg1: u8) : U256 {
        let v0 = zero();
        let v1 = (arg1 as u64) / 64;
        let v2 = (arg1 as u64) % 64;
        while (v1 < 4) {
            let v3 = &mut v0;
            put(v3, v1, get(&arg0, v1 - v1) << (v2 as u8));
            v1 = v1 + 1;
        };
        if (v2 > 0) {
            let v4 = v1 + 1;
            while (v4 < 4) {
                let v5 = &mut v0;
                put(v5, v4, get(&v0, v4) + (get(&arg0, v4 - 1 - v1) >> ((64 - v2) as u8)));
                v4 = v4 + 1;
            };
        };
        v0
    }

    public fun shr(arg0: U256, arg1: u8) : U256 {
        let v0 = zero();
        let v1 = (arg1 as u64) / 64;
        let v2 = (arg1 as u64) % 64;
        while (v1 < 4) {
            let v3 = &mut v0;
            put(v3, v1 - v1, get(&arg0, v1) >> (v2 as u8));
            v1 = v1 + 1;
        };
        if (v2 > 0) {
            let v4 = v1 + 1;
            while (v4 < 4) {
                let v5 = &mut v0;
                put(v5, v4 - v1 - 1, get(&v0, v4 - v1 - 1) + (get(&arg0, v4) << ((64 - v2) as u8)));
                v4 = v4 + 1;
            };
        };
        v0
    }

    fun split_u128(arg0: u128) : (u64, u64) {
        (((arg0 >> 64) as u64), ((arg0 & 18446744073709551615) as u64))
    }

    public fun sub(arg0: U256, arg1: U256) : U256 {
        let v0 = zero();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 4) {
            if (v1 != 0) {
                let (v3, v4) = overflowing_sub(get(&arg0, v2), get(&arg1, v2));
                let (v5, v6) = overflowing_sub(v3, v1);
                let v7 = &mut v0;
                put(v7, v2, v5);
                let v8 = 0;
                v1 = v8;
                if (v4) {
                    v1 = v8 + 1;
                };
                if (v6) {
                    v1 = v1 + 1;
                };
            } else {
                let (v9, v10) = overflowing_sub(get(&arg0, v2), get(&arg1, v2));
                let v11 = &mut v0;
                put(v11, v2, v9);
                v1 = 0;
                if (v10) {
                    v1 = 1;
                };
            };
            v2 = v2 + 1;
        };
        assert!(v1 == 0, 2);
        v0
    }

    public fun xor(arg0: &U256, arg1: &U256) : U256 {
        let v0 = zero();
        let v1 = 0;
        while (v1 < 4) {
            let v2 = &mut v0;
            put(v2, v1, get(arg0, v1) ^ get(arg1, v1));
            v1 = v1 + 1;
        };
        v0
    }

    public fun zero() : U256 {
        U256{
            limb0 : 0,
            limb1 : 0,
            limb2 : 0,
            limb3 : 0,
        }
    }

    // decompiled from Move bytecode v6
}

