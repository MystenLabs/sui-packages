module 0x1b2a8b23bb8f8b397fd5dc550c115026096978f60a8ae3b5b1bb40271b74ec98::bid_ask {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg4 == 0 && arg5 == 0) {
            abort 13906835248085467141
        };
        0x1b2a8b23bb8f8b397fd5dc550c115026096978f60a8ae3b5b1bb40271b74ec98::utils::validate_active_id_slippage<T0, T1>(arg0, arg8, arg9);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2), 13906835273855139843);
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2);
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0));
        let (v5, v6) = if (!v3) {
            let (v7, v8) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts_in_active_bin<T0, T1>(arg0);
            calculate_active_weights(v7, v8, (v4 as u256))
        } else {
            (0, 0)
        };
        let v9 = v6;
        let v10 = v5;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v1) && arg5 == 0) {
            v10 = ((200 as u256) << 128) / (v4 as u256);
            v9 = 0;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v2) && arg4 == 0) {
            v9 = (200 as u256) << 64;
            v10 = 0;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v1) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v2)) {
            if (arg4 == 0) {
                v9 = (200 as u256) << 64;
                v10 = 0;
            };
            if (arg5 == 0) {
                v10 = ((200 as u256) << 128) / (v4 as u256);
                v9 = 0;
            };
        };
        let (v11, v12) = if (v3) {
            (0, 0)
        } else {
            (v10, v9)
        };
        let v13 = v12;
        let v14 = v11;
        let v15 = 2000 - 200;
        let v16 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v1)) {
            v15 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) as u16)
        } else {
            0
        };
        let v17 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v2, v0)) {
            v15 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v0)) as u16)
        } else {
            0
        };
        let v18 = 0x1::vector::empty<u16>();
        let v19 = 0x1::vector::empty<u256>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2)) {
            let v20 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) as u16) * v16
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0)) as u16) * v17
            } else {
                200
            };
            0x1::vector::push_back<u16>(&mut v18, v20);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                v13 = v13 + ((v20 as u256) << 64);
                0x1::vector::push_back<u256>(&mut v19, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                let v21 = ((v20 as u256) << 128) / (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0)) as u256);
                0x1::vector::push_back<u256>(&mut v19, v21);
                v14 = v14 + v21;
            } else {
                0x1::vector::push_back<u256>(&mut v19, 0);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v22 = if (v13 == 0) {
            0
        } else {
            ((arg5 as u256) << 128) / v13
        };
        let v23 = if (v14 == 0) {
            0
        } else {
            ((arg4 as u256) << 128) / v14
        };
        let v24 = v23 * v10 >> 128;
        let v25 = v22 * v9 >> 128;
        let v26 = v24 > 0 || v25 > 0;
        let v27 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::new_add_liquidity_cert<T0, T1>(arg0, arg1, v26, arg10, arg11, arg12, arg13);
        let (v28, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
        let v30 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_group_if_absent<T0, T1>(arg0, v28, arg11);
        let v31 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64);
        let v32 = 0;
        let v33 = 0;
        let v34 = 0;
        while (v32 < v31) {
            let (v35, v36) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
            if (v35 != v28) {
                v30 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_group_if_absent<T0, T1>(arg0, v35, arg11);
            };
            let (v37, v38) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                (0, ((v22 * (*0x1::vector::borrow<u16>(&v18, v32) as u256) >> 64) as u64))
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                (((v23 * *0x1::vector::borrow<u256>(&v19, v32) >> 128) as u64), 0)
            } else {
                ((v24 as u64), (v25 as u64))
            };
            let v39 = v38;
            let v40 = v37;
            let v41 = v33 + v37;
            v33 = v41;
            let v42 = v34 + v38;
            v34 = v42;
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1, v0)) {
                if (arg5 > v42) {
                    v39 = v38 + arg5 - v42;
                };
            };
            if (v32 == v31 - 1) {
                if (arg4 > v41) {
                    v40 = v37 + arg4 - v41;
                };
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2)) {
                    v39 = v39 + arg5 - v42;
                };
            };
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_liquidity_on_bin<T0, T1>(arg1, &mut v27, v30, v36, v40, v39, arg11);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v32 = v32 + 1;
        };
        let (v43, v44) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts<T0, T1>(&v27);
        assert!(0x2::coin::value<T0>(arg2) >= v43, 13906835978229645313);
        assert!(0x2::coin::value<T1>(arg3) >= v44, 13906835982524612609);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_add_liquidity<T0, T1>(arg0, arg1, v27, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v43, arg13)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v44, arg13)), arg11);
    }

    fun calculate_active_weights(arg0: u64, arg1: u64, arg2: u256) : (u256, u256) {
        if (arg0 == 0 && arg1 == 0) {
            (((200 as u256) << 128) / arg2 * 2, ((200 as u256) << 64) / 2)
        } else {
            let v2 = if (arg0 == 0) {
                0
            } else {
                ((200 as u256) << 128) / (arg2 + ((arg1 as u256) << 64) / (arg0 as u256))
            };
            let v3 = if (arg1 == 0) {
                0
            } else {
                ((200 as u256) << 128) / (18446744073709551616 + arg2 * (arg0 as u256) / (arg1 as u256))
            };
            (v2, v3)
        }
    }

    public fun open_position<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u32, arg6: u16, arg7: u32, arg8: u32, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position {
        if (arg3 == 0 && arg4 == 0) {
            abort 13906834359027236869
        };
        0x1b2a8b23bb8f8b397fd5dc550c115026096978f60a8ae3b5b1bb40271b74ec98::utils::validate_active_id_slippage<T0, T1>(arg0, arg7, arg8);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg6 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2);
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0));
        let (v5, v6) = if (!v3) {
            let (v7, v8) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts_in_active_bin<T0, T1>(arg0);
            calculate_active_weights(v7, v8, (v4 as u256))
        } else {
            (0, 0)
        };
        let v9 = v6;
        let v10 = v5;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v1) && arg4 == 0) {
            v10 = ((200 as u256) << 128) / (v4 as u256);
            v9 = 0;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v2) && arg3 == 0) {
            v9 = (200 as u256) << 64;
            v10 = 0;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v1) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v2)) {
            if (arg3 == 0) {
                v9 = (200 as u256) << 64;
                v10 = 0;
            };
            if (arg4 == 0) {
                v10 = ((200 as u256) << 128) / (v4 as u256);
                v9 = 0;
            };
        };
        let (v11, v12) = if (v3) {
            (0, 0)
        } else {
            (v10, v9)
        };
        let v13 = v12;
        let v14 = v11;
        let v15 = 2000 - 200;
        let v16 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v1)) {
            v15 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) as u16)
        } else {
            0
        };
        let v17 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v2, v0)) {
            v15 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v0)) as u16)
        } else {
            0
        };
        let v18 = 0x1::vector::empty<u16>();
        let v19 = 0x1::vector::empty<u256>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2)) {
            let v20 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) as u16) * v16
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0)) as u16) * v17
            } else {
                200
            };
            0x1::vector::push_back<u16>(&mut v18, v20);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                v13 = v13 + ((v20 as u256) << 64);
                0x1::vector::push_back<u256>(&mut v19, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                let v21 = ((v20 as u256) << 128) / (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0)) as u256);
                0x1::vector::push_back<u256>(&mut v19, v21);
                v14 = v14 + v21;
            } else {
                0x1::vector::push_back<u256>(&mut v19, 0);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v22 = if (v13 == 0) {
            0
        } else {
            ((arg4 as u256) << 128) / v13
        };
        let v23 = if (v14 == 0) {
            0
        } else {
            ((arg3 as u256) << 128) / v14
        };
        let v24 = v23 * v10 >> 128;
        let v25 = v22 * v9 >> 128;
        let v26 = v24 > 0 || v25 > 0;
        let (v27, v28) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::new_open_position_cert<T0, T1>(arg0, arg5, arg6, v26, arg9, arg10, arg11, arg12);
        let v29 = v28;
        let v30 = v27;
        let (v31, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
        let v33 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_group_if_absent<T0, T1>(arg0, v31, arg10);
        let v34 = (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64);
        let v35 = 0;
        let v36 = 0;
        let v37 = 0;
        while (v35 < v34) {
            let (v38, v39) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
            if (v38 != v31) {
                v33 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_group_if_absent<T0, T1>(arg0, v38, arg10);
            };
            let (v40, v41) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                (0, ((v22 * (*0x1::vector::borrow<u16>(&v18, v35) as u256) >> 64) as u64))
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                (((v23 * *0x1::vector::borrow<u256>(&v19, v35) >> 128) as u64), 0)
            } else {
                ((v24 as u64), (v25 as u64))
            };
            let v42 = v41;
            let v43 = v40;
            let v44 = v36 + v40;
            v36 = v44;
            let v45 = v37 + v41;
            v37 = v45;
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v1, v0)) {
                if (arg4 > v45) {
                    v42 = v41 + arg4 - v45;
                };
            };
            if (v35 == v34 - 1) {
                if (arg3 > v44) {
                    v43 = v40 + arg3 - v44;
                };
                if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2)) {
                    v42 = v42 + arg4 - v45;
                };
            };
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position_on_bin<T0, T1>(&mut v30, &mut v29, v33, v39, v43, v42, arg10);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v35 = v35 + 1;
        };
        let (v46, v47) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v29);
        assert!(0x2::coin::value<T0>(arg1) >= v46, 13906835106351284225);
        assert!(0x2::coin::value<T1>(arg2) >= v47, 13906835110646251521);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg0, &mut v30, v29, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v46, arg12)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v47, arg12)), arg10);
        v30
    }

    // decompiled from Move bytecode v6
}

