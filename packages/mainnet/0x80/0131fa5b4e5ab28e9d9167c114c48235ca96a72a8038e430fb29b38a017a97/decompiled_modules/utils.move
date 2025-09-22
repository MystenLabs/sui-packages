module 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::utils {
    public fun get_delta_a(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let (v1, v2) = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u256_utils::checked_shlw(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::full_mul(arg2, v0));
        if (v2) {
            abort 2
        };
        (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u256_utils::div_round(v1, 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::full_mul(arg0, arg1), arg3) as u64)
    }

    public fun get_delta_b(arg0: u128, arg1: u128, arg2: u128, arg3: bool) : u64 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        if (v0 == 0 || arg2 == 0) {
            return 0
        };
        let v1 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::full_mul(arg2, v0);
        if (arg3 && v1 & 18446744073709551615 > 0) {
            return (((v1 >> 64) + 1) as u64)
        };
        ((v1 >> 64) as u64)
    }

    public fun get_liquidity_by_amount(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u128, arg4: u64, arg5: bool) : (u128, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = if (arg5) {
            v0 = arg4;
            if (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::lt(arg2, arg0)) {
                get_liquidity_from_a(get_sqrt_price_at_tick(arg0), get_sqrt_price_at_tick(arg1), arg4, false)
            } else {
                assert!(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::lt(arg2, arg1), 114516);
                let v3 = get_liquidity_from_a(arg3, get_sqrt_price_at_tick(arg1), arg4, false);
                v1 = get_delta_b(arg3, get_sqrt_price_at_tick(arg0), v3, true);
                v3
            }
        } else {
            v1 = arg4;
            if (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::gte(arg2, arg1)) {
                get_liquidity_from_b(get_sqrt_price_at_tick(arg0), get_sqrt_price_at_tick(arg1), arg4, false)
            } else {
                assert!(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::gte(arg2, arg0), 114517);
                let v4 = get_liquidity_from_b(get_sqrt_price_at_tick(arg0), arg3, arg4, false);
                v0 = get_delta_a(arg3, get_sqrt_price_at_tick(arg1), v4, true);
                v4
            }
        };
        (v2, v0, v1)
    }

    public fun get_liquidity_from_a(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u256_utils::div_round((0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::full_mul(arg0, arg1) >> 64) * (arg2 as u256), (v0 as u256), arg3) as u128)
    }

    public fun get_liquidity_from_b(arg0: u128, arg1: u128, arg2: u64, arg3: bool) : u128 {
        let v0 = if (arg0 > arg1) {
            arg0 - arg1
        } else {
            arg1 - arg0
        };
        (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u256_utils::div_round((arg2 as u256) << 64, (v0 as u256), arg3) as u128)
    }

    fun get_sqrt_price_at_negative_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::as_u32(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::abs(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::mate_to_lib(arg0)));
        let v1 = if (v0 & 1 != 0) {
            18445821805675392311
        } else {
            18446744073709551616
        };
        let v2 = v1;
        if (v0 & 2 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v1, 18444899583751176498, 64);
        };
        if (v0 & 4 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 18443055278223354162, 64);
        };
        if (v0 & 8 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 18439367220385604838, 64);
        };
        if (v0 & 16 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 18431993317065449817, 64);
        };
        if (v0 & 32 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 18417254355718160513, 64);
        };
        if (v0 & 64 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 18387811781193591352, 64);
        };
        if (v0 & 128 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 18329067761203520168, 64);
        };
        if (v0 & 256 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 18212142134806087854, 64);
        };
        if (v0 & 512 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 17980523815641551639, 64);
        };
        if (v0 & 1024 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 17526086738831147013, 64);
        };
        if (v0 & 2048 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 16651378430235024244, 64);
        };
        if (v0 & 4096 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 15030750278693429944, 64);
        };
        if (v0 & 8192 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 12247334978882834399, 64);
        };
        if (v0 & 16384 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 8131365268884726200, 64);
        };
        if (v0 & 32768 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 3584323654723342297, 64);
        };
        if (v0 & 65536 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 696457651847595233, 64);
        };
        if (v0 & 131072 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 26294789957452057, 64);
        };
        if (v0 & 262144 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 37481735321082, 64);
        };
        v2
    }

    fun get_sqrt_price_at_positive_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::as_u32(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::abs(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::mate_to_lib(arg0)));
        let v1 = if (v0 & 1 != 0) {
            79232123823359799118286999567
        } else {
            79228162514264337593543950336
        };
        let v2 = v1;
        if (v0 & 2 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v1, 79236085330515764027303304731, 96);
        };
        if (v0 & 4 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 79244008939048815603706035061, 96);
        };
        if (v0 & 8 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 79259858533276714757314932305, 96);
        };
        if (v0 & 16 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 79291567232598584799939703904, 96);
        };
        if (v0 & 32 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 79355022692464371645785046466, 96);
        };
        if (v0 & 64 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 79482085999252804386437311141, 96);
        };
        if (v0 & 128 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 79736823300114093921829183326, 96);
        };
        if (v0 & 256 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 80248749790819932309965073892, 96);
        };
        if (v0 & 512 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 81282483887344747381513967011, 96);
        };
        if (v0 & 1024 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 83390072131320151908154831281, 96);
        };
        if (v0 & 2048 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 87770609709833776024991924138, 96);
        };
        if (v0 & 4096 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 97234110755111693312479820773, 96);
        };
        if (v0 & 8192 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 119332217159966728226237229890, 96);
        };
        if (v0 & 16384 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 179736315981702064433883588727, 96);
        };
        if (v0 & 32768 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 407748233172238350107850275304, 96);
        };
        if (v0 & 65536 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 2098478828474011932436660412517, 96);
        };
        if (v0 & 131072 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 55581415166113811149459800483533, 96);
        };
        if (v0 & 262144 != 0) {
            v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::mul_shr(v2, 38992368544603139932233054999993551, 96);
        };
        v2 >> 32
    }

    public fun get_sqrt_price_at_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        assert!(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::gte(arg0, min_tick()) && 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::lte(arg0, max_tick()), 1);
        if (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::is_neg(arg0)) {
            get_sqrt_price_at_negative_tick(arg0)
        } else {
            get_sqrt_price_at_positive_tick(arg0)
        }
    }

    public fun is_valid_index(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : bool {
        if (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::gte(arg0, min_tick())) {
            if (0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::lte(arg0, max_tick())) {
                0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::mod(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::mate_to_lib(arg0), 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::from(arg1)) == 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::from(0)
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun max_tick() : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::lib_to_mate(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::from(443636))
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun min_tick() : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32_utils::lib_to_mate(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::i32::neg_from(443636))
    }

    public fun sqrt_price_to_price(arg0: u128, arg1: u8, arg2: u8) : 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128 {
        let v0 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(arg0);
        let v1 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(18446744073709551616);
        let v2 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v0, &v1);
        let v3 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v2, &v2);
        if (arg1 > arg2) {
            let v5 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::pow(10, ((arg1 - arg2) as u64)));
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::mul(&v3, &v5)
        } else if (arg1 < arg2) {
            let v6 = 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::from_u128(0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::u128_utils::pow(10, ((arg2 - arg1) as u64)));
            0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::div(&v3, &v6)
        } else {
            v3
        }
    }

    public fun tick_bound() : u32 {
        443636
    }

    public fun tick_index_to_price(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u8, arg2: u8) : 0x43decceb4b8b58128d69e2f9278fd0595b15e56fb3ae61c0c8b562cc9fc89f10::uq128_128::UQ128_128 {
        sqrt_price_to_price(get_sqrt_price_at_tick(arg0), arg1, arg2)
    }

    public fun transfer_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg2), arg1);
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

