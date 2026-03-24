module 0x4c5bb62df78bb552f6a49aa42bd202fdedd7cfd08d4acb093e7e4b021f84668b::utils {
    fun accumulate_product_row(arg0: &mut vector<u64>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let (v0, v1) = mac_u64(*0x1::vector::borrow<u64>(arg0, arg1), arg2, arg3, 0);
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = v0;
        let v2 = arg1 + 1;
        let (v3, v4) = mac_u64(*0x1::vector::borrow<u64>(arg0, v2), arg2, arg4, v1);
        *0x1::vector::borrow_mut<u64>(arg0, v2) = v3;
        let v5 = arg1 + 2;
        let (v6, v7) = mac_u64(*0x1::vector::borrow<u64>(arg0, v5), arg2, arg5, v4);
        *0x1::vector::borrow_mut<u64>(arg0, v5) = v6;
        let v8 = arg1 + 3;
        let (v9, v10) = mac_u64(*0x1::vector::borrow<u64>(arg0, v8), arg2, arg6, v7);
        *0x1::vector::borrow_mut<u64>(arg0, v8) = v9;
        propagate_carry(arg0, arg1 + 4, v10);
    }

    public fun add_mod(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 % arg2;
        let v1 = arg1 % arg2;
        if (v0 >= arg2 - v1) {
            v0 - arg2 - v1
        } else {
            v0 + v1
        }
    }

    public fun add_mod_unchecked(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg0 >= arg2 - arg1) {
            arg0 - arg2 - arg1
        } else {
            arg0 + arg1
        }
    }

    fun add_u64_with_carry(arg0: u64, arg1: u64) : (u64, u64) {
        let v0 = (arg0 as u128) + (arg1 as u128);
        (low_u64(v0), high_u64(v0))
    }

    public fun be_bytes_to_u256(arg0: vector<u8>) : u256 {
        assert!(0x1::vector::length<u8>(&arg0) == 32, 1);
        0x1::vector::reverse<u8>(&mut arg0);
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_u256(&mut v0)
    }

    fun bn254_result_geq_modulus(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : bool {
        if (arg4 > 0) {
            return true
        };
        if (arg3 != 3486998266802970665) {
            return arg3 > 3486998266802970665
        };
        if (arg2 != 13281191951274694749) {
            return arg2 > 13281191951274694749
        };
        if (arg1 != 10917124144477883021) {
            return arg1 > 10917124144477883021
        };
        arg0 >= 4332616871279656263
    }

    fun from_u64_limbs(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u256 {
        (arg0 as u256) | (arg1 as u256) << 64 | (arg2 as u256) << 128 | (arg3 as u256) << 192
    }

    fun high_u64(arg0: u128) : u64 {
        ((arg0 >> 64) as u64)
    }

    fun low_u64(arg0: u128) : u64 {
        ((arg0 & 18446744073709551615) as u64)
    }

    fun mac_u64(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64) {
        let v0 = (arg0 as u128) + (arg1 as u128) * (arg2 as u128) + (arg3 as u128);
        (low_u64(v0), high_u64(v0))
    }

    fun montgomery_mul_bn254_raw(arg0: u256, arg1: u256) : u256 {
        let (v0, v1, v2, v3) = to_u64_limbs(arg0);
        let (v4, v5, v6, v7) = to_u64_limbs(arg1);
        let v8 = vector[0, 0, 0, 0, 0, 0, 0, 0, 0];
        let v9 = &mut v8;
        accumulate_product_row(v9, 0, v0, v4, v5, v6, v7);
        let v10 = &mut v8;
        accumulate_product_row(v10, 1, v1, v4, v5, v6, v7);
        let v11 = &mut v8;
        accumulate_product_row(v11, 2, v2, v4, v5, v6, v7);
        let v12 = &mut v8;
        accumulate_product_row(v12, 3, v3, v4, v5, v6, v7);
        let v13 = &mut v8;
        montgomery_reduce_word(v13, 0);
        let v14 = &mut v8;
        montgomery_reduce_word(v14, 1);
        let v15 = &mut v8;
        montgomery_reduce_word(v15, 2);
        let v16 = &mut v8;
        montgomery_reduce_word(v16, 3);
        let v17 = *0x1::vector::borrow<u64>(&v8, 4);
        let v18 = v17;
        let v19 = *0x1::vector::borrow<u64>(&v8, 5);
        let v20 = v19;
        let v21 = *0x1::vector::borrow<u64>(&v8, 6);
        let v22 = v21;
        let v23 = *0x1::vector::borrow<u64>(&v8, 7);
        let v24 = v23;
        let v25 = *0x1::vector::borrow<u64>(&v8, 8);
        if (bn254_result_geq_modulus(v17, v19, v21, v23, v25)) {
            let (v26, v27) = sub_with_borrow(v17, 4332616871279656263, 0);
            v18 = v26;
            let (v28, v29) = sub_with_borrow(v19, 10917124144477883021, v27);
            v20 = v28;
            let (v30, v31) = sub_with_borrow(v21, 13281191951274694749, v29);
            v22 = v30;
            let (v32, v33) = sub_with_borrow(v23, 3486998266802970665, v31);
            v24 = v32;
            let (_, v35) = sub_with_borrow(v25, 0, v33);
            assert!(v35 == 0, 0);
        };
        from_u64_limbs(v18, v20, v22, v24)
    }

    fun montgomery_reduce_word(arg0: &mut vector<u64>, arg1: u64) {
        let v0 = low_u64((*0x1::vector::borrow<u64>(arg0, arg1) as u128) * (9786893198990664585 as u128));
        let (v1, v2) = mac_u64(*0x1::vector::borrow<u64>(arg0, arg1), v0, 4332616871279656263, 0);
        *0x1::vector::borrow_mut<u64>(arg0, arg1) = v1;
        let v3 = arg1 + 1;
        let (v4, v5) = mac_u64(*0x1::vector::borrow<u64>(arg0, v3), v0, 10917124144477883021, v2);
        *0x1::vector::borrow_mut<u64>(arg0, v3) = v4;
        let v6 = arg1 + 2;
        let (v7, v8) = mac_u64(*0x1::vector::borrow<u64>(arg0, v6), v0, 13281191951274694749, v5);
        *0x1::vector::borrow_mut<u64>(arg0, v6) = v7;
        let v9 = arg1 + 3;
        let (v10, v11) = mac_u64(*0x1::vector::borrow<u64>(arg0, v9), v0, 3486998266802970665, v8);
        *0x1::vector::borrow_mut<u64>(arg0, v9) = v10;
        propagate_carry(arg0, arg1 + 4, v11);
    }

    public fun mul_mod(arg0: u256, arg1: u256, arg2: u256) : u256 {
        if (arg2 == 21888242871839275222246405745257275088696311157297823662689037894645226208583) {
            return mul_mod_bn254(arg0, arg1)
        };
        mul_mod_generic(arg0, arg1, arg2)
    }

    fun mul_mod_bn254(arg0: u256, arg1: u256) : u256 {
        let v0 = arg0 % 21888242871839275222246405745257275088696311157297823662689037894645226208583;
        let v1 = arg1 % 21888242871839275222246405745257275088696311157297823662689037894645226208583;
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        montgomery_mul_bn254_raw(montgomery_mul_bn254_raw(montgomery_mul_bn254_raw(v0, 3096616502983703923843567936837374451735540968419076528771170197431451843209), montgomery_mul_bn254_raw(v1, 3096616502983703923843567936837374451735540968419076528771170197431451843209)), 1)
    }

    fun mul_mod_generic(arg0: u256, arg1: u256, arg2: u256) : u256 {
        let v0 = arg0 % arg2;
        let v1 = arg1 % arg2;
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        let v2 = 0;
        let v3 = v1;
        while (v3 > 0) {
            if (v3 & 1 == 1) {
                v2 = add_mod_unchecked(v2, v0, arg2);
            };
            v3 = v3 >> 1;
            if (v3 > 0) {
                v0 = add_mod_unchecked(v0, v0, arg2);
            };
        };
        v2
    }

    fun propagate_carry(arg0: &mut vector<u64>, arg1: u64, arg2: u64) {
        while (arg2 > 0) {
            let (v0, v1) = add_u64_with_carry(*0x1::vector::borrow<u64>(arg0, arg1), arg2);
            arg2 = v1;
            *0x1::vector::borrow_mut<u64>(arg0, arg1) = v0;
            arg1 = arg1 + 1;
        };
    }

    fun sub_with_borrow(arg0: u64, arg1: u64, arg2: u64) : (u64, u64) {
        let v0 = (arg1 as u128) + (arg2 as u128);
        if ((arg0 as u128) >= v0) {
            ((((arg0 as u128) - v0) as u64), 0)
        } else {
            (((18446744073709551616 + (arg0 as u128) - v0) as u64), 1)
        }
    }

    fun to_u64_limbs(arg0: u256) : (u64, u64, u64, u64) {
        (((arg0 & 18446744073709551615) as u64), ((arg0 >> 64 & 18446744073709551615) as u64), ((arg0 >> 128 & 18446744073709551615) as u64), ((arg0 >> 192 & 18446744073709551615) as u64))
    }

    public fun u256_to_be_bytes(arg0: u256) : vector<u8> {
        let v0 = 0x2::bcs::to_bytes<u256>(&arg0);
        0x1::vector::reverse<u8>(&mut v0);
        v0
    }

    public fun u64_to_be_bytes(arg0: u64) : vector<u8> {
        let v0 = 0x1::vector::empty<u8>();
        let v1 = &mut v0;
        0x1::vector::push_back<u8>(v1, ((arg0 >> 56 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 48 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 40 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 32 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 24 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 16 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 >> 8 & 255) as u8));
        0x1::vector::push_back<u8>(v1, ((arg0 & 255) as u8));
        v0
    }

    // decompiled from Move bytecode v6
}

