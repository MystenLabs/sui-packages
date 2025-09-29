module 0xab76281e46956e18ce7ae3ab876da0b769e21afca90d2dc00b74bb9161720d28::spot {
    public fun add_liquidity<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position, arg2: &mut 0x2::coin::Coin<T0>, arg3: &mut 0x2::coin::Coin<T1>, arg4: u64, arg5: u64, arg6: u32, arg7: u32, arg8: u32, arg9: u32, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg11: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg12: &0x2::clock::Clock, arg13: &mut 0x2::tx_context::TxContext) {
        if (arg4 == 0 && arg5 == 0) {
            abort 13906835110646513669
        };
        0xab76281e46956e18ce7ae3ab876da0b769e21afca90d2dc00b74bb9161720d28::utils::validate_active_id_slippage<T0, T1>(arg0, arg8, arg9);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg6);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg7);
        assert!(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2), 13906835136416186371);
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
            v10 = 340282366920938463463374607431768211456 / (v4 as u256);
            v9 = 0;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v2) && arg4 == 0) {
            v9 = 18446744073709551616;
            v10 = 0;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v1) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v2)) {
            if (arg4 == 0) {
                v9 = 18446744073709551616;
                v10 = 0;
            };
            if (arg5 == 0) {
                v10 = 340282366920938463463374607431768211456 / (v4 as u256);
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
        let v15 = 0x1::vector::empty<u256>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2)) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                v13 = v13 + 18446744073709551616;
                0x1::vector::push_back<u256>(&mut v15, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                let v16 = 340282366920938463463374607431768211456 / (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0)) as u256);
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
            ((arg5 as u256) << 128) / v13
        };
        let v18 = if (v14 == 0) {
            0
        } else {
            ((arg4 as u256) << 128) / v14
        };
        let v19 = v18 * v10 >> 128;
        let v20 = v17 * v9 >> 128;
        let v21 = v19 > 0 || v20 > 0;
        let v22 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::new_add_liquidity_cert<T0, T1>(arg0, arg1, v21, arg10, arg11, arg12, arg13);
        let (v23, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
        let v25 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_group_if_absent<T0, T1>(arg0, v23, arg11);
        let v26 = 0;
        while (v26 < (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v2, v1), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1))) as u64)) {
            let (v27, v28) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
            if (v27 != v23) {
                v25 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_group_if_absent<T0, T1>(arg0, v27, arg11);
            };
            let (v29, v30) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                (0, ((v17 * 1 >> 64) as u64))
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                (((v18 * *0x1::vector::borrow<u256>(&v15, v26) >> 128) as u64), 0)
            } else {
                ((v19 as u64), (v20 as u64))
            };
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_liquidity_on_bin<T0, T1>(arg1, &mut v22, v25, v28, v29, v30, arg11);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v26 = v26 + 1;
        };
        let (v31, v32) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts<T0, T1>(&v22);
        assert!(0x2::coin::value<T0>(arg2) >= v31, 13906835716236640257);
        assert!(0x2::coin::value<T1>(arg3) >= v32, 13906835720531607553);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_add_liquidity<T0, T1>(arg0, arg1, v22, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg2, v31, arg13)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg3, v32, arg13)), arg11);
    }

    fun calculate_active_weights(arg0: u64, arg1: u64, arg2: u256) : (u256, u256) {
        if (arg0 == 0 && arg1 == 0) {
            (340282366920938463463374607431768211456 / arg2 * 2, 9223372036854775808)
        } else {
            let v2 = if (arg0 == 0) {
                0
            } else {
                340282366920938463463374607431768211456 / (arg2 + ((arg1 as u256) << 64) / (arg0 as u256))
            };
            let v3 = if (arg1 == 0) {
                0
            } else {
                340282366920938463463374607431768211456 / (18446744073709551616 + arg2 * (arg0 as u256) / (arg1 as u256))
            };
            (v2, v3)
        }
    }

    public fun open_position<T0, T1>(arg0: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::coin::Coin<T1>, arg3: u64, arg4: u64, arg5: u32, arg6: u16, arg7: u32, arg8: u32, arg9: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg10: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::position::Position {
        if (arg3 == 0 && arg4 == 0) {
            abort 13906834346142334981
        };
        0xab76281e46956e18ce7ae3ab876da0b769e21afca90d2dc00b74bb9161720d28::utils::validate_active_id_slippage<T0, T1>(arg0, arg7, arg8);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(arg5);
        let v2 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from((arg6 as u32))), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        let v3 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v2);
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0);
        let v5 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v0, v4);
        let (v6, v7) = if (!v3) {
            let (v8, v9) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::amounts_in_active_bin<T0, T1>(arg0);
            calculate_active_weights(v8, v9, (v5 as u256))
        } else {
            (0, 0)
        };
        let v10 = v7;
        let v11 = v6;
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v1) && arg4 == 0) {
            v11 = 340282366920938463463374607431768211456 / (v5 as u256);
            v10 = 0;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::eq(v0, v2) && arg3 == 0) {
            v10 = 18446744073709551616;
            v11 = 0;
        };
        if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v0, v1) && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v0, v2)) {
            if (arg3 == 0) {
                v10 = 18446744073709551616;
                v11 = 0;
            };
            if (arg4 == 0) {
                v11 = 340282366920938463463374607431768211456 / (v5 as u256);
                v10 = 0;
            };
        };
        let (v12, v13) = if (v3) {
            (0, 0)
        } else {
            (v11, v10)
        };
        let v14 = v13;
        let v15 = v12;
        let v16 = 0x1::vector::empty<u256>();
        while (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lte(v1, v2)) {
            if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                v14 = v14 + 18446744073709551616;
                0x1::vector::push_back<u256>(&mut v16, 0);
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                let v17 = 340282366920938463463374607431768211456 / (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v1, v4) as u256);
                0x1::vector::push_back<u256>(&mut v16, v17);
                v15 = v15 + v17;
            } else {
                0x1::vector::push_back<u256>(&mut v16, 0);
            };
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
        };
        let v18 = if (v14 == 0) {
            0
        } else {
            ((arg4 as u256) << 128) / v14
        };
        let v19 = if (v15 == 0) {
            0
        } else {
            ((arg3 as u256) << 128) / v15
        };
        let v20 = v19 * v11 >> 128;
        let v21 = v18 * v10 >> 128;
        let v22 = v20 > 0 || v21 > 0;
        let (v23, v24) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::new_open_position_cert<T0, T1>(arg0, arg5, arg6, v22, arg9, arg10, arg11, arg12);
        let v25 = v24;
        let v26 = v23;
        let (v27, _) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
        let v29 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_group_if_absent<T0, T1>(arg0, v27, arg10);
        let v30 = 0;
        while (v30 < (arg6 as u64)) {
            let (v31, v32) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::resolve_bin_position(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v1));
            if (v31 != v27) {
                v29 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::add_group_if_absent<T0, T1>(arg0, v31, arg10);
            };
            let (v33, v34) = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v1, v0)) {
                (0, ((v18 * 1 >> 64) as u64))
            } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v1, v0)) {
                (((v19 * *0x1::vector::borrow<u256>(&v16, v30) >> 128) as u64), 0)
            } else {
                ((v20 as u64), (v21 as u64))
            };
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_position_on_bin<T0, T1>(&mut v26, &mut v25, v29, v32, v33, v34, arg10);
            v1 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v1, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(1));
            v30 = v30 + 1;
        };
        let (v35, v36) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::open_cert_amounts<T0, T1>(&v25);
        assert!(0x2::coin::value<T0>(arg1) >= v35, 13906834968912330753);
        assert!(0x2::coin::value<T1>(arg2) >= v36, 13906834973207298049);
        0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_open_position<T0, T1>(arg0, &mut v26, v25, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(arg1, v35, arg12)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(arg2, v36, arg12)), arg10);
        v26
    }

    // decompiled from Move bytecode v6
}

