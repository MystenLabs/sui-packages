module 0x4f0f32980d037d99a1965e3a73d9b1d3b2845e61c0b7cb2d2fd4fc822a02929d::spot {
    public fun ask_side_amounts(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u16, arg4: u64) : (vector<u32>, vector<u64>, vector<u64>) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg2, arg0), 13906834397681745922);
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u256>();
        let v4 = 0;
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg0, arg1)) {
            let v5 = (1 << 64 * 2) / (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::price_math::get_price_from_id(arg0, arg3) as u256);
            v4 = v4 + v5;
            0x1::vector::push_back<u256>(&mut v3, v5);
            0x1::vector::push_back<u32>(&mut v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0));
            arg0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        assert!(v4 > 0, 13906834466401353732);
        let v6 = 0;
        let v7 = arg4;
        while (v6 < (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64)) {
            0x1::vector::push_back<u64>(&mut v2, 0);
            let v8 = (arg4 as u256) * *0x1::vector::borrow<u256>(&v3, v6) / v4;
            v7 = v7 - (v8 as u64);
            0x1::vector::push_back<u64>(&mut v1, (v8 as u64));
            v6 = v6 + 1;
        };
        let v9 = 0x1::vector::borrow_mut<u64>(&mut v1, 0);
        *v9 = *v9 + v7;
        (v0, v1, v2)
    }

    public fun bid_side_amounts(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u64) : (vector<u32>, vector<u64>, vector<u64>) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg2, arg1), 13906834277422661634);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u32>();
        let v3 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64);
        let v4 = arg3;
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg0, arg1)) {
            let v5 = arg3 / v3;
            v4 = v4 - v5;
            0x1::vector::push_back<u64>(&mut v1, v5);
            0x1::vector::push_back<u64>(&mut v0, 0);
            0x1::vector::push_back<u32>(&mut v2, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0));
            arg0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v6 = 0x1::vector::borrow_mut<u64>(&mut v1, v3 - 1);
        *v6 = *v6 + v4;
        (v2, v0, v1)
    }

    public fun both_side_amounts(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u16, arg4: u64, arg5: u64, arg6: u64, arg7: u64) : (vector<u32>, vector<u64>, vector<u64>) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg2, arg0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg2, arg1), 13906834586660306946);
        let v0 = (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::price_math::get_price_from_id(arg2, arg3) as u256);
        let v1 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64);
        assert!(v1 > 0, 13906834599545470982);
        let (v2, v3) = if (arg4 == 0 && arg5 == 0) {
            ((1 << 64 * 2) / v0 * 2, (1 << 64) / 2)
        } else {
            let v4 = if (arg4 == 0) {
                0
            } else {
                (1 << 64 * 2) / (v0 + ((arg5 as u256) << 64) / (arg4 as u256))
            };
            let v5 = if (arg5 == 0) {
                0
            } else {
                (1 << 64 * 2) / ((1 << 64) + v0 * (arg4 as u256) / (arg5 as u256))
            };
            (v4, v5)
        };
        let v6 = v2;
        let v7 = v3;
        let v8 = 0x1::vector::empty<u256>();
        let v9 = 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>();
        let v10 = 0x1::vector::empty<u64>();
        let v11 = 0x1::vector::empty<u64>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg0, arg1)) {
            0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v9, arg0);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg2)) {
                v7 = v7 + (1 << 64);
                0x1::vector::push_back<u256>(&mut v8, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg0, arg2)) {
                let v12 = (1 << 64 * 2) / (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::price_math::get_price_from_id(arg0, arg3) as u256);
                0x1::vector::push_back<u256>(&mut v8, v12);
                v6 = v6 + v12;
            } else {
                0x1::vector::push_back<u256>(&mut v8, 0);
            };
            arg0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v13 = if (v7 == 0) {
            0
        } else {
            ((arg7 as u256) << 64 * 2) / (v7 as u256)
        };
        let v14 = if (v6 == 0) {
            0
        } else {
            ((arg6 as u256) << 64 * 2) / (v6 as u256)
        };
        let v15 = arg6;
        let v16 = arg7;
        let v17 = 0;
        let v18 = 0;
        let v19 = 0x1::vector::empty<u32>();
        while (v17 < v1) {
            let v20 = *0x1::vector::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&v9, v17);
            0x1::vector::push_back<u32>(&mut v19, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v20));
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v20, arg2)) {
                let v21 = v13 * 1 >> 64;
                v16 = v16 - (v21 as u64);
                0x1::vector::push_back<u64>(&mut v11, (v21 as u64));
                0x1::vector::push_back<u64>(&mut v10, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v20, arg2)) {
                let v22 = v14 * *0x1::vector::borrow<u256>(&v8, v17) >> 64 * 2;
                v15 = v15 - (v22 as u64);
                0x1::vector::push_back<u64>(&mut v10, (v22 as u64));
                0x1::vector::push_back<u64>(&mut v11, 0);
            } else {
                let v23 = v14 * v2 >> 64 * 2;
                let v24 = v13 * v3 >> 64 * 2;
                v16 = v16 - (v24 as u64);
                v15 = v15 - (v23 as u64);
                0x1::vector::push_back<u64>(&mut v10, (v23 as u64));
                0x1::vector::push_back<u64>(&mut v11, (v24 as u64));
            };
            v17 = v17 + 1;
        };
        let v25 = 0x1::vector::borrow_mut<u64>(&mut v10, v18);
        *v25 = *v25 + v15;
        let v26 = 0x1::vector::borrow_mut<u64>(&mut v11, v18);
        *v26 = *v26 + v16;
        (v19, v10, v11)
    }

    // decompiled from Move bytecode v6
}

