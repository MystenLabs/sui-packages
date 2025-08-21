module 0x22a98a80becb3da91682676a04bbdc9047a1efa97293bd9133d9989bba3b59f6::bid_ask {
    public fun ask_side_amounts(arg0: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg3: u16, arg4: u64) : (vector<u32>, vector<u64>, vector<u64>) {
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg2, arg0), 13906834401976844292);
        let v0 = 0x1::vector::empty<u32>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u64>();
        let v3 = 0x1::vector::empty<u256>();
        let v4 = 0;
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg0, arg1)) {
            let v5 = ((0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u256) << 64 * 2) / (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::price_math::get_price_from_id(arg0, arg3) as u256);
            v4 = v4 + v5;
            0x1::vector::push_back<u256>(&mut v3, v5);
            0x1::vector::push_back<u32>(&mut v0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0));
            arg0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        assert!(v4 > 0, 13906834474991419398);
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
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg2, arg1), 13906834273127825412);
        let v0 = 0x1::vector::empty<u64>();
        let v1 = 0x1::vector::empty<u64>();
        let v2 = 0x1::vector::empty<u32>();
        let v3 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64);
        let v4 = arg3;
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg0, arg1)) {
            let v5 = arg3 * (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64) / v3 * (v3 + 1) / 2;
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
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg2, arg0) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg2, arg1), 13906834595250372612);
        let v0 = (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::price_math::get_price_from_id(arg2, arg3) as u256);
        let (v1, v2) = if (arg4 == 0 && arg5 == 0) {
            (((200 as u256) << 64 * 2) / v0 * 2, ((200 as u256) << 64) / 2)
        } else {
            let v3 = if (arg4 == 0) {
                0
            } else {
                ((200 as u256) << 64 * 2) / (v0 + ((arg5 as u256) << 64) / (arg4 as u256))
            };
            let v4 = if (arg5 == 0) {
                0
            } else {
                ((200 as u256) << 64 * 2) / ((1 << 64) + v0 * (arg4 as u256) / (arg5 as u256))
            };
            (v3, v4)
        };
        let v5 = 2000 - 200;
        let v6 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg2, arg0)) {
            v5 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg2, arg0)) as u16)
        } else {
            0
        };
        let v7 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg1, arg2)) {
            v5 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg2)) as u16)
        } else {
            0
        };
        let v8 = v1;
        let v9 = v2;
        let v10 = 0x1::vector::empty<u256>();
        let v11 = 0x1::vector::empty<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>();
        let v12 = 0x1::vector::empty<u64>();
        let v13 = 0x1::vector::empty<u64>();
        let v14 = 0x1::vector::empty<u16>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(arg0, arg1)) {
            0x1::vector::push_back<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&mut v11, arg0);
            let v15 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg2)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg2, arg0)) as u16) * v6
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg0, arg2)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0, arg2)) as u16) * v7
            } else {
                200
            };
            0x1::vector::push_back<u16>(&mut v14, v15);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(arg0, arg2)) {
                v9 = v9 + ((v15 as u256) << 64);
                0x1::vector::push_back<u256>(&mut v10, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(arg0, arg2)) {
                let v16 = ((v15 as u256) << 64 * 2) / (0xef456093a22d3ae10dea819add19e9026d9dd7735db719214c40ce172035f98f::price_math::get_price_from_id(arg0, arg3) as u256);
                0x1::vector::push_back<u256>(&mut v10, v16);
                v8 = v8 + v16;
            } else {
                0x1::vector::push_back<u256>(&mut v10, 0);
            };
            arg0 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(arg0, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v17 = if (v9 == 0) {
            0
        } else {
            ((arg7 as u256) << 64 * 2) / (v9 as u256)
        };
        let v18 = if (v8 == 0) {
            0
        } else {
            ((arg6 as u256) << 64 * 2) / (v8 as u256)
        };
        let v19 = arg6;
        let v20 = arg7;
        let v21 = 0;
        let v22 = 0;
        let v23 = 0x1::vector::empty<u32>();
        while (v21 < (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64)) {
            let v24 = *0x1::vector::borrow<0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32>(&v11, v21);
            0x1::vector::push_back<u32>(&mut v23, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(v24));
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v24, arg2)) {
                let v25 = v17 * (*0x1::vector::borrow<u16>(&v14, v21) as u256) >> 64;
                v20 = v20 - (v25 as u64);
                0x1::vector::push_back<u64>(&mut v13, (v25 as u64));
                0x1::vector::push_back<u64>(&mut v12, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v24, arg2)) {
                let v26 = v18 * *0x1::vector::borrow<u256>(&v10, v21) >> 64 * 2;
                v19 = v19 - (v26 as u64);
                0x1::vector::push_back<u64>(&mut v12, (v26 as u64));
                0x1::vector::push_back<u64>(&mut v13, 0);
            } else {
                let v27 = v18 * v1 >> 64 * 2;
                let v28 = v17 * v2 >> 64 * 2;
                v20 = v20 - (v28 as u64);
                v19 = v19 - (v27 as u64);
                0x1::vector::push_back<u64>(&mut v12, (v27 as u64));
                0x1::vector::push_back<u64>(&mut v13, (v28 as u64));
            };
            v21 = v21 + 1;
        };
        let v29 = 0x1::vector::borrow_mut<u64>(&mut v12, v22);
        *v29 = *v29 + v19;
        let v30 = 0x1::vector::borrow_mut<u64>(&mut v13, v22);
        *v30 = *v30 + v20;
        (v23, v12, v13)
    }

    // decompiled from Move bytecode v6
}

