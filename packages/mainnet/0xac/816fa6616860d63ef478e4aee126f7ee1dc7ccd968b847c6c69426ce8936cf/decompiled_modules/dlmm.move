module 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::dlmm {
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

    public fun check<T0, T1>(arg0: &mut 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::Probe, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock) {
        if (!0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::checking(arg0)) {
            return
        };
        let v0 = 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_amount(arg0);
        let (v1, v2) = quote<T0, T1>(arg1, arg2, v0, arg4);
        let v3 = if (v1 == v0) {
            v1
        } else {
            0
        };
        0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::check_step(arg0, v3, v2, arg3);
    }

    public fun fold<T0, T1>(arg0: &mut 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::Probe, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::disable_swap(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::permissions<T0, T1>(arg1))) {
            0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::fold_closed(arg0);
            return
        };
        let (v0, v1) = quote<T0, T1>(arg1, arg2, arg3, arg4);
        if (v0 == 0 || v1 == 0) {
            0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::fold_closed(arg0);
            return
        };
        0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
    }

    public fun fold_live<T0, T1>(arg0: &mut 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::Probe, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = 0xac816fa6616860d63ef478e4aee126f7ee1dc7ccd968b847c6c69426ce8936cf::probe::reference_input(arg0);
        fold<T0, T1>(arg0, arg1, arg2, v0, arg3);
    }

    fun group_bounds<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>) : (u64, u64, bool) {
        let v0 = 0x2::bcs::new(0x2::bcs::to_bytes<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::BinManager>(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_manager<T0, T1>(arg0)));
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u16(&mut v0);
        0x2::bcs::peel_address(&mut v0);
        let v1 = 0;
        let v2 = true;
        let v3 = 0;
        while (v3 < 0x2::bcs::peel_vec_length(&mut v0)) {
            if (v3 == 0) {
                v1 = 0x2::bcs::peel_u64(&mut v0);
                v2 = 0x2::bcs::peel_bool(&mut v0);
            };
            v3 = v3 + 1;
        };
        let v4 = v2 || 0x2::bcs::peel_bool(&mut v0);
        (v1, 0x2::bcs::peel_u64(&mut v0), v4)
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
        let (v12, v13, v14) = group_bounds<T0, T1>(arg0);
        if (v14) {
            return (0, 0)
        };
        let v15 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(v3);
        let v16 = v15 / 16;
        let v17 = v16;
        if (arg1 && v16 > v13) {
            v17 = v13;
        };
        if (!arg1 && v17 < v12) {
            v17 = v12;
        };
        loop {
            let v18 = if (v11 > 0) {
                if (v17 >= v12) {
                    v17 <= v13
                } else {
                    false
                }
            } else {
                false
            };
            if (v18) {
                if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_group<T0, T1>(arg0, v17)) {
                    let v19 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::group_bins(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_group_ref<T0, T1>(arg0, v17)));
                    let v20 = 0;
                    while (v11 > 0 && v20 < 16) {
                        let v21 = if (arg1) {
                            15 - v20
                        } else {
                            v20
                        };
                        v20 = v20 + 1;
                        let v22 = v17 * 16 + v21;
                        if (arg1 && v22 > v15 || !arg1 && v22 < v15) {
                            continue
                        };
                        let v23 = 0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin>(v19, v21);
                        let v24 = if (arg1) {
                            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v23)
                        } else {
                            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v23)
                        };
                        let v25 = (v24 as u256);
                        if (v25 == 0) {
                            continue
                        };
                        let v26 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(v23) as u256);
                        if (v26 == 0) {
                            continue
                        };
                        let v27 = v4 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v5, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v23))) as u64) * 10000;
                        let v28 = v27;
                        if (v27 > v8) {
                            v28 = v8;
                        };
                        let v29 = (v28 as u256) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(&v1) as u256);
                        let v30 = if (v7 == 0) {
                            0
                        } else {
                            (v7 * v29 * v29 + 99999999999) / 100000000000
                        };
                        let v31 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0) as u256) + v30;
                        let v32 = v31;
                        if (v31 > 100000000) {
                            v32 = 100000000;
                        };
                        let v33 = amount_out(v11 - (v11 * v32 + 1000000000 - 1) / 1000000000, v26, arg1);
                        let v34;
                        let (v35, v36) = if (v33 <= v25) {
                            let v35 = v11;
                            (v35, v33)
                        } else {
                            let v37 = amount_in(v25, v26, arg1);
                            v34 = v37 + (v37 * v32 + 1000000000 - v32 - 1) / (1000000000 - v32);
                            (v34, v25)
                        };
                        v11 = v11 - v35;
                        v10 = v10 + v34;
                        v9 = v9 + v36;
                    };
                };
                if (arg1 && v17 == v12 || !arg1 && v17 == v13) {
                    break
                };
                let v38 = if (arg1) {
                    v17 - 1
                } else {
                    v17 + 1
                };
                v17 = v38;
            } else {
                break
            };
        };
        ((v10 as u64), (v9 as u64))
    }

    // decompiled from Move bytecode v7
}

