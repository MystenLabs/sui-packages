module 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::utils {
    fun get_sqrt_price_at_negative_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::as_u32(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::abs(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::mate_to_lib(arg0)));
        let v1 = if (v0 & 1 != 0) {
            18445821805675392311
        } else {
            18446744073709551616
        };
        let v2 = v1;
        if (v0 & 2 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v1, 18444899583751176498, 64);
        };
        if (v0 & 4 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 18443055278223354162, 64);
        };
        if (v0 & 8 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 18439367220385604838, 64);
        };
        if (v0 & 16 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 18431993317065449817, 64);
        };
        if (v0 & 32 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 18417254355718160513, 64);
        };
        if (v0 & 64 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 18387811781193591352, 64);
        };
        if (v0 & 128 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 18329067761203520168, 64);
        };
        if (v0 & 256 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 18212142134806087854, 64);
        };
        if (v0 & 512 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 17980523815641551639, 64);
        };
        if (v0 & 1024 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 17526086738831147013, 64);
        };
        if (v0 & 2048 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 16651378430235024244, 64);
        };
        if (v0 & 4096 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 15030750278693429944, 64);
        };
        if (v0 & 8192 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 12247334978882834399, 64);
        };
        if (v0 & 16384 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 8131365268884726200, 64);
        };
        if (v0 & 32768 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 3584323654723342297, 64);
        };
        if (v0 & 65536 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 696457651847595233, 64);
        };
        if (v0 & 131072 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 26294789957452057, 64);
        };
        if (v0 & 262144 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 37481735321082, 64);
        };
        v2
    }

    fun get_sqrt_price_at_positive_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::as_u32(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::abs(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::mate_to_lib(arg0)));
        let v1 = if (v0 & 1 != 0) {
            79232123823359799118286999567
        } else {
            79228162514264337593543950336
        };
        let v2 = v1;
        if (v0 & 2 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v1, 79236085330515764027303304731, 96);
        };
        if (v0 & 4 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 79244008939048815603706035061, 96);
        };
        if (v0 & 8 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 79259858533276714757314932305, 96);
        };
        if (v0 & 16 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 79291567232598584799939703904, 96);
        };
        if (v0 & 32 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 79355022692464371645785046466, 96);
        };
        if (v0 & 64 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 79482085999252804386437311141, 96);
        };
        if (v0 & 128 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 79736823300114093921829183326, 96);
        };
        if (v0 & 256 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 80248749790819932309965073892, 96);
        };
        if (v0 & 512 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 81282483887344747381513967011, 96);
        };
        if (v0 & 1024 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 83390072131320151908154831281, 96);
        };
        if (v0 & 2048 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 87770609709833776024991924138, 96);
        };
        if (v0 & 4096 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 97234110755111693312479820773, 96);
        };
        if (v0 & 8192 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 119332217159966728226237229890, 96);
        };
        if (v0 & 16384 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 179736315981702064433883588727, 96);
        };
        if (v0 & 32768 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 407748233172238350107850275304, 96);
        };
        if (v0 & 65536 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 2098478828474011932436660412517, 96);
        };
        if (v0 & 131072 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 55581415166113811149459800483533, 96);
        };
        if (v0 & 262144 != 0) {
            v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::mul_shr(v2, 38992368544603139932233054999993551, 96);
        };
        v2 >> 32
    }

    public fun get_sqrt_price_at_tick(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        assert!(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::gte(arg0, min_tick()) && 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::lte(arg0, max_tick()), 1);
        if (0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::is_neg(arg0)) {
            get_sqrt_price_at_negative_tick(arg0)
        } else {
            get_sqrt_price_at_positive_tick(arg0)
        }
    }

    public fun is_valid_index(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u32) : bool {
        if (0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::gte(arg0, min_tick())) {
            if (0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::lte(arg0, max_tick())) {
                0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::mod(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::mate_to_lib(arg0), 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::from(arg1)) == 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::from(0)
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
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::lib_to_mate(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::from(443636))
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun min_tick() : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32_utils::lib_to_mate(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::i32::neg_from(443636))
    }

    public fun sqrt_price_to_price(arg0: u128, arg1: u8, arg2: u8) : 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128 {
        let v0 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(arg0);
        let v1 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(18446744073709551616);
        let v2 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v0, &v1);
        let v3 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v2, &v2);
        if (arg1 > arg2) {
            let v5 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::pow(10, ((arg1 - arg2) as u64)));
            0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::mul(&v3, &v5)
        } else if (arg1 < arg2) {
            let v6 = 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::from_u128(0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::u128_utils::pow(10, ((arg2 - arg1) as u64)));
            0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::div(&v3, &v6)
        } else {
            v3
        }
    }

    public fun tick_bound() : u32 {
        443636
    }

    public fun tick_index_to_price(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u8, arg2: u8) : 0xa72a01a1a3464c185f38d72d18abc689f2939447126b8b773e9fd7d00361ceed::uq128_128::UQ128_128 {
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

