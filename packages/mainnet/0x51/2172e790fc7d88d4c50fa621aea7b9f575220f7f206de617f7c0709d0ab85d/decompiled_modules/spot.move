module 0x512172e790fc7d88d4c50fa621aea7b9f575220f7f206de617f7c0709d0ab85d::spot {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::Pool<T0, T1>, arg1: &mut 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: &0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::config::GlobalConfig, arg11: &0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0x512172e790fc7d88d4c50fa621aea7b9f575220f7f206de617f7c0709d0ab85d::utils::validate_active_id_slippage<T0, T1>(arg0, arg8, arg9);
        let v0 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2), 13906834938847690755);
        let (v3, v4) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::amounts_in_active_bin<T0, T1>(arg0);
        let v5 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::price_math::get_price_from_id(v0, 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::bin_step<T0, T1>(arg0));
        let (v6, v7) = calculate_active_weights(v3, v4, (v5 as u256));
        let v8 = v7;
        let v9 = v6;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v1) && arg5 == 0) {
            v9 = (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / (v5 as u256);
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v2) && arg4 == 0) {
            v8 = 1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset();
        };
        let (v10, v11) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2)) {
            v9 = 0;
            v8 = 0;
            (0, 0)
        } else {
            (v9, v8)
        };
        let v12 = v11;
        let v13 = v10;
        let v14 = 0x1::vector::empty<u256>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2)) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                v12 = v12 + (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset());
                0x1::vector::push_back<u256>(&mut v14, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                let v15 = (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / (0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::price_math::get_price_from_id(v1, 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::bin_step<T0, T1>(arg0)) as u256);
                0x1::vector::push_back<u256>(&mut v14, v15);
                v13 = v13 + v15;
            } else {
                0x1::vector::push_back<u256>(&mut v14, 0);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v16 = if (v12 == 0) {
            0
        } else {
            ((arg5 as u256) << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / v12
        };
        let v17 = if (v13 == 0) {
            0
        } else {
            ((arg4 as u256) << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / v13
        };
        let v18 = v17 * v9 >> 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2;
        let v19 = v16 * v8 >> 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2;
        let v20 = v18 > 0 || v19 > 0;
        let v21 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::new_add_liquidity_cert<T0, T1>(arg0, arg1, v20, arg10, arg11, arg12, arg13);
        let (v22, _) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::bin::resolve_bin_position(0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::bin::bin_score(v1));
        let v24 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::add_group_if_absent<T0, T1>(arg0, v22, arg11);
        let v25 = 0;
        while (v25 < (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64)) {
            let (v26, v27) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::bin::resolve_bin_position(0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::bin::bin_score(v1));
            if (v26 != v22) {
                v24 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::add_group_if_absent<T0, T1>(arg0, v26, arg11);
            };
            let (v28, v29) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                (0, v16 * 1 >> 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset())
            } else {
                let (v30, v31) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                    (0, v17 * *0x1::vector::borrow<u256>(&v14, v25) >> 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2)
                } else {
                    ((v19 as u256), (v18 as u256))
                };
                (v31, v30)
            };
            0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::add_liquidity_on_bin<T0, T1>(arg1, &mut v21, v24, v27, (v28 as u64), (v29 as u64), arg11);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v25 = v25 + 1;
        };
        let (v32, v33) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::amounts<T0, T1>(&v21);
        assert!(0x2::coin::value<T0>(arg2) >= v32, 13906835372639256577);
        assert!(0x2::coin::value<T1>(arg3) >= v33, 13906835376934223873);
        0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::repay_add_liquidity<T0, T1>(arg0, arg1, v21, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v32, arg13)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v33, arg13)), arg11);
    }

    fun calculate_active_weights(arg0: u64, arg1: u64, arg2: u256) : (u256, u256) {
        if (arg0 == 0 && arg1 == 0) {
            ((1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / arg2 * 2, (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset()) / 2)
        } else {
            let v2 = if (arg0 == 0) {
                0
            } else {
                (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / (arg2 + ((arg1 as u256) << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset()) / (arg0 as u256))
            };
            let v3 = if (arg1 == 0) {
                0
            } else {
                (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / ((1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset()) + arg2 * (arg0 as u256) / (arg1 as u256))
            };
            (v2, v3)
        }
    }

    public fun open_position<T0, T1>(arg0: &mut 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u32, arg6: u16, arg7: u32, arg8: u32, arg9: &0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::config::GlobalConfig, arg10: &0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::position::Position {
        0x512172e790fc7d88d4c50fa621aea7b9f575220f7f206de617f7c0709d0ab85d::utils::validate_active_id_slippage<T0, T1>(arg0, arg7, arg8);
        let v0 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg6 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let v3 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::bin_step<T0, T1>(arg0);
        let (v4, v5) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::amounts_in_active_bin<T0, T1>(arg0);
        let v6 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::price_math::get_price_from_id(v0, v3);
        let (v7, v8) = calculate_active_weights(v4, v5, (v6 as u256));
        let v9 = v8;
        let v10 = v7;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v1) && arg4 == 0) {
            v10 = (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / (v6 as u256);
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v2) && arg3 == 0) {
            v9 = 1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset();
        };
        let (v11, v12) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2)) {
            v10 = 0;
            v9 = 0;
            (0, 0)
        } else {
            (v10, v9)
        };
        let v13 = v12;
        let v14 = v11;
        let v15 = 0x1::vector::empty<u256>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2)) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                v13 = v13 + (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset());
                0x1::vector::push_back<u256>(&mut v15, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                let v16 = (1 << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / (0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::price_math::get_price_from_id(v1, v3) as u256);
                0x1::vector::push_back<u256>(&mut v15, v16);
                v14 = v14 + v16;
            } else {
                0x1::vector::push_back<u256>(&mut v15, 0);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v17 = if (v13 == 0) {
            0
        } else {
            ((arg4 as u256) << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / v13
        };
        let v18 = if (v14 == 0) {
            0
        } else {
            ((arg3 as u256) << 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2) / v14
        };
        let v19 = v18 * v10 >> 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2;
        let v20 = v17 * v9 >> 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2;
        let v21 = v19 > 0 || v20 > 0;
        let (v22, v23) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::new_open_position_cert<T0, T1>(arg0, arg5, arg6, v21, arg9, arg10, arg11, arg12);
        let v24 = v23;
        let v25 = v22;
        let (v26, _) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::bin::resolve_bin_position(0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::bin::bin_score(v1));
        let v28 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::add_group_if_absent<T0, T1>(arg0, v26, arg10);
        let v29 = 0;
        while (v29 < (arg6 as u64)) {
            let (v30, v31) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::bin::resolve_bin_position(0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::bin::bin_score(v1));
            if (v30 != v26) {
                v28 = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::add_group_if_absent<T0, T1>(arg0, v30, arg10);
            };
            let (v32, v33) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                (0, v17 * 1 >> 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset())
            } else {
                let (v34, v35) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                    (0, v18 * *0x1::vector::borrow<u256>(&v15, v29) >> 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::constants::scale_offset() * 2)
                } else {
                    ((v20 as u256), (v19 as u256))
                };
                (v35, v34)
            };
            0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::open_position_on_bin<T0, T1>(&mut v25, &mut v24, v28, v31, (v32 as u64), (v33 as u64), arg10);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v29 = v29 + 1;
        };
        let (v36, v37) = 0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::open_cert_amounts<T0, T1>(&v24);
        assert!(0x2::coin::value<T0>(arg1) >= v36, 13906834784228737025);
        assert!(0x2::coin::value<T1>(arg2) >= v37, 13906834788523704321);
        0x1da09bc124e0bd92f4889c0c0ae0acbb0308051f16d37457011ee778ffcad575::pool::repay_open_position<T0, T1>(arg0, &mut v25, v24, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v36, arg12)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v37, arg12)), arg10);
        v25
    }

    // decompiled from Move bytecode v6
}

