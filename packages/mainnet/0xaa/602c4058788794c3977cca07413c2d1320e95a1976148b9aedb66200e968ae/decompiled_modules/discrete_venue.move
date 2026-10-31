module 0xaa602c4058788794c3977cca07413c2d1320e95a1976148b9aedb66200e968ae::discrete_venue {
    struct Witness has drop {
        dummy_field: bool,
    }

    fun dynamic_fee(arg0: u64, arg1: u64, arg2: u32, arg3: u32, arg4: u16, arg5: u32) : u64 {
        let v0 = (0x1::u64::min(arg1 + (arg2 as u64) * 10000, (arg3 as u64)) as u128) * (arg4 as u128);
        (0x1::u128::min((arg0 as u128) + ((arg5 as u128) * v0 * v0 + 99999999999) / 100000000000, 100000000) as u64)
    }

    public fun quote_cetusdlmm<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>, arg3: bool, arg4: u64, arg5: bool, arg6: &0x2::clock::Clock) {
        let v0 = 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>>(arg2);
        let v1 = if (arg3) {
            let v2 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T2, Witness>(arg0, arg1, &v2, v0, arg4, arg5)
        } else {
            let v3 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_amount_for<T0, T1, T3, Witness>(arg0, arg1, &v3, v0, arg4, arg5)
        };
        let (v4, v5) = quote_state<T2, T3>(arg2, arg3, v1, arg6);
        if (arg3) {
            let v6 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T2, T3, Witness>(arg0, arg1, &v6, 13, v0, true, v1, v4, v5);
        } else {
            let v7 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_record<T0, T1, T3, T2, Witness>(arg0, arg1, &v7, 13, v0, false, v1, v4, v5);
        };
    }

    public fun quote_state<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, bool) {
        if (arg2 == 0) {
            return (0, false)
        };
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::fetch_bins<T0, T1>(arg0, 0x1::option::none<u32>(), 4096 + 1);
        if (0x1::vector::length<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>(&v0) > 4096) {
            return (0, false)
        };
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::v_parameters<T0, T1>(arg0);
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::bin_step_config(v2);
        let v4 = 0x2::bcs::new(0x1::bcs::to_bytes<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::VariableParameters>(v2));
        let v5 = (0x2::bcs::peel_u32(&mut v4) as u64);
        let v6 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v4));
        let v7 = 0x2::bcs::peel_u64(&mut v4);
        let v8 = 0x2::clock::timestamp_ms(arg3) / 1000;
        if (v8 < v7) {
            return (0, false)
        };
        let v9 = v8 - v7;
        if (v9 >= (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::filter_period(&v3) as u64)) {
            v6 = v1;
            let v10 = if (v9 < (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::decay_period(&v3) as u64)) {
                (0x2::bcs::peel_u32(&mut v4) as u64) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::reduction_factor(&v3) as u64) / 10000
            } else {
                0
            };
            v5 = v10;
        };
        let v11 = arg2;
        let v12 = 0;
        let v13 = 0;
        while (v13 < 0x1::vector::length<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>(&v0) && v11 > 0) {
            let v14 = if (arg1) {
                0x1::vector::length<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>(&v0) - v13 - 1
            } else {
                v13
            };
            v13 = v13 + 1;
            let v15 = 0x2::bcs::new(0x1::bcs::to_bytes<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>(0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>(&v0, v14)));
            let v16 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v15));
            let v17 = 0x2::bcs::peel_u128(&mut v15);
            if (arg1 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gt(v16, v1) || !arg1 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::lt(v16, v1)) {
                continue
            };
            let v18 = if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(v16, v6)) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v16, v6))
            } else {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v6, v16))
            };
            let v19 = dynamic_fee(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0), v5, v18, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::max_volatility_accumulator(&v3), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(&v3), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::variable_fee_control(&v3));
            let v20 = if (arg1) {
                0x2::bcs::peel_u64(&mut v15)
            } else {
                0x2::bcs::peel_u64(&mut v15)
            };
            let v21 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_out(v11 - 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_inclusive(v11, v19), v17, arg1);
            if (v21 <= v20) {
                v12 = v12 + v21;
                v11 = 0;
                continue
            };
            let v22 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_amount_in(v20, v17, arg1);
            let v23 = v11 - v22;
            v11 = v23 - 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::dlmm_math::calculate_fee_exclusive(v22, v19);
            v12 = v12 + v20;
        };
        let (v24, v25) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::reserves<T0, T1>(arg0);
        let v26 = if (v11 == 0) {
            let v27 = if (arg1) {
                v25
            } else {
                v24
            };
            v12 <= v27
        } else {
            false
        };
        (v12, v26)
    }

    public fun swap_cetusdlmm<T0, T1, T2, T3>(arg0: &mut 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::Route<T0, T1>, arg1: &0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::executor::Executor, arg2: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::GlobalConfig, arg3: &mut 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>, arg4: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::versioned::Versioned, arg5: bool, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        if (arg5) {
            let v0 = Witness{dummy_field: false};
            let v1 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T2, T3, Witness>(arg0, arg1, &v0, 13, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>>(arg3), true, arg7);
            if (0x1::option::is_none<0x2::coin::Coin<T2>>(&v1)) {
                0x1::option::destroy_none<0x2::coin::Coin<T2>>(v1);
                return
            };
            let v2 = 0x1::option::destroy_some<0x2::coin::Coin<T2>>(v1);
            let v3 = 0x2::coin::value<T2>(&v2);
            let (v4, v5, v6) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T2, T3>(arg3, true, true, v3, arg2, arg4, arg6, arg7);
            let v7 = v6;
            0x2::balance::destroy_zero<T2>(v4);
            assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T2, T3>(&v7) == v3, 0);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T2, T3>(arg3, 0x2::coin::into_balance<T2>(v2), 0x2::balance::zero<T3>(), v7, arg4);
            let v8 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T3, Witness>(arg0, arg1, &v8, 0x2::coin::from_balance<T3>(v5, arg7));
        } else {
            let v9 = Witness{dummy_field: false};
            let v10 = 0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_take_input<T0, T1, T3, T2, Witness>(arg0, arg1, &v9, 13, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T2, T3>>(arg3), false, arg7);
            if (0x1::option::is_none<0x2::coin::Coin<T3>>(&v10)) {
                0x1::option::destroy_none<0x2::coin::Coin<T3>>(v10);
                return
            };
            let v11 = 0x1::option::destroy_some<0x2::coin::Coin<T3>>(v10);
            let v12 = 0x2::coin::value<T3>(&v11);
            let (v13, v14, v15) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::flash_swap<T2, T3>(arg3, false, true, v12, arg2, arg4, arg6, arg7);
            let v16 = v15;
            0x2::balance::destroy_zero<T3>(v14);
            assert!(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::pay_amount<T2, T3>(&v16) == v12, 0);
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::repay_flash_swap<T2, T3>(arg3, 0x2::balance::zero<T2>(), 0x2::coin::into_balance<T3>(v11), v16, arg4);
            let v17 = Witness{dummy_field: false};
            0x4264cb75e042ab4fd5ee0a6ebee028a51ec36646d2f1cfdebd4ee632ee20a589::aggregator::external_put_output<T0, T1, T2, Witness>(arg0, arg1, &v17, 0x2::coin::from_balance<T2>(v13, arg7));
        };
    }

    // decompiled from Move bytecode v7
}

