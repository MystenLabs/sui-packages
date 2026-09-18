module 0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::dlmm {
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

    public fun fold<T0, T1>(arg0: &mut 0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::probe::Probe, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::disable_swap(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::permissions<T0, T1>(arg1))) {
            0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::probe::fold_closed(arg0);
            return
        };
        let (v0, v1) = quote<T0, T1>(arg1, arg2, arg3, arg4);
        if (v0 == 0 || v1 == 0) {
            0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::probe::fold_closed(arg0);
            return
        };
        0x15cb31dbfcc5e2f184183e876cde00b9fed0679a9249ae79eb5c60802f735f5a::probe::fold_to(arg0, (v1 as u256), 0, (v0 as u256), (v0 as u256));
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
        let v12 = 0;
        while (v11 > 0 && v12 < 16) {
            let v13 = if (arg1) {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v12))
            } else {
                0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::add(v3, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(v12))
            };
            v12 = v12 + 1;
            if (!0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_bin<T0, T1>(arg0, v13)) {
                continue
            };
            let v14 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_bin<T0, T1>(arg0, v13);
            let v15 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(v14) as u256);
            let v16 = if (arg1) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v14)
            } else {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v14)
            };
            let v17 = (v16 as u256);
            if (v17 == 0 || v15 == 0) {
                continue
            };
            let v18 = v4 + (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(v5, v13)) as u64) * 10000;
            let v19 = v18;
            if (v18 > v8) {
                v19 = v8;
            };
            let v20 = (v19 as u256) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(&v1) as u256);
            let v21 = if (v7 == 0) {
                0
            } else {
                (v7 * v20 * v20 + 99999999999) / 100000000000
            };
            let v22 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0) as u256) + v21;
            let v23 = v22;
            if (v22 > 100000000) {
                v23 = 100000000;
            };
            let v24 = amount_out(v11 - (v11 * v23 + 1000000000 - 1) / 1000000000, v15, arg1);
            let v25;
            let (v26, v27) = if (v24 <= v17) {
                let v26 = v11;
                (v26, v24)
            } else {
                let v28 = amount_in(v17, v15, arg1);
                v25 = v28 + (v28 * v23 + 1000000000 - v23 - 1) / (1000000000 - v23);
                (v25, v17)
            };
            v11 = v11 - v26;
            v10 = v10 + v25;
            v9 = v9 + v27;
        };
        ((v10 as u64), (v9 as u64))
    }

    // decompiled from Move bytecode v7
}

