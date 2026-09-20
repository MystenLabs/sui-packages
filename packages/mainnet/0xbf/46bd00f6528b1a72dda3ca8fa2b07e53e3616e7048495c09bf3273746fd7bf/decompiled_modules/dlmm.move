module 0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::dlmm {
    fun amount_in(arg0: u256, arg1: u256, arg2: bool) : u256 {
        if (arg2) {
            (arg0 * 18446744073709551616 + arg1 - 1) / arg1
        } else {
            (arg0 * arg1 + 18446744073709551616 - 1) / 18446744073709551616
        }
    }

    fun amount_out(arg0: u256, arg1: u256, arg2: bool) : u256 {
        if (arg2) {
            arg0 * arg1 / 18446744073709551616
        } else {
            arg0 * 18446744073709551616 / arg1
        }
    }

    public fun check<T0, T1>(arg0: &mut 0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::Probe, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock) {
        if (!0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::checking(arg0)) {
            return
        };
        let v0 = 0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::check_amount(arg0);
        let (v1, v2) = quote<T0, T1>(arg1, arg2, v0, arg4);
        let v3 = if (v1 == v0) {
            v1
        } else {
            0
        };
        0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::check_step(arg0, v3, v2, arg3);
    }

    public fun fold<T0, T1>(arg0: &mut 0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::Probe, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::disable_swap(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::permissions<T0, T1>(arg1))) {
            0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::fold_closed(arg0);
            return
        };
        let (v0, v1) = quote<T0, T1>(arg1, arg2, arg3, arg4);
        if (v0 == 0 || v1 == 0) {
            0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::fold_closed(arg0);
            return
        };
        0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
    }

    public fun fold_live<T0, T1>(arg0: &mut 0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::Probe, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = 0xbf46bd00f6528b1a72dda3ca8fa2b07e53e3616e7048495c09bf3273746fd7bf::probe::reference_input(arg0);
        fold<T0, T1>(arg0, arg1, arg2, v0, arg3);
    }

    public fun quote<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : (u64, u64) {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::v_parameters<T0, T1>(arg0);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::bin_step_config(v0);
        let v2 = 0x2::clock::timestamp_ms(arg3) / 1000 - 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::last_update_timestamp(v0);
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let (v4, v5) = if (v2 >= (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::filter_period(&v1) as u64)) {
            let v6 = if (v2 < (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::decay_period(&v1) as u64)) {
                (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_accumulator(v0) as u64) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::reduction_factor(&v1) as u64) / 10000
            } else {
                0
            };
            (v6, v3)
        } else {
            ((0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_reference(v0) as u64), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::index_reference(v0))
        };
        let v7 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::variable_fee_control(&v1) as u256);
        let v8 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::max_volatility_accumulator(&v1) as u64);
        let v9 = 0;
        let v10 = 0;
        let v11 = (arg2 as u256);
        let v12 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::fetch_bins<T0, T1>(arg0, 0x1::option::none<u32>(), 18446744073709551615);
        let v13 = 0x1::vector::length<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>(&v12);
        let v14 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v3);
        let v15 = 0;
        while (v11 > 0 && v15 < v13) {
            let v16 = if (arg1) {
                v13 - v15 - 1
            } else {
                v15
            };
            v15 = v15 + 1;
            let v17 = 0x2::bcs::new(0x2::bcs::to_bytes<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>(0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinInfo>(&v12, v16)));
            let v18 = 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(0x2::bcs::peel_u32(&mut v17));
            let v19 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v18);
            if (arg1 && v19 > v14 || !arg1 && v19 < v14) {
                continue
            };
            let v20 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::effective_bin_price<T0, T1>(arg0, v18) as u256);
            let v21 = if (arg1) {
                0x2::bcs::peel_u64(&mut v17)
            } else {
                0x2::bcs::peel_u64(&mut v17)
            };
            let v22 = (v21 as u256);
            if (v22 == 0 || v20 == 0) {
                continue
            };
            let v23 = v4 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v5, v18)) as u64) * 10000;
            let v24 = v23;
            if (v23 > v8) {
                v24 = v8;
            };
            let v25 = (v24 as u256) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(&v1) as u256);
            let v26 = if (v7 == 0) {
                0
            } else {
                (v7 * v25 * v25 + 99999999999) / 100000000000
            };
            let v27 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0) as u256) + v26;
            let v28 = v27;
            if (v27 > 100000000) {
                v28 = 100000000;
            };
            let v29 = amount_out(v11 - (v11 * v28 + 1000000000 - 1) / 1000000000, v20, arg1);
            let v30;
            let (v31, v32) = if (v29 <= v22) {
                let v31 = v11;
                (v31, v29)
            } else {
                let v33 = amount_in(v22, v20, arg1);
                v30 = v33 + (v33 * v28 + 1000000000 - v28 - 1) / (1000000000 - v28);
                (v30, v22)
            };
            v11 = v11 - v31;
            v10 = v10 + v30;
            v9 = v9 + v32;
        };
        ((v10 as u64), (v9 as u64))
    }

    // decompiled from Move bytecode v7
}

