module 0x3ccc10004748a26c3da77c8be634d94494a608c352d66fd11ae7f0339df22496::bn254_mod_mul {
    fun accumulate_product_row(arg0: &mut vector<u128>, arg1: u64, arg2: u128, arg3: u128, arg4: u128) {
        let (v0, v1) = mac_u128(*0x1::vector::borrow<u128>(arg0, arg1), arg2, arg3, 0);
        *0x1::vector::borrow_mut<u128>(arg0, arg1) = v0;
        let v2 = arg1 + 1;
        let (v3, v4) = mac_u128(*0x1::vector::borrow<u128>(arg0, v2), arg2, arg4, v1);
        *0x1::vector::borrow_mut<u128>(arg0, v2) = v3;
        propagate_carry(arg0, arg1 + 2, v4);
    }

    fun add_u128_with_carry(arg0: u128, arg1: u128) : (u128, u128) {
        let v0 = (arg0 as u256) + (arg1 as u256);
        (low_u128(v0), high_u128(v0))
    }

    fun from_montgomery(arg0: u256) : u256 {
        montgomery_mul_raw(arg0, 1)
    }

    fun from_u128_limbs(arg0: u128, arg1: u128) : u256 {
        (arg0 as u256) | (arg1 as u256) << 128
    }

    fun high_u128(arg0: u256) : u128 {
        ((arg0 >> 128) as u128)
    }

    fun low_u128(arg0: u256) : u128 {
        ((arg0 & 340282366920938463463374607431768211455) as u128)
    }

    fun mac_u128(arg0: u128, arg1: u128, arg2: u128, arg3: u128) : (u128, u128) {
        let v0 = (arg0 as u256) + (arg1 as u256) * (arg2 as u256) + (arg3 as u256);
        (low_u128(v0), high_u128(v0))
    }

    fun montgomery_mul_raw(arg0: u256, arg1: u256) : u256 {
        let (v0, v1) = to_u128_limbs(arg0);
        let (v2, v3) = to_u128_limbs(arg1);
        let v4 = vector[0, 0, 0, 0, 0];
        let v5 = &mut v4;
        accumulate_product_row(v5, 0, v0, v2, v3);
        let v6 = &mut v4;
        accumulate_product_row(v6, 1, v1, v2, v3);
        let v7 = &mut v4;
        montgomery_reduce_word(v7, 0);
        let v8 = &mut v4;
        montgomery_reduce_word(v8, 1);
        let v9 = *0x1::vector::borrow<u128>(&v4, 2);
        let v10 = v9;
        let v11 = *0x1::vector::borrow<u128>(&v4, 3);
        let v12 = v11;
        let v13 = *0x1::vector::borrow<u128>(&v4, 4);
        if (result_geq_modulus(v9, v11, v13)) {
            let (v14, v15) = sub_with_borrow(v9, 201385395114098847380338600778089168199, 0);
            v10 = v14;
            let (v16, v17) = sub_with_borrow(v11, 64323764613183177041862057485226039389, v15);
            v12 = v16;
            let (_, v19) = sub_with_borrow(v13, 0, v17);
            assert!(v19 == 0, 0);
        };
        from_u128_limbs(v10, v12)
    }

    fun montgomery_reduce_word(arg0: &mut vector<u128>, arg1: u64) {
        let v0 = low_u128((*0x1::vector::borrow<u128>(arg0, arg1) as u256) * (211173256549385567650468519415768310665 as u256));
        let (v1, v2) = mac_u128(*0x1::vector::borrow<u128>(arg0, arg1), v0, 201385395114098847380338600778089168199, 0);
        *0x1::vector::borrow_mut<u128>(arg0, arg1) = v1;
        assert!(v1 == 0, 13906834874423050239);
        let v3 = arg1 + 1;
        let (v4, v5) = mac_u128(*0x1::vector::borrow<u128>(arg0, v3), v0, 64323764613183177041862057485226039389, v2);
        *0x1::vector::borrow_mut<u128>(arg0, v3) = v4;
        propagate_carry(arg0, arg1 + 2, v5);
    }

    public fun mul_mod(arg0: u256, arg1: u256) : u256 {
        let v0 = normalize_input(arg0);
        let v1 = normalize_input(arg1);
        if (v0 == 0 || v1 == 0) {
            return 0
        };
        from_montgomery(montgomery_mul_raw(to_montgomery(v0), to_montgomery(v1)))
    }

    fun normalize_input(arg0: u256) : u256 {
        if (arg0 >= 21888242871839275222246405745257275088696311157297823662689037894645226208583) {
            arg0 % 21888242871839275222246405745257275088696311157297823662689037894645226208583
        } else {
            arg0
        }
    }

    public fun pow3_mod(arg0: u256) : u256 {
        let v0 = normalize_input(arg0);
        if (v0 == 0) {
            return 0
        };
        let v1 = to_montgomery(v0);
        from_montgomery(montgomery_mul_raw(montgomery_mul_raw(v1, v1), v1))
    }

    fun propagate_carry(arg0: &mut vector<u128>, arg1: u64, arg2: u128) {
        while (arg2 > 0) {
            let (v0, v1) = add_u128_with_carry(*0x1::vector::borrow<u128>(arg0, arg1), arg2);
            arg2 = v1;
            *0x1::vector::borrow_mut<u128>(arg0, arg1) = v0;
            arg1 = arg1 + 1;
        };
    }

    fun result_geq_modulus(arg0: u128, arg1: u128, arg2: u128) : bool {
        if (arg2 > 0) {
            return true
        };
        if (arg1 != 64323764613183177041862057485226039389) {
            return arg1 > 64323764613183177041862057485226039389
        };
        arg0 >= 201385395114098847380338600778089168199
    }

    fun sub_with_borrow(arg0: u128, arg1: u128, arg2: u128) : (u128, u128) {
        let v0 = (arg1 as u256) + (arg2 as u256);
        if ((arg0 as u256) >= v0) {
            ((((arg0 as u256) - v0) as u128), 0)
        } else {
            (((340282366920938463463374607431768211456 + (arg0 as u256) - v0) as u128), 1)
        }
    }

    fun to_montgomery(arg0: u256) : u256 {
        montgomery_mul_raw(arg0, 3096616502983703923843567936837374451735540968419076528771170197431451843209)
    }

    fun to_u128_limbs(arg0: u256) : (u128, u128) {
        (((arg0 & 340282366920938463463374607431768211455) as u128), ((arg0 >> 128) as u128))
    }

    // decompiled from Move bytecode v6
}

