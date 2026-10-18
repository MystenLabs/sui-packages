module 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::vq_c {
    public fun c<T0, T1>(arg0: &mut 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::Ht, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let v0 = 0;
        while (v0 < 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::cn(arg0)) {
            let v1 = 0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::ra(arg0, v0);
            if (v1 > 0) {
                0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::sr(arg0, v0, q<T0, T1>(arg1, arg2, v1, arg3));
            };
            v0 = v0 + 1;
        };
        0xe893880c02b66a60a6fc80762f1acab90eaaac22a4d1bdac6751350fb69886fc::hz::np(arg0, 0x2::object::id<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>>(arg1), arg2);
    }

    fun q<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: &0x2::clock::Clock) : u64 {
        if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::disable_swap(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::permissions<T0, T1>(arg0))) {
            return 0
        };
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::v_parameters<T0, T1>(arg0);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::bin_step_config(v0);
        let v2 = 0x2::clock::timestamp_ms(arg3) / 1000;
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::last_update_timestamp(v0);
        if (v2 < v3) {
            return 0
        };
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0));
        let v5 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::index_reference(v0));
        let v6 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_reference(v0) as u64);
        let v7 = v2 - v3;
        if (v7 >= (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::filter_period(&v1) as u64)) {
            v5 = v4;
            if (v7 < (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::decay_period(&v1) as u64)) {
                let v8 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_accumulator(v0) as u128) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::reduction_factor(&v1) as u128) / 10000;
                if (v8 >= 4294967295) {
                    return 0
                };
                v6 = (v8 as u64);
            } else {
                v6 = 0;
            };
        };
        let v9 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::max_volatility_accumulator(&v1) as u64);
        let v10 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::variable_fee_control(&v1) as u256);
        let v11 = arg2;
        let v12 = 0;
        let v13 = v4;
        let v14 = 0;
        let v15 = 0;
        while (v11 > 0) {
            let v16 = false;
            while (!v16) {
                let v17 = v13 >> 4;
                if (!0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_group<T0, T1>(arg0, v17)) {
                    v14 = v14 + 1;
                    if (v14 > 32) {
                        return 0
                    };
                    if (arg1) {
                        if (v17 == 0) {
                            return 0
                        };
                        v13 = v17 * 16 - 1;
                        continue
                    };
                    let v18 = (v17 + 1) * 16;
                    v13 = v18;
                    if (v18 > 887272) {
                        return 0
                    } else {
                        continue
                    };
                };
                if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_bin<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_id_from_score(v13))) {
                    v16 = true;
                    continue
                };
                if (arg1) {
                    if (v13 == 0) {
                        return 0
                    };
                    v13 = v13 - 1;
                    continue
                };
                if (v13 >= 887272) {
                    return 0
                };
                v13 = v13 + 1;
            };
            v15 = v15 + 1;
            if (v15 > 64) {
                return 0
            };
            let v19 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_bin<T0, T1>(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_id_from_score(v13));
            let v20 = if (v5 >= v13) {
                v5 - v13
            } else {
                v13 - v5
            };
            let v21 = v6 + v20 * 10000;
            let v22 = if (v21 > v9) {
                v9
            } else {
                v21
            };
            let v23 = if (v10 == 0) {
                0
            } else {
                let v24 = (v22 as u256) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(&v1) as u256);
                let v25 = v24 * v24;
                if (v25 > 340282366920938463463374607431768211455) {
                    return 0
                };
                let v26 = v10 * v25;
                if (v26 > 340282366920938463463374607431768211455) {
                    return 0
                };
                (v26 + 99999999999) / 100000000000
            };
            let v27 = ((0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0) as u128) as u256) + v23;
            let v28 = if (v27 > (100000000 as u256)) {
                100000000
            } else {
                (v27 as u128)
            };
            let v29 = (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(v19) as u256);
            if (v29 == 0) {
                return 0
            };
            let v30 = if (arg1) {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v19)
            } else {
                0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v19)
            };
            let v31 = if (arg1) {
                ((v11 as u256) - ((((v11 as u128) * v28 + 1000000000 - 1) / 1000000000) as u256)) * v29 / 18446744073709551616
            } else {
                ((v11 as u256) - ((((v11 as u128) * v28 + 1000000000 - 1) / 1000000000) as u256)) * 18446744073709551616 / v29
            };
            if (v31 >= 18446744073709551615) {
                return 0
            };
            if (v31 <= (v30 as u256)) {
                v12 = v12 + (v31 as u128);
                v11 = 0;
                continue
            };
            if (v30 > 0) {
                let v32 = if (arg1) {
                    ((v30 as u256) * 18446744073709551616 + v29 - 1) / v29
                } else {
                    ((v30 as u256) * v29 + 18446744073709551616 - 1) / 18446744073709551616
                };
                if (v32 >= 18446744073709551615) {
                    return 0
                };
                let v33 = (v32 as u128) + ((v32 as u128) * v28 + 1000000000 - v28 - 1) / (1000000000 - v28);
                if (v33 > (v11 as u128)) {
                    return 0
                };
                v11 = v11 - (v33 as u64);
                v12 = v12 + (v30 as u128);
            };
            if (v11 > 0) {
                if (arg1) {
                    if (v13 == 0) {
                        return 0
                    };
                    v13 = v13 - 1;
                    continue
                };
                if (v13 >= 887272) {
                    return 0
                };
                v13 = v13 + 1;
            };
        };
        if (v12 == 0 || v12 > (18446744073709551615 as u128)) {
            return 0
        };
        let (v34, v35) = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::reserves<T0, T1>(arg0);
        let v36 = if (arg1) {
            v35
        } else {
            v34
        };
        if (v12 > (v36 as u128)) {
            return 0
        };
        (v12 as u64)
    }

    // decompiled from Move bytecode v7
}

