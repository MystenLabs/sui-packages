module 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::tick_math {
    fun as_u8(arg0: bool) : u8 {
        if (arg0) {
            1
        } else {
            0
        }
    }

    fun get_sqrt_price_at_negative_tick(arg0: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32) : u128 {
        let v0 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::as_u32(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::abs(arg0));
        let v1 = if (v0 & 1 != 0) {
            18445821805675392311
        } else {
            18446744073709551616
        };
        let v2 = v1;
        if (v0 & 2 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v1, 18444899583751176498, 64);
        };
        if (v0 & 4 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 18443055278223354162, 64);
        };
        if (v0 & 8 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 18439367220385604838, 64);
        };
        if (v0 & 16 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 18431993317065449817, 64);
        };
        if (v0 & 32 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 18417254355718160513, 64);
        };
        if (v0 & 64 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 18387811781193591352, 64);
        };
        if (v0 & 128 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 18329067761203520168, 64);
        };
        if (v0 & 256 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 18212142134806087854, 64);
        };
        if (v0 & 512 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 17980523815641551639, 64);
        };
        if (v0 & 1024 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 17526086738831147013, 64);
        };
        if (v0 & 2048 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 16651378430235024244, 64);
        };
        if (v0 & 4096 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 15030750278693429944, 64);
        };
        if (v0 & 8192 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 12247334978882834399, 64);
        };
        if (v0 & 16384 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 8131365268884726200, 64);
        };
        if (v0 & 32768 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 3584323654723342297, 64);
        };
        if (v0 & 65536 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 696457651847595233, 64);
        };
        if (v0 & 131072 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 26294789957452057, 64);
        };
        if (v0 & 262144 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 37481735321082, 64);
        };
        v2
    }

    fun get_sqrt_price_at_positive_tick(arg0: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32) : u128 {
        let v0 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::as_u32(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::abs(arg0));
        let v1 = if (v0 & 1 != 0) {
            79232123823359799118286999567
        } else {
            79228162514264337593543950336
        };
        let v2 = v1;
        if (v0 & 2 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v1, 79236085330515764027303304731, 96);
        };
        if (v0 & 4 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 79244008939048815603706035061, 96);
        };
        if (v0 & 8 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 79259858533276714757314932305, 96);
        };
        if (v0 & 16 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 79291567232598584799939703904, 96);
        };
        if (v0 & 32 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 79355022692464371645785046466, 96);
        };
        if (v0 & 64 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 79482085999252804386437311141, 96);
        };
        if (v0 & 128 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 79736823300114093921829183326, 96);
        };
        if (v0 & 256 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 80248749790819932309965073892, 96);
        };
        if (v0 & 512 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 81282483887344747381513967011, 96);
        };
        if (v0 & 1024 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 83390072131320151908154831281, 96);
        };
        if (v0 & 2048 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 87770609709833776024991924138, 96);
        };
        if (v0 & 4096 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 97234110755111693312479820773, 96);
        };
        if (v0 & 8192 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 119332217159966728226237229890, 96);
        };
        if (v0 & 16384 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 179736315981702064433883588727, 96);
        };
        if (v0 & 32768 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 407748233172238350107850275304, 96);
        };
        if (v0 & 65536 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 2098478828474011932436660412517, 96);
        };
        if (v0 & 131072 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 55581415166113811149459800483533, 96);
        };
        if (v0 & 262144 != 0) {
            v2 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::full_math_u128::mul_shr(v2, 38992368544603139932233054999993551, 96);
        };
        v2 >> 32
    }

    public fun get_sqrt_price_at_tick(arg0: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32) : u128 {
        assert!(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::gte(arg0, min_tick()) && 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::lte(arg0, max_tick()), 1);
        if (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::is_neg(arg0)) {
            get_sqrt_price_at_negative_tick(arg0)
        } else {
            get_sqrt_price_at_positive_tick(arg0)
        }
    }

    public fun get_tick_at_sqrt_price(arg0: u128) : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32 {
        assert!(arg0 >= 4295048016 && arg0 <= 79226673515401279992447579055, 2);
        let v0 = as_u8(arg0 >= 18446744073709551616) << 6;
        let v1 = arg0 >> v0;
        let v2 = as_u8(v1 >= 4294967296) << 5;
        let v3 = v1 >> v2;
        let v4 = as_u8(v3 >= 65536) << 4;
        let v5 = v3 >> v4;
        let v6 = as_u8(v5 >= 256) << 3;
        let v7 = v5 >> v6;
        let v8 = as_u8(v7 >= 16) << 2;
        let v9 = v7 >> v8;
        let v10 = as_u8(v9 >= 4) << 1;
        let v11 = 0 | v0 | v2 | v4 | v6 | v8 | v10 | as_u8(v9 >> v10 >= 2) << 0;
        let v12 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::shl(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::sub(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::from((v11 as u128)), 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::from(64)), 32);
        let v13 = if (v11 >= 64) {
            arg0 >> v11 - 63
        } else {
            arg0 << 63 - v11
        };
        let v14 = v13;
        let v15 = 31;
        while (v15 >= 18) {
            let v16 = v14 * v14 >> 63;
            let v17 = ((v16 >> 64) as u8);
            v12 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::or(v12, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::shl(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::from((v17 as u128)), v15));
            v14 = v16 >> v17;
            v15 = v15 - 1;
        };
        let v18 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::mul(v12, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::from(59543866431366));
        let v19 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::as_i32(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::shr(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::sub(v18, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::from(184467440737095516)), 64));
        let v20 = 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::as_i32(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::shr(0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::add(v18, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i128::from(15793534762490258745)), 64));
        if (0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::eq(v19, v20)) {
            return v19
        };
        if (get_sqrt_price_at_tick(v20) <= arg0) {
            return v20
        };
        v19
    }

    public fun is_valid_index(arg0: 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32, arg1: u32) : bool {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::gte(arg0, min_tick()) && 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::lte(arg0, max_tick()) && 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::mod(arg0, 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::from(arg1)) == 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::from(0)
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun max_tick() : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32 {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::from(443636)
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun min_tick() : 0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::I32 {
        0xd7022feb4c5adf6cedc93ef70441390274146f19475e9c67caf681dd2231264b::i32::neg_from(443636)
    }

    public fun tick_bound() : u32 {
        443636
    }

    // decompiled from Move bytecode v6
}

