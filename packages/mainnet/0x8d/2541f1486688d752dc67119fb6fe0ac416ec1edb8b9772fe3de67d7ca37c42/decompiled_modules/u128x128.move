module 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::u128x128 {
    public fun pow(arg0: u256, arg1: 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::I32) : u256 {
        let v0 = false;
        let v1 = v0;
        if (arg0 == 0) {
            return 0
        };
        if (0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::eq(arg1, 0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::zero())) {
            return 1 << 128
        };
        let v2 = (0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::abs_u32(arg1) as u128);
        if (0x4e706dcaab822e4b2e753b855ffcaa0916989868fd5429b58e47591dfb3be::i32::is_neg(arg1)) {
            v1 = !v0;
        };
        let v3 = 0;
        if (v2 < 1048576) {
            let v4 = 1 << 128;
            v3 = v4;
            let v5 = arg0;
            if (arg0 > (1 << 128) - 1) {
                v5 = max_u() / arg0;
                v1 = !v1;
            };
            if (v2 & 1 != 0) {
                v3 = v4 * v5 >> 128;
            };
            let v6 = v5 * v5 >> 128;
            if (v2 & 2 != 0) {
                let v7 = v3 * v6;
                v3 = v7 >> 128;
            };
            let v8 = v6 * v6 >> 128;
            if (v2 & 4 != 0) {
                let v9 = v3 * v8;
                v3 = v9 >> 128;
            };
            let v10 = v8 * v8 >> 128;
            if (v2 & 8 != 0) {
                let v11 = v3 * v10;
                v3 = v11 >> 128;
            };
            let v12 = v10 * v10 >> 128;
            if (v2 & 16 != 0) {
                let v13 = v3 * v12;
                v3 = v13 >> 128;
            };
            let v14 = v12 * v12 >> 128;
            if (v2 & 32 != 0) {
                let v15 = v3 * v14;
                v3 = v15 >> 128;
            };
            let v16 = v14 * v14 >> 128;
            if (v2 & 64 != 0) {
                let v17 = v3 * v16;
                v3 = v17 >> 128;
            };
            let v18 = v16 * v16 >> 128;
            if (v2 & 128 != 0) {
                let v19 = v3 * v18;
                v3 = v19 >> 128;
            };
            let v20 = v18 * v18 >> 128;
            if (v2 & 256 != 0) {
                let v21 = v3 * v20;
                v3 = v21 >> 128;
            };
            let v22 = v20 * v20 >> 128;
            if (v2 & 512 != 0) {
                let v23 = v3 * v22;
                v3 = v23 >> 128;
            };
            let v24 = v22 * v22 >> 128;
            if (v2 & 1024 != 0) {
                let v25 = v3 * v24;
                v3 = v25 >> 128;
            };
            let v26 = v24 * v24 >> 128;
            if (v2 & 2048 != 0) {
                let v27 = v3 * v26;
                v3 = v27 >> 128;
            };
            let v28 = v26 * v26 >> 128;
            if (v2 & 4096 != 0) {
                let v29 = v3 * v28;
                v3 = v29 >> 128;
            };
            let v30 = v28 * v28 >> 128;
            if (v2 & 8192 != 0) {
                let v31 = v3 * v30;
                v3 = v31 >> 128;
            };
            let v32 = v30 * v30 >> 128;
            if (v2 & 16384 != 0) {
                let v33 = v3 * v32;
                v3 = v33 >> 128;
            };
            let v34 = v32 * v32 >> 128;
            if (v2 & 32768 != 0) {
                let v35 = v3 * v34;
                v3 = v35 >> 128;
            };
            let v36 = v34 * v34 >> 128;
            if (v2 & 65536 != 0) {
                let v37 = v3 * v36;
                v3 = v37 >> 128;
            };
            let v38 = v36 * v36 >> 128;
            if (v2 & 131072 != 0) {
                let v39 = v3 * v38;
                v3 = v39 >> 128;
            };
            let v40 = v38 * v38 >> 128;
            if (v2 & 262144 != 0) {
                let v41 = v3 * v40;
                v3 = v41 >> 128;
            };
            if (v2 & 524288 != 0) {
                let v42 = v3 * (v40 * v40 >> 128);
                v3 = v42 >> 128;
            };
        };
        if (v3 == 0) {
            abort 9223372668215427080
        };
        if (v1) {
            max_u() / v3
        } else {
            v3
        }
    }

    public fun from_u128x128(arg0: u256) : (u128, u128) {
        (((arg0 >> 128) as u128), ((arg0 & 340282366920938463463374607431768211455) as u128))
    }

    public fun log2(arg0: u256) : (u256, bool) {
        if (arg0 == 1) {
            return (to_u128x128(128, 0), false)
        };
        if (arg0 == 0) {
            abort 9223372200063860742
        };
        let v0 = arg0 >> 1;
        arg0 = v0;
        let v1 = if (v0 >= 170141183460469231731687303715884105728) {
            true
        } else {
            arg0 = 28948022309329048855892746252171976963317496166410141009864396001978282409984 / v0;
            false
        };
        let v2 = 0x8d2541f1486688d752dc67119fb6fe0ac416ec1edb8b9772fe3de67d7ca37c42::bit_math::most_significant_bit(((arg0 >> 127) as u256));
        let v3 = (v2 as u256) << 127;
        let v4 = arg0 >> v2;
        let v5 = v4;
        if (v4 != 170141183460469231731687303715884105728) {
            let v6 = 1 << 127 - 1;
            while (v6 > 0) {
                v5 = v5 * v5 >> 127;
                if (v5 >= 1 << 127 + 1) {
                    v3 = v3 + v6;
                    v5 = v5 >> 1;
                };
                v6 = v6 >> 1;
            };
        };
        (v3 << 1, v1)
    }

    fun max_u() : u256 {
        let v0 = (128 as u16) + (128 as u16);
        assert!(v0 <= 256, 9223372346092421119);
        if (v0 == 256) {
            115792089237316195423570985008687907853269984665640564039457584007913129639935
        } else {
            (1 << 128 + 128) - 1
        }
    }

    public fun to_u128x128(arg0: u128, arg1: u8) : u256 {
        ((arg0 as u256) << 128) / 0x1::u256::pow(10, arg1)
    }

    // decompiled from Move bytecode v6
}

