module 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::price_math {
    public fun bin_bound() : u32 {
        443636
    }

    public fun get_price_from_id(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: u16) : u128 {
        pow(18446744073709551616 + ((arg1 as u128) << 64) / 10000, arg0)
    }

    public fun max_bin_id() : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(443636)
    }

    public fun min_bin_id() : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::neg_from(443636)
    }

    public fun pow(arg0: u128, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u128 {
        let v0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::is_neg(arg1);
        let v1 = v0;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg1) == 0) {
            return 18446744073709551616
        };
        if (arg0 == 18446744073709551616) {
            return 18446744073709551616
        };
        let v2 = if (v0) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs(arg1))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg1)
        };
        assert!(v2 < 524288, 13906834711214292993);
        let v3 = arg0;
        let v4 = 18446744073709551616;
        let v5 = v4;
        if (arg0 >= v4) {
            v3 = 340282366920938463463374607431768211455 / arg0;
            v1 = !v0;
        };
        if (v2 & 1 > 0) {
            v5 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v4, v3) >> 64) as u128);
        };
        let v6 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v3, v3) >> 64) as u128);
        if (v2 & 2 > 0) {
            let v7 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v6) >> 64;
            v5 = (v7 as u128);
        };
        let v8 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v6, v6) >> 64) as u128);
        if (v2 & 4 > 0) {
            let v9 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v8) >> 64;
            v5 = (v9 as u128);
        };
        let v10 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v8, v8) >> 64) as u128);
        if (v2 & 8 > 0) {
            let v11 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v10) >> 64;
            v5 = (v11 as u128);
        };
        let v12 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v10, v10) >> 64) as u128);
        if (v2 & 16 > 0) {
            let v13 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v12) >> 64;
            v5 = (v13 as u128);
        };
        let v14 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v12, v12) >> 64) as u128);
        if (v2 & 32 > 0) {
            let v15 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v14) >> 64;
            v5 = (v15 as u128);
        };
        let v16 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v14, v14) >> 64) as u128);
        if (v2 & 64 > 0) {
            let v17 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v16) >> 64;
            v5 = (v17 as u128);
        };
        let v18 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v16, v16) >> 64) as u128);
        if (v2 & 128 > 0) {
            let v19 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v18) >> 64;
            v5 = (v19 as u128);
        };
        let v20 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v18, v18) >> 64) as u128);
        if (v2 & 256 > 0) {
            let v21 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v20) >> 64;
            v5 = (v21 as u128);
        };
        let v22 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v20, v20) >> 64) as u128);
        if (v2 & 512 > 0) {
            let v23 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v22) >> 64;
            v5 = (v23 as u128);
        };
        let v24 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v22, v22) >> 64) as u128);
        if (v2 & 1024 > 0) {
            let v25 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v24) >> 64;
            v5 = (v25 as u128);
        };
        let v26 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v24, v24) >> 64) as u128);
        if (v2 & 2048 > 0) {
            let v27 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v26) >> 64;
            v5 = (v27 as u128);
        };
        let v28 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v26, v26) >> 64) as u128);
        if (v2 & 4096 > 0) {
            let v29 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v28) >> 64;
            v5 = (v29 as u128);
        };
        let v30 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v28, v28) >> 64) as u128);
        if (v2 & 8192 > 0) {
            let v31 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v30) >> 64;
            v5 = (v31 as u128);
        };
        let v32 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v30, v30) >> 64) as u128);
        if (v2 & 16384 > 0) {
            let v33 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v32) >> 64;
            v5 = (v33 as u128);
        };
        let v34 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v32, v32) >> 64) as u128);
        if (v2 & 32768 > 0) {
            let v35 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v34) >> 64;
            v5 = (v35 as u128);
        };
        let v36 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v34, v34) >> 64) as u128);
        if (v2 & 65536 > 0) {
            let v37 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v36) >> 64;
            v5 = (v37 as u128);
        };
        let v38 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v36, v36) >> 64) as u128);
        if (v2 & 131072 > 0) {
            let v39 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, v38) >> 64;
            v5 = (v39 as u128);
        };
        if (v2 & 262144 > 0) {
            let v40 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v5, ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::full_math_u128::full_mul(v38, v38) >> 64) as u128)) >> 64;
            v5 = (v40 as u128);
        };
        assert!(v5 != 0, 13906835299624943619);
        if (v1) {
            v5 = 340282366920938463463374607431768211455 / v5;
        };
        v5
    }

    // decompiled from Move bytecode v6
}

