module 0xa7fbf53d1d5c96cab4fbb99c4f00e22b962eb1683a8391dbf72fec98d401dd94::dlmm_adapters {
    struct CetusFeeState has copy, drop {
        volatility_reference: u32,
        index_reference: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        bin_step: u16,
        variable_fee_control: u32,
        max_volatility_accumulator: u32,
        base_fee_rate: u64,
    }

    struct FerraFeeState has copy, drop {
        bin_step: u16,
        base_fee_rate: u64,
        variable_fee_control: u32,
        max_volatility_accumulator: u32,
        volatility_reference: u32,
        index_reference: u32,
    }

    fun amount_in_for_output(arg0: u64, arg1: u128, arg2: bool) : u64 {
        assert!(arg1 > 0, 801);
        let v0 = if (arg2) {
            (arg0 as u256) * (18446744073709551616 as u256)
        } else {
            (arg0 as u256) * (arg1 as u256)
        };
        let v1 = if (arg2) {
            (arg1 as u256)
        } else {
            (18446744073709551616 as u256)
        };
        let v2 = (v0 + v1 - 1) / v1;
        assert!(v2 <= 18446744073709551615, 802);
        (v2 as u64)
    }

    fun append_if_nonincreasing(arg0: &mut vector<u128>, arg1: &mut vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u128) : bool {
        if (arg4 > 0 && (arg3 as u256) * (arg4 as u256) > (arg5 as u256) * (arg2 as u256)) {
            return false
        };
        0x1::vector::push_back<u128>(arg0, arg2);
        0x1::vector::push_back<u128>(arg1, arg3);
        true
    }

    public fun cetus_after_gate<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool) {
        assert!(arg3 > 0 && arg3 <= 512, 800);
        assert!(arg4 > 0 && arg4 <= 512, 800);
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0));
        let v1 = v0 >> 4;
        let v2 = v0 & 15;
        let v3 = 0;
        let v4 = false;
        let v5 = false;
        let v6 = 0;
        let v7 = 0;
        let v8 = vector[];
        let v9 = vector[];
        let v10 = vector[];
        let v11 = vector[];
        let v12 = cetus_fee_state<T0, T1>(arg0, arg1);
        loop {
            let v13 = if (0x1::vector::length<u128>(&v9) < arg3) {
                if (v3 < arg4) {
                    !v5
                } else {
                    false
                }
            } else {
                false
            };
            if (v13) {
                if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_group<T0, T1>(arg0, v1)) {
                    let v14 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::group_bins(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_group_ref<T0, T1>(arg0, v1)));
                    assert!(0x1::vector::length<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin>(v14) == 16, 801);
                    if (arg2) {
                        loop {
                            let (v15, v16, v17, v18) = cetus_bin_endpoint(0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin>(v14, v2), &v12, true);
                            if (v16 > 0) {
                                let v19 = &mut v8;
                                let v20 = &mut v9;
                                if (!append_if_nonincreasing(v19, v20, v15, v16, v6, v7)) {
                                    v5 = true;
                                    break
                                };
                                0x1::vector::push_back<u128>(&mut v10, v17);
                                0x1::vector::push_back<u64>(&mut v11, v18);
                                v6 = v15;
                                v7 = v16;
                            };
                            if (0x1::vector::length<u128>(&v9) >= arg3 || v2 == 0) {
                                break
                            };
                            v2 = v2 - 1;
                        };
                    } else {
                        while (v2 < 16 && 0x1::vector::length<u128>(&v9) < arg3) {
                            let (v21, v22, v23, v24) = cetus_bin_endpoint(0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin>(v14, v2), &v12, false);
                            if (v22 > 0) {
                                let v25 = &mut v8;
                                let v26 = &mut v9;
                                if (!append_if_nonincreasing(v25, v26, v21, v22, v6, v7)) {
                                    v5 = true;
                                    break
                                };
                                0x1::vector::push_back<u128>(&mut v10, v23);
                                0x1::vector::push_back<u64>(&mut v11, v24);
                                v6 = v21;
                                v7 = v22;
                            };
                            v2 = v2 + 1;
                        };
                    };
                };
                v3 = v3 + 1;
                if (0x1::vector::length<u128>(&v9) >= arg3) {
                    break
                };
                if (arg2) {
                    if (v1 == 0) {
                        v4 = true;
                        break
                    };
                    v1 = v1 - 1;
                    v2 = 15;
                    continue
                };
                if (v1 >= 55454) {
                    v4 = true;
                    break
                };
                v1 = v1 + 1;
                v2 = 0;
            } else {
                break
            };
        };
        let v27 = v5 || !v4;
        (v8, v9, v10, v11, v27)
    }

    public fun cetus_after_gate_if<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool) {
        if (!arg5) {
            return (vector[], vector[], vector[], vector[], false)
        };
        cetus_after_gate<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun cetus_bin_endpoint(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin, arg1: &CetusFeeState, arg2: bool) : (u128, u128, u128, u64) {
        let v0 = if (arg2) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(arg0)
        } else {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(arg0)
        };
        if (v0 == 0) {
            return (0, 0, 0, 0)
        };
        let v1 = cetus_fee_for_id(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(arg0));
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(arg0);
        let v3 = amount_in_for_output(v0, v2, arg2);
        let v4 = fee_exclusive(v3, v1, 1000000000);
        assert!(v3 <= 18446744073709551615 - v4, 802);
        (((v3 + v4) as u128), (v0 as u128), v2, v1)
    }

    public fun cetus_current<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: bool) : u128 {
        rate_x64(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0), 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0)), arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0), 1000000000)
    }

    fun cetus_fee_for_id(arg0: &CetusFeeState, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32) : u64 {
        let v0 = signed_distance(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg0.index_reference), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::as_u32(arg1));
        let v1 = if (v0 <= 2147483647) {
            (v0 as u32)
        } else if (0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0.index_reference, arg1)) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg0.index_reference, arg1))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::abs_u32(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(arg1, arg0.index_reference))
        };
        let v2 = (arg0.volatility_reference as u64) + (v1 as u64) * 10000;
        let v3 = if (v2 > (arg0.max_volatility_accumulator as u64)) {
            (arg0.max_volatility_accumulator as u64)
        } else {
            v2
        };
        let v4 = if (arg0.variable_fee_control == 0) {
            0
        } else {
            let v5 = (v3 as u256) * (arg0.bin_step as u256);
            let v6 = ((arg0.variable_fee_control as u256) * v5 * v5 + 99999999999) / 100000000000;
            assert!(v6 <= 18446744073709551615, 802);
            (v6 as u64)
        };
        if (v4 > 100000000 || arg0.base_fee_rate > 100000000 - v4) {
            100000000
        } else {
            arg0.base_fee_rate + v4
        }
    }

    fun cetus_fee_state<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock) : CetusFeeState {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::v_parameters<T0, T1>(arg0);
        let v1 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::bin_step_config(v0);
        let v2 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_reference(v0);
        let v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::index_reference(v0);
        let v4 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::last_update_timestamp(v0);
        let v5 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v5 >= v4, 801);
        let v6 = v5 - v4;
        if (v6 >= (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::filter_period(&v1) as u64)) {
            v3 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
            if (v6 < (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::decay_period(&v1) as u64)) {
                v2 = (((0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::parameters::volatility_accumulator(v0) as u64) * (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::reduction_factor(&v1) as u64) / 10000) as u32);
            } else {
                v2 = 0;
            };
        };
        CetusFeeState{
            volatility_reference       : v2,
            index_reference            : v3,
            bin_step                   : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::bin_step(&v1),
            variable_fee_control       : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::variable_fee_control(&v1),
            max_volatility_accumulator : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::config::max_volatility_accumulator(&v1),
            base_fee_rate              : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg0),
        }
    }

    fun fee_exclusive(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 < arg2, 801);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = ((arg2 - arg1) as u256);
        let v1 = ((arg0 as u256) * (arg1 as u256) + v0 - 1) / v0;
        assert!(v1 <= 18446744073709551615, 802);
        (v1 as u64)
    }

    public fun ferra_after_gate<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool) {
        assert!(arg3 > 0 && arg3 <= 512, 800);
        assert!(arg4 > 0 && arg4 <= 512, 800);
        let (v0, v1) = ferra_fee_state<T0, T1>(arg0, arg1);
        let v2 = v0;
        if (v1) {
            return (vector[], vector[], vector[], vector[], false)
        };
        let (v3, v4) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_range_id<T0, T1>(arg0);
        let v5 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0);
        let v6 = 0;
        let v7 = 0;
        let v8 = false;
        let v9 = false;
        let v10 = vector[];
        let v11 = vector[];
        let v12 = vector[];
        let v13 = vector[];
        while (0x1::vector::length<u128>(&v11) < arg3 && v6 < arg4) {
            if (arg2 && v5 < v4 || !arg2 && v5 > v3) {
                v8 = true;
                break
            };
            let (v14, v15) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, v5);
            let v16 = if (arg2) {
                v15
            } else {
                v14
            };
            if (v16 > 0) {
                let v17 = &mut v2;
                ferra_update_volatility(v17, v5);
                let v18 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg0, v5);
                let v19 = ferra_total_fee(&v2);
                let v20 = &mut v10;
                let v21 = &mut v11;
                if (!append_if_nonincreasing(v20, v21, ferra_bin_input_capacity(v16, v18, arg2, v19), (v16 as u128), 0, v7)) {
                    v9 = true;
                    break
                };
                0x1::vector::push_back<u128>(&mut v12, v18);
                0x1::vector::push_back<u64>(&mut v13, v19);
                v7 = (v16 as u128);
            };
            v6 = v6 + 1;
            if (arg2 && v5 == v4 || v5 == v3) {
                v8 = true;
                break
            };
            if (arg2) {
                if (v5 == 0) {
                    v8 = true;
                    break
                };
                v5 = v5 - 1;
                continue
            };
            if (v5 == 4294967295) {
                v8 = true;
                break
            };
            v5 = v5 + 1;
        };
        let v22 = v9 || !v8;
        (v10, v11, v12, v13, v22)
    }

    public fun ferra_after_gate_if<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool) {
        if (!arg5) {
            return (vector[], vector[], vector[], vector[], false)
        };
        ferra_after_gate<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun ferra_bin_input_capacity(arg0: u64, arg1: u128, arg2: bool, arg3: u64) : u128 {
        let v0 = amount_in_for_output(arg0, arg1, arg2);
        ((v0 + fee_exclusive(v0, arg3, 1000000000)) as u128)
    }

    public fun ferra_current<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: bool) : u128 {
        rate_x64(0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg0, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0)), arg1, 0, 1)
    }

    fun ferra_fee_state<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock) : (FerraFeeState, bool) {
        let v0 = 0x2::bcs::new(0x1::bcs::to_bytes<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg0));
        0x2::bcs::peel_address(&mut v0);
        let v1 = 0x2::bcs::peel_u16(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v2 = 0x2::bcs::peel_u32(&mut v0);
        let v3 = 0x2::bcs::peel_u32(&mut v0);
        let v4 = 0x2::bcs::peel_u64(&mut v0);
        let v5 = 0x2::bcs::peel_u32(&mut v0);
        assert!(v1 == 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin_step<T0, T1>(arg0), 801);
        assert!(v5 == 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0), 801);
        let v6 = 0x2::clock::timestamp_ms(arg1) / 1000;
        assert!(v6 >= v4, 801);
        let v7 = v6 - v4;
        if (v7 >= (0x2::bcs::peel_u16(&mut v0) as u64)) {
            v3 = v5;
            let v8 = if (v7 < (0x2::bcs::peel_u16(&mut v0) as u64)) {
                (((0x2::bcs::peel_u32(&mut v0) as u64) * (0x2::bcs::peel_u16(&mut v0) as u64) / 10000) as u32)
            } else {
                0
            };
            v2 = v8;
        };
        let v9 = (v1 as u64) * (0x2::bcs::peel_u32(&mut v0) as u64);
        assert!(v9 <= 100000000, 801);
        let v10 = FerraFeeState{
            bin_step                   : v1,
            base_fee_rate              : v9,
            variable_fee_control       : 0x2::bcs::peel_u32(&mut v0),
            max_volatility_accumulator : 0x2::bcs::peel_u32(&mut v0),
            volatility_reference       : v2,
            index_reference            : v3,
        };
        (v10, 0x2::bcs::peel_bool(&mut v0))
    }

    fun ferra_total_fee(arg0: &FerraFeeState) : u64 {
        let v0 = (arg0.volatility_reference as u256) * (arg0.bin_step as u256);
        let v1 = (arg0.base_fee_rate as u256) + ((arg0.variable_fee_control as u256) * v0 * v0 + 99) / 100;
        if (v1 > (100000000 as u256)) {
            100000000
        } else {
            (v1 as u64)
        }
    }

    fun ferra_update_volatility(arg0: &mut FerraFeeState, arg1: u32) {
        let v0 = if (arg1 >= arg0.index_reference) {
            arg1 - arg0.index_reference
        } else {
            arg0.index_reference - arg1
        };
        let v1 = (arg0.volatility_reference as u64) + (v0 as u64) * 10;
        let v2 = if (v1 > (arg0.max_volatility_accumulator as u64)) {
            arg0.max_volatility_accumulator
        } else {
            (v1 as u32)
        };
        arg0.volatility_reference = v2;
    }

    fun rate_x64(arg0: u128, arg1: bool, arg2: u64, arg3: u64) : u128 {
        assert!(arg0 > 0, 801);
        assert!(arg3 > arg2, 801);
        let v0 = if (arg1) {
            (arg0 as u256)
        } else {
            (18446744073709551616 as u256) * (18446744073709551616 as u256) / (arg0 as u256)
        };
        let v1 = v0 * ((arg3 - arg2) as u256) / (arg3 as u256);
        assert!(v1 > 0 && v1 <= 340282366920938463463374607431768211455, 802);
        (v1 as u128)
    }

    fun signed_distance(arg0: u32, arg1: u32) : u64 {
        let v0 = ((arg0 ^ 2147483648) as u64);
        let v1 = ((arg1 ^ 2147483648) as u64);
        if (v0 >= v1) {
            v0 - v1
        } else {
            v1 - v0
        }
    }

    // decompiled from Move bytecode v7
}

