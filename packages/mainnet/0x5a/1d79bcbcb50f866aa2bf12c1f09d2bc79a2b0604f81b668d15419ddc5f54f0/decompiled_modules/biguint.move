module 0x5a1d79bcbcb50f866aa2bf12c1f09d2bc79a2b0604f81b668d15419ddc5f54f0::biguint {
    public fun add(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0x1::vector::length<u64>(arg1);
        let v2 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        let v3 = vector[];
        let v4 = 0;
        let v5 = 0;
        while (v5 < v2) {
            let v6 = if (v5 < v0) {
                *0x1::vector::borrow<u64>(arg0, v5)
            } else {
                0
            };
            let v7 = if (v5 < v1) {
                *0x1::vector::borrow<u64>(arg1, v5)
            } else {
                0
            };
            let v8 = (v6 as u128) + (v7 as u128) + v4;
            0x1::vector::push_back<u64>(&mut v3, ((v8 & 18446744073709551615) as u64));
            v4 = v8 >> 64;
            v5 = v5 + 1;
        };
        if (v4 > 0) {
            0x1::vector::push_back<u64>(&mut v3, (v4 as u64));
        };
        normalize(v3)
    }

    fun bit_len64(arg0: u64) : u64 {
        let v0 = 0;
        while (arg0 > 0) {
            arg0 = arg0 >> 1;
            v0 = v0 + 1;
        };
        v0
    }

    public fun cmp(arg0: &vector<u64>, arg1: &vector<u64>) : u8 {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0x1::vector::length<u64>(arg1);
        let v2 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        let v3 = v2;
        let v4 = 1;
        while (v3 > 0 && v4 == 1) {
            let v5 = v3 - 1;
            v3 = v5;
            let v6 = if (v5 < v0) {
                *0x1::vector::borrow<u64>(arg0, v5)
            } else {
                0
            };
            let v7 = if (v5 < v1) {
                *0x1::vector::borrow<u64>(arg1, v5)
            } else {
                0
            };
            if (v6 < v7) {
                v4 = 0;
                continue
            };
            if (v6 > v7) {
                v4 = 2;
            };
        };
        v4
    }

    public fun div(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let (v0, _) = divmod(arg0, arg1);
        v0
    }

    public fun div_up(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let (v0, v1) = divmod(arg0, arg1);
        let v2 = v1;
        let v3 = v0;
        if (0x1::vector::length<u64>(&v2) == 0) {
            v3
        } else {
            let v5 = vector[1];
            add(&v3, &v5)
        }
    }

    public fun divmod(arg0: &vector<u64>, arg1: &vector<u64>) : (vector<u64>, vector<u64>) {
        let v0 = vector[];
        assert!(cmp(arg1, &v0) != 1, 2);
        let v1 = vector[];
        let v2 = vector[];
        let v3 = 64 * 0x1::vector::length<u64>(arg0);
        while (v3 > 0) {
            v3 = v3 - 1;
            let v4 = &v2;
            v2 = mul_small_add(v4, 2, *0x1::vector::borrow<u64>(arg0, v3 / 64) >> ((v3 % 64) as u8) & 1);
            let v5 = cmp(&v2, arg1) != 0;
            if (v5) {
                let v6 = &v2;
                v2 = sub(v6, arg1);
            };
            let v7 = &v1;
            let v8 = if (v5) {
                1
            } else {
                0
            };
            v1 = mul_small_add(v7, 2, v8);
        };
        (v1, v2)
    }

    public fun eq(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        cmp(arg0, arg1) == 1
    }

    public fun from_bytes_be(arg0: &vector<u8>) : vector<u64> {
        let v0 = vector[];
        let v1 = 0;
        while (v1 < 0x1::vector::length<u8>(arg0)) {
            let v2 = &v0;
            v0 = mul_small_add(v2, 256, (*0x1::vector::borrow<u8>(arg0, v1) as u64));
            v1 = v1 + 1;
        };
        v0
    }

    public fun from_u128(arg0: u128) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, ((arg0 & 18446744073709551615) as u64));
        0x1::vector::push_back<u64>(v1, ((arg0 >> 64) as u64));
        normalize(v0)
    }

    public fun from_u256(arg0: u256) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        let v1 = &mut v0;
        0x1::vector::push_back<u64>(v1, ((arg0 & 18446744073709551615) as u64));
        0x1::vector::push_back<u64>(v1, ((arg0 >> 64 & 18446744073709551615) as u64));
        0x1::vector::push_back<u64>(v1, ((arg0 >> 128 & 18446744073709551615) as u64));
        0x1::vector::push_back<u64>(v1, ((arg0 >> 192) as u64));
        normalize(v0)
    }

    public fun from_u64(arg0: u64) : vector<u64> {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg0);
        normalize(v0)
    }

    public fun is_zero(arg0: &vector<u64>) : bool {
        let v0 = vector[];
        cmp(arg0, &v0) == 1
    }

    public fun le(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        cmp(arg0, arg1) != 2
    }

    public fun low_limbs(arg0: &vector<u64>, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = if (arg1 < v0) {
            arg1
        } else {
            v0
        };
        let v2 = vector[];
        let v3 = 0;
        while (v3 < v1) {
            0x1::vector::push_back<u64>(&mut v2, *0x1::vector::borrow<u64>(arg0, v3));
            v3 = v3 + 1;
        };
        normalize(v2)
    }

    public fun lt(arg0: &vector<u64>, arg1: &vector<u64>) : bool {
        cmp(arg0, arg1) == 0
    }

    public fun mod_pow(arg0: &vector<u64>, arg1: &vector<u64>, arg2: &vector<u64>) : vector<u64> {
        let v0 = vector[];
        assert!(cmp(arg2, &v0) != 1, 2);
        let v1 = vector[1];
        let v2 = rem(&v1, arg2);
        let v3 = rem(arg0, arg2);
        let v4 = 0;
        while (v4 < 64 * 0x1::vector::length<u64>(arg1)) {
            if (*0x1::vector::borrow<u64>(arg1, v4 / 64) >> ((v4 % 64) as u8) & 1 == 1) {
                let v5 = mul(&v2, &v3);
                v2 = rem(&v5, arg2);
            };
            let v6 = mul(&v3, &v3);
            v3 = rem(&v6, arg2);
            v4 = v4 + 1;
        };
        v2
    }

    public fun mul(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0x1::vector::length<u64>(arg1);
        let v2 = vector[];
        let v3 = 0;
        while (v3 < v0 + v1) {
            0x1::vector::push_back<u64>(&mut v2, 0);
            v3 = v3 + 1;
        };
        let v4 = 0;
        while (v4 < v0) {
            let v5 = 0;
            let v6 = 0;
            while (v6 < v1) {
                let v7 = (*0x1::vector::borrow<u64>(&v2, v4 + v6) as u128) + (*0x1::vector::borrow<u64>(arg0, v4) as u128) * (*0x1::vector::borrow<u64>(arg1, v6) as u128) + v5;
                *0x1::vector::borrow_mut<u64>(&mut v2, v4 + v6) = ((v7 & 18446744073709551615) as u64);
                v5 = v7 >> 64;
                v6 = v6 + 1;
            };
            *0x1::vector::borrow_mut<u64>(&mut v2, v4 + v1) = (v5 as u64);
            v4 = v4 + 1;
        };
        normalize(v2)
    }

    public fun mul_karatsuba(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0x1::vector::length<u64>(arg1);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        if (v2 < 32) {
            return mul(arg0, arg1)
        };
        let v3 = v2 / 2;
        let v4 = low_limbs(arg0, v3);
        let v5 = shr_limbs(arg0, v3);
        let v6 = low_limbs(arg1, v3);
        let v7 = shr_limbs(arg1, v3);
        let v8 = mul_karatsuba(&v4, &v6);
        let v9 = mul_karatsuba(&v5, &v7);
        let v10 = add(&v4, &v5);
        let v11 = add(&v6, &v7);
        let v12 = mul_karatsuba(&v10, &v11);
        let v13 = sub(&v12, &v8);
        let v14 = sub(&v13, &v9);
        let v15 = shl_limbs(&v9, 2 * v3);
        let v16 = shl_limbs(&v14, v3);
        let v17 = add(&v15, &v16);
        add(&v17, &v8)
    }

    public fun mul_small_add(arg0: &vector<u64>, arg1: u64, arg2: u64) : vector<u64> {
        let v0 = vector[];
        let v1 = (arg2 as u128);
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg0)) {
            let v3 = (*0x1::vector::borrow<u64>(arg0, v2) as u128) * (arg1 as u128) + v1;
            0x1::vector::push_back<u64>(&mut v0, ((v3 & 18446744073709551615) as u64));
            v1 = v3 >> 64;
            v2 = v2 + 1;
        };
        if (v1 > 0) {
            0x1::vector::push_back<u64>(&mut v0, (v1 as u64));
        };
        normalize(v0)
    }

    public fun normalize(arg0: vector<u64>) : vector<u64> {
        let v0 = true;
        while (v0) {
            let v1 = 0x1::vector::length<u64>(&arg0);
            if (v1 == 0) {
                v0 = false;
                continue
            };
            if (*0x1::vector::borrow<u64>(&arg0, v1 - 1) == 0) {
                0x1::vector::pop_back<u64>(&mut arg0);
                continue
            };
            v0 = false;
        };
        arg0
    }

    public fun pow(arg0: &vector<u64>, arg1: u64) : vector<u64> {
        let v0 = normalize(*arg0);
        pow_check(&v0, arg1);
        let v1 = vector[1];
        let v2 = arg1;
        while (v2 > 0) {
            if (v2 & 1 == 1) {
                let v3 = &v1;
                v1 = mul(v3, &v0);
            };
            v2 = v2 >> 1;
            if (v2 > 0) {
                let v4 = &v0;
                let v5 = &v0;
                v0 = mul(v4, v5);
            };
        };
        v1
    }

    fun pow_check(arg0: &vector<u64>, arg1: u64) {
        let v0 = 0x1::vector::length<u64>(arg0);
        if (v0 > 0) {
            let v1 = v0 - 1;
            let v2 = 64 * v1 + bit_len64(*0x1::vector::borrow<u64>(arg0, v1));
            if (v2 > 1) {
                assert!(arg1 <= 8388608 / v2, 4);
            };
        };
    }

    public fun rem(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let (_, v1) = divmod(arg0, arg1);
        v1
    }

    public fun shl_limbs(arg0: &vector<u64>, arg1: u64) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg0);
        assert!(arg1 <= 262144 - v0, 4);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < arg1) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        let v3 = 0;
        while (v3 < v0) {
            0x1::vector::push_back<u64>(&mut v1, *0x1::vector::borrow<u64>(arg0, v3));
            v3 = v3 + 1;
        };
        normalize(v1)
    }

    public fun shr_limbs(arg0: &vector<u64>, arg1: u64) : vector<u64> {
        let v0 = vector[];
        while (arg1 < 0x1::vector::length<u64>(arg0)) {
            0x1::vector::push_back<u64>(&mut v0, *0x1::vector::borrow<u64>(arg0, arg1));
            arg1 = arg1 + 1;
        };
        normalize(v0)
    }

    public fun sub(arg0: &vector<u64>, arg1: &vector<u64>) : vector<u64> {
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = 0x1::vector::length<u64>(arg1);
        let v2 = if (v0 > v1) {
            v0
        } else {
            v1
        };
        let v3 = vector[];
        let v4 = 0;
        let v5 = 0;
        while (v5 < v2) {
            let v6 = if (v5 < v0) {
                *0x1::vector::borrow<u64>(arg0, v5)
            } else {
                0
            };
            let v7 = if (v5 < v1) {
                *0x1::vector::borrow<u64>(arg1, v5)
            } else {
                0
            };
            let v8 = (v6 as u128) + 18446744073709551616 - (v7 as u128) - v4;
            0x1::vector::push_back<u64>(&mut v3, ((v8 & 18446744073709551615) as u64));
            v4 = 1 - (v8 >> 64);
            v5 = v5 + 1;
        };
        assert!(v4 == 0, 1);
        normalize(v3)
    }

    public fun to_bytes_be(arg0: &vector<u64>, arg1: u64) : vector<u8> {
        assert!(arg1 <= 262144, 4);
        let v0 = 0x1::vector::length<u64>(arg0);
        let v1 = false;
        while (arg1 < 8 * v0) {
            let v2 = if (arg1 / 8 < v0) {
                ((*0x1::vector::borrow<u64>(arg0, arg1 / 8) >> ((arg1 % 8 * 8) as u8) & 255) as u8)
            } else {
                0
            };
            if (v2 != 0) {
                v1 = true;
            };
            arg1 = arg1 + 1;
        };
        assert!(!v1, 3);
        let v3 = b"";
        while (arg1 > 0) {
            let v4 = arg1 - 1;
            arg1 = v4;
            let v5 = if (v4 / 8 < v0) {
                ((*0x1::vector::borrow<u64>(arg0, v4 / 8) >> ((v4 % 8 * 8) as u8) & 255) as u8)
            } else {
                0
            };
            0x1::vector::push_back<u8>(&mut v3, v5);
        };
        v3
    }

    public fun to_u256(arg0: &vector<u64>) : u256 {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg0)) {
            if (v2 < 4) {
                v0 = v0 + ((*0x1::vector::borrow<u64>(arg0, v2) as u256) << ((64 * v2) as u8));
            } else if (*0x1::vector::borrow<u64>(arg0, v2) != 0) {
                v1 = true;
            };
            v2 = v2 + 1;
        };
        assert!(!v1, 3);
        v0
    }

    // decompiled from Move bytecode v7
}

