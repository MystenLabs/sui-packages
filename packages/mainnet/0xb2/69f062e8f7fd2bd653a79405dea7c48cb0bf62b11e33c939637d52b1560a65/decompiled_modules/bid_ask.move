module 0xb269f062e8f7fd2bd653a79405dea7c48cb0bf62b11e33c939637d52b1560a65::bid_ask {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>, arg1: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg11: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        0xb269f062e8f7fd2bd653a79405dea7c48cb0bf62b11e33c939637d52b1560a65::utils::validate_active_id_slippage<T0, T1>(arg0, arg8, arg9);
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2), 13906835063401742339);
        let (v3, v4) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::amounts_in_active_bin<T0, T1>(arg0);
        let v5 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::price_math::get_price_from_id(v0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::bin_step<T0, T1>(arg0));
        let (v6, v7) = calculate_active_weights(v3, v4, (v5 as u256));
        let v8 = v7;
        let v9 = v6;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v1) && arg5 == 0) {
            v9 = ((200 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / (v5 as u256);
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v2) && arg4 == 0) {
            v8 = (200 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset();
        };
        let (v10, v11) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2)) {
            (0, 0)
        } else {
            (v9, v8)
        };
        let v12 = v11;
        let v13 = v10;
        let v14 = 2000 - 200;
        let v15 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v1)) {
            v14 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) as u16)
        } else {
            0
        };
        let v16 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v2, v0)) {
            v14 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v0)) as u16)
        } else {
            0
        };
        let v17 = 0x1::vector::empty<u16>();
        let v18 = 0x1::vector::empty<u256>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2)) {
            let v19 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) as u16) * v15
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0)) as u16) * v16
            } else {
                200
            };
            0x1::vector::push_back<u16>(&mut v17, v19);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                v12 = v12 + ((v19 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset());
                0x1::vector::push_back<u256>(&mut v18, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                let v20 = ((v19 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::price_math::get_price_from_id(v1, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::bin_step<T0, T1>(arg0)) as u256);
                0x1::vector::push_back<u256>(&mut v18, v20);
                v13 = v13 + v20;
            } else {
                0x1::vector::push_back<u256>(&mut v18, 0);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v21 = if (v12 == 0) {
            0
        } else {
            ((arg5 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / v12
        };
        let v22 = if (v13 == 0) {
            0
        } else {
            ((arg4 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / v13
        };
        let v23 = v22 * v9 >> 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2;
        let v24 = v21 * v8 >> 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2;
        let v25 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::new_add_liquidity_cert<T0, T1>(arg0, arg1, (v23 as u64), (v24 as u64), arg10, arg11, arg12, arg13);
        let (v26, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v1));
        let v28 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::add_group_if_absent<T0, T1>(arg0, v26, arg11);
        let v29 = 0;
        while (v29 < (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64)) {
            let (v30, v31) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v1));
            if (v30 != v26) {
                v28 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::add_group_if_absent<T0, T1>(arg0, v30, arg11);
            };
            let (v32, v33) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                (0, v21 * (*0x1::vector::borrow<u16>(&v17, v29) as u256) >> 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset())
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                (v22 * *0x1::vector::borrow<u256>(&v18, v29) >> 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2, 0)
            } else {
                (v23, v24)
            };
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::add_liquidity_on_bin<T0, T1>(arg1, &mut v25, v28, v31, (v32 as u64), (v33 as u64), arg11);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v29 = v29 + 1;
        };
        let (v34, v35) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::amounts<T0, T1>(&v25);
        assert!(0x2::coin::value<T0>(arg2) >= v34, 13906835613157425153);
        assert!(0x2::coin::value<T1>(arg3) >= v35, 13906835617452392449);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::repay_add_liquidity<T0, T1>(arg0, arg1, v25, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v34, arg13)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v35, arg13)), arg11);
    }

    fun calculate_active_weights(arg0: u64, arg1: u64, arg2: u256) : (u256, u256) {
        if (arg0 == 0 && arg1 == 0) {
            (((200 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / arg2 * 2, ((200 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset()) / 2)
        } else {
            let v2 = if (arg0 == 0) {
                0
            } else {
                ((200 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / (arg2 + ((arg1 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset()) / (arg0 as u256))
            };
            let v3 = if (arg1 == 0) {
                0
            } else {
                ((200 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / ((1 << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset()) + arg2 * (arg0 as u256) / (arg1 as u256))
            };
            (v2, v3)
        }
    }

    public fun open_position<T0, T1>(arg0: &mut 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u32, arg6: u16, arg7: u32, arg8: u32, arg9: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::config::GlobalConfig, arg10: &0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::position::Position {
        0xb269f062e8f7fd2bd653a79405dea7c48cb0bf62b11e33c939637d52b1560a65::utils::validate_active_id_slippage<T0, T1>(arg0, arg7, arg8);
        let v0 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg6 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let (v3, v4) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::amounts_in_active_bin<T0, T1>(arg0);
        let v5 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::price_math::get_price_from_id(v0, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::bin_step<T0, T1>(arg0));
        let (v6, v7) = calculate_active_weights(v3, v4, (v5 as u256));
        let v8 = v7;
        let v9 = v6;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v1) && arg4 == 0) {
            v9 = ((200 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / (v5 as u256);
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v2) && arg3 == 0) {
            v8 = (200 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset();
        };
        let (v10, v11) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2)) {
            (0, 0)
        } else {
            (v9, v8)
        };
        let v12 = v11;
        let v13 = v10;
        let v14 = 2000 - 200;
        let v15 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v1)) {
            v14 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) as u16)
        } else {
            0
        };
        let v16 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v2, v0)) {
            v14 / (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v0)) as u16)
        } else {
            0
        };
        let v17 = 0x1::vector::empty<u16>();
        let v18 = 0x1::vector::empty<u256>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2)) {
            let v19 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v0, v1)) as u16) * v15
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                200 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v1, v0)) as u16) * v16
            } else {
                200
            };
            0x1::vector::push_back<u16>(&mut v17, v19);
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                v12 = v12 + ((v19 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset());
                0x1::vector::push_back<u256>(&mut v18, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                let v20 = ((v19 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / (0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::price_math::get_price_from_id(v1, 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::bin_step<T0, T1>(arg0)) as u256);
                0x1::vector::push_back<u256>(&mut v18, v20);
                v13 = v13 + v20;
            } else {
                0x1::vector::push_back<u256>(&mut v18, 0);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v21 = if (v12 == 0) {
            0
        } else {
            ((arg4 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / v12
        };
        let v22 = if (v13 == 0) {
            0
        } else {
            ((arg3 as u256) << 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2) / v13
        };
        let v23 = v22 * v9 >> 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2;
        let v24 = v21 * v8 >> 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2;
        let (v25, v26) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::new_open_position_cert<T0, T1>(arg0, arg5, arg6, (v23 as u64), (v24 as u64), arg9, arg10, arg11, arg12);
        let v27 = v26;
        let v28 = v25;
        let (v29, _) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v1));
        let v31 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::add_group_if_absent<T0, T1>(arg0, v29, arg10);
        let v32 = 0;
        while (v32 < (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64)) {
            let (v33, v34) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::resolve_bin_position(0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::bin::bin_score(v1));
            if (v33 != v29) {
                v31 = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::add_group_if_absent<T0, T1>(arg0, v33, arg10);
            };
            let (v35, v36) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                (0, v21 * (*0x1::vector::borrow<u16>(&v17, v32) as u256) >> 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset())
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                (v22 * *0x1::vector::borrow<u256>(&v18, v32) >> 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::constants::scale_offset() * 2, 0)
            } else {
                (v23, v24)
            };
            0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::open_position_on_bin<T0, T1>(&mut v28, &mut v27, v31, v34, (v35 as u64), (v36 as u64), arg10);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v32 = v32 + 1;
        };
        let (v37, v38) = 0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::open_cert_amounts<T0, T1>(&v27);
        assert!(0x2::coin::value<T0>(arg1) >= v37, 13906834908782788609);
        assert!(0x2::coin::value<T1>(arg2) >= v38, 13906834913077755905);
        0x8eb878ff59ecd9326697dc80f9df55ccfb050a711bb712981b1dc509f393cbdf::pool::repay_open_position<T0, T1>(arg0, &mut v28, v27, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v37, arg12)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v38, arg12)), arg10);
        v28
    }

    // decompiled from Move bytecode v6
}

