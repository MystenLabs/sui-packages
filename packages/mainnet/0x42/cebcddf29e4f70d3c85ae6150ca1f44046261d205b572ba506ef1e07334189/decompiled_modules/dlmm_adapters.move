module 0x42cebcddf29e4f70d3c85ae6150ca1f44046261d205b572ba506ef1e07334189::dlmm_adapters {
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

    struct BinEndpoint has drop {
        input: u128,
        output: u128,
        price: u128,
        fee: u64,
    }

    struct CetusPendingBin has drop {
        id: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32,
        output: u64,
        price: u128,
    }

    struct CetusCursor has drop {
        group: u64,
        offset: u64,
        terminal: bool,
        fee_state: vector<CetusFeeState>,
        pending: vector<CetusPendingBin>,
        previous_price: u128,
        previous_fee: u64,
    }

    struct FerraCursor has drop {
        id: u32,
        low: u32,
        high: u32,
        terminal: bool,
        fee_state: vector<FerraFeeState>,
        previous_price: u128,
        previous_fee: u64,
    }

    fun amount_in_for_output(arg0: u64, arg1: u128, arg2: bool) : u64 {
        assert!(arg1 > 0, 801);
        if (arg0 == 0) {
            return 0
        };
        if (arg2) {
            let v0 = ((arg0 as u128) * 18446744073709551616 - 1) / arg1 + 1;
            assert!(v0 <= 18446744073709551615, 802);
            return (v0 as u64)
        };
        let v1 = ((arg0 as u256) * (arg1 as u256) - 1 >> 64) + 1;
        assert!(v1 <= 18446744073709551615, 802);
        (v1 as u64)
    }

    fun append_if_nonincreasing(arg0: &mut vector<u128>, arg1: &mut vector<u128>, arg2: u128, arg3: u128, arg4: u128, arg5: u64, arg6: u128, arg7: u64, arg8: bool, arg9: u64) : bool {
        if (arg6 > 0) {
            if (arg8 && (arg4 as u256) * ((arg9 - arg5) as u256) > (arg6 as u256) * ((arg9 - arg7) as u256) || ((arg9 - arg5) as u256) * (arg6 as u256) > ((arg9 - arg7) as u256) * (arg4 as u256)) {
                return false
            };
        };
        0x1::vector::push_back<u128>(arg0, arg2);
        0x1::vector::push_back<u128>(arg1, arg3);
        true
    }

    public fun cetus_after_gate<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool) {
        let (v0, v1, v2, v3, v4, v5) = cetus_after_gate_model<T0, T1>(arg0, arg1, arg2, arg3, arg4, true);
        let v6 = v4 || v5;
        (v0, v1, v2, v3, v6)
    }

    public fun cetus_after_gate_if<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool) {
        if (!arg5) {
            return (vector[], vector[], vector[], vector[], false)
        };
        cetus_after_gate<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun cetus_after_gate_model<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool) {
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
                    !v5 || !arg5
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
                                if (!append_if_nonincreasing(v19, v20, v15, v16, v17, v18, v6, v7, arg2, 1000000000)) {
                                    v5 = true;
                                    if (arg5) {
                                        break
                                    };
                                    0x1::vector::push_back<u128>(&mut v8, v15);
                                    0x1::vector::push_back<u128>(&mut v9, v16);
                                };
                                0x1::vector::push_back<u128>(&mut v10, v17);
                                0x1::vector::push_back<u64>(&mut v11, v18);
                                v6 = v17;
                                v7 = v18;
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
                                if (!append_if_nonincreasing(v25, v26, v21, v22, v23, v24, v6, v7, arg2, 1000000000)) {
                                    v5 = true;
                                    if (arg5) {
                                        break
                                    };
                                    0x1::vector::push_back<u128>(&mut v8, v21);
                                    0x1::vector::push_back<u128>(&mut v9, v22);
                                };
                                0x1::vector::push_back<u128>(&mut v10, v23);
                                0x1::vector::push_back<u64>(&mut v11, v24);
                                v6 = v23;
                                v7 = v24;
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
        (v8, v9, v10, v11, !v4, v5)
    }

    public fun cetus_after_gate_model_if<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool) {
        if (!arg5) {
            return (vector[], vector[], vector[], vector[], false, false)
        };
        cetus_after_gate_model<T0, T1>(arg0, arg1, arg2, arg3, arg4, false)
    }

    public fun cetus_begin_if<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (CetusCursor, vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool, u64, u64, bool) {
        let v0 = if (arg5) {
            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::bin_score(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0))
        } else {
            0
        };
        let v1 = if (arg5) {
            let v2 = 0x1::vector::empty<CetusFeeState>();
            0x1::vector::push_back<CetusFeeState>(&mut v2, cetus_fee_state<T0, T1>(arg0, arg1));
            v2
        } else {
            0x1::vector::empty<CetusFeeState>()
        };
        let v3 = CetusCursor{
            group          : v0 >> 4,
            offset         : v0 & 15,
            terminal       : false,
            fee_state      : v1,
            pending        : 0x1::vector::empty<CetusPendingBin>(),
            previous_price : 0,
            previous_fee   : 0,
        };
        let v4 = &mut v3;
        let (v5, v6, v7, v8, v9, v10, v11, v12, v13) = cetus_continue_impl<T0, T1>(arg0, arg1, arg2, v4, arg3, arg4, arg5, false, 0, 0);
        (v3, v5, v6, v7, v8, v9, v10, v11, v12, v13)
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

    public fun cetus_continue_if<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut CetusCursor, arg4: u64, arg5: u64, arg6: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool, u64, u64, bool) {
        cetus_continue_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, false, 0, 0)
    }

    fun cetus_continue_impl<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut CetusCursor, arg4: u64, arg5: u64, arg6: bool, arg7: bool, arg8: u128, arg9: u128) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool, u64, u64, bool) {
        if (!arg6) {
            let v0 = arg3.terminal && 0x1::vector::is_empty<CetusPendingBin>(&arg3.pending);
            return (vector[], vector[], vector[], vector[], false, false, 0, 0, v0)
        };
        let v1 = if (arg7) {
            0x1::u64::min(arg4, 512) * 16
        } else {
            arg4
        };
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = 0;
        let v7 = false;
        let v8 = 0;
        while (0x1::vector::length<u128>(&v3) < v1) {
            if (0x1::vector::is_empty<CetusPendingBin>(&arg3.pending)) {
                if (arg3.terminal || v6 >= arg5) {
                    break
                };
                if (arg9 > 0) {
                    let (v9, v10) = cetus_unread_rate_upper(arg3, arg2);
                    if (v9 && v10 <= arg9) {
                        break
                    };
                };
                if (arg8 > 0 && v8 >= (arg8 as u256)) {
                    break
                };
                if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_group<T0, T1>(arg0, arg3.group)) {
                    let v11 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::group_bins(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_group_ref<T0, T1>(arg0, arg3.group)));
                    assert!(0x1::vector::length<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin>(v11) == 16, 801);
                    let v12 = if (arg2) {
                        0
                    } else {
                        15
                    };
                    let v13 = v12;
                    loop {
                        let v14 = 0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin>(v11, v13);
                        let v15 = if (arg2) {
                            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v14)
                        } else {
                            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v14)
                        };
                        if (v15 > 0) {
                            let v16 = CetusPendingBin{
                                id     : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v14),
                                output : v15,
                                price  : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(v14),
                            };
                            0x1::vector::push_back<CetusPendingBin>(&mut arg3.pending, v16);
                        };
                        if (v13 == arg3.offset) {
                            break
                        };
                        let v17 = if (arg2) {
                            v13 + 1
                        } else {
                            v13 - 1
                        };
                        v13 = v17;
                    };
                };
                v6 = v6 + 1;
                let v18 = arg2 && arg3.group == 0 || arg3.group == 55454;
                arg3.terminal = v18;
                if (!arg3.terminal) {
                    let v19 = if (arg2) {
                        arg3.group - 1
                    } else {
                        arg3.group + 1
                    };
                    arg3.group = v19;
                    let v20 = if (arg2) {
                        15
                    } else {
                        0
                    };
                    arg3.offset = v20;
                };
            };
            if (!0x1::vector::is_empty<CetusPendingBin>(&arg3.pending)) {
                let CetusPendingBin {
                    id     : v21,
                    output : v22,
                    price  : v23,
                } = 0x1::vector::pop_back<CetusPendingBin>(&mut arg3.pending);
                let v24 = cetus_fee_for_id(0x1::vector::borrow<CetusFeeState>(&arg3.fee_state, 0), v21);
                let v25 = amount_in_for_output(v22, v23, arg2);
                let v26 = fee_exclusive(v25, v24, 1000000000);
                assert!(v25 <= 18446744073709551615 - v26, 802);
                let v27 = ((v25 + v26) as u128);
                let v28 = (v22 as u128);
                v8 = v8 + (v27 as u256);
                let v29 = &mut v2;
                let v30 = &mut v3;
                if (!append_if_nonincreasing(v29, v30, v27, v28, v23, v24, arg3.previous_price, arg3.previous_fee, arg2, 1000000000)) {
                    0x1::vector::push_back<u128>(&mut v2, v27);
                    0x1::vector::push_back<u128>(&mut v3, v28);
                    v7 = true;
                };
                0x1::vector::push_back<u128>(&mut v4, v23);
                0x1::vector::push_back<u64>(&mut v5, v24);
                arg3.previous_price = v23;
                arg3.previous_fee = v24;
                continue
            };
            if (arg3.terminal) {
                break
            };
        };
        let v31 = arg3.terminal && 0x1::vector::is_empty<CetusPendingBin>(&arg3.pending);
        let v32 = if (arg7) {
            (0x1::vector::length<u128>(&v3) + 15) / 16
        } else {
            0x1::vector::length<u128>(&v3)
        };
        (v2, v3, v4, v5, !v31, v7, v6, v32, v31)
    }

    public fun cetus_continue_selective_secant_if<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut CetusCursor, arg4: u64, arg5: u64, arg6: bool, arg7: u128, arg8: u128, arg9: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool, u64, u64, bool) {
        let v0 = if (!arg3.terminal) {
            if (arg3.group <= 55454) {
                arg2 && arg3.group > arg5 || 55454 - arg3.group > arg5
            } else {
                false
            }
        } else {
            false
        };
        let v1 = if (arg9) {
            if (v0) {
                arg6
            } else {
                false
            }
        } else {
            false
        };
        if (v1) {
            let v2 = if (true) {
                arg8
            } else {
                0
            };
            let v3 = if (true) {
                arg7
            } else {
                0
            };
            return cetus_continue_stream_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, v2, v3)
        };
        let v4 = if (true) {
            arg8
        } else {
            0
        };
        let v5 = if (true) {
            arg7
        } else {
            0
        };
        let (v6, v7, v8, v9, v10, v11, v12, v13, v14) = cetus_continue_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v4, v5);
        let v15 = v7;
        let v16 = if (!arg9) {
            true
        } else if (v14) {
            true
        } else {
            0x1::vector::length<u128>(&v15) <= 16
        };
        if (v16) {
            return (v6, v15, v8, v9, v10, v11, v12, v13, v14)
        };
        let (v17, v18, v19, v20) = compact_numeric_vectors(v6, v15, v8, v9, arg2);
        (v17, v18, v19, v20, v10, true, v12, v13, v14)
    }

    fun cetus_continue_stream_impl<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut CetusCursor, arg4: u64, arg5: u64, arg6: bool, arg7: u128, arg8: u128) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool, u64, u64, bool) {
        if (!arg6) {
            let v0 = arg3.terminal && 0x1::vector::is_empty<CetusPendingBin>(&arg3.pending);
            return (vector[], vector[], vector[], vector[], false, false, 0, 0, v0)
        };
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = 0;
        let v6 = false;
        let v7 = 0;
        let v8 = 0;
        let v9 = vector[];
        let v10 = vector[];
        let v11 = vector[];
        let v12 = vector[];
        let v13 = 0;
        let v14 = 0;
        let v15 = 0;
        let v16 = 0;
        let v17 = 0;
        let v18 = true;
        while (v8 < 0x1::u64::min(arg4, 512) * 16) {
            if (0x1::vector::is_empty<CetusPendingBin>(&arg3.pending)) {
                if (arg3.terminal || v5 >= arg5) {
                    break
                };
                if (arg8 > 0) {
                    let (v19, v20) = cetus_unread_rate_upper(arg3, arg2);
                    if (v19 && v20 <= arg8) {
                        break
                    };
                };
                if (arg7 > 0 && v7 >= (arg7 as u256)) {
                    break
                };
                if (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::contains_group<T0, T1>(arg0, arg3.group)) {
                    let v21 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::group_bins(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::borrow_bin_group(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::borrow_group_ref<T0, T1>(arg0, arg3.group)));
                    assert!(0x1::vector::length<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin>(v21) == 16, 801);
                    let v22 = if (arg2) {
                        0
                    } else {
                        15
                    };
                    let v23 = v22;
                    loop {
                        let v24 = 0x1::vector::borrow<0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::Bin>(v21, v23);
                        let v25 = if (arg2) {
                            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_b(v24)
                        } else {
                            0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::amount_a(v24)
                        };
                        if (v25 > 0) {
                            let v26 = CetusPendingBin{
                                id     : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::id(v24),
                                output : v25,
                                price  : 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::bin::price(v24),
                            };
                            0x1::vector::push_back<CetusPendingBin>(&mut arg3.pending, v26);
                        };
                        if (v23 == arg3.offset) {
                            break
                        };
                        let v27 = if (arg2) {
                            v23 + 1
                        } else {
                            v23 - 1
                        };
                        v23 = v27;
                    };
                };
                v5 = v5 + 1;
                let v28 = arg2 && arg3.group == 0 || arg3.group == 55454;
                arg3.terminal = v28;
                if (!arg3.terminal) {
                    let v29 = if (arg2) {
                        arg3.group - 1
                    } else {
                        arg3.group + 1
                    };
                    arg3.group = v29;
                    let v30 = if (arg2) {
                        15
                    } else {
                        0
                    };
                    arg3.offset = v30;
                };
            };
            if (!0x1::vector::is_empty<CetusPendingBin>(&arg3.pending)) {
                let CetusPendingBin {
                    id     : v31,
                    output : v32,
                    price  : v33,
                } = 0x1::vector::pop_back<CetusPendingBin>(&mut arg3.pending);
                let v34 = cetus_fee_for_id(0x1::vector::borrow<CetusFeeState>(&arg3.fee_state, 0), v31);
                let v35 = amount_in_for_output(v32, v33, arg2);
                let v36 = fee_exclusive(v35, v34, 1000000000);
                assert!(v35 <= 18446744073709551615 - v36, 802);
                let v37 = ((v35 + v36) as u128);
                let v38 = (v32 as u128);
                v7 = v7 + (v37 as u256);
                if (0x1::vector::length<u128>(&v10) == 16) {
                    if (v8 == 16) {
                        let v39 = 0;
                        while (v39 < 16) {
                            let v40 = *0x1::vector::borrow<u128>(&v9, v39);
                            let v41 = *0x1::vector::borrow<u128>(&v10, v39);
                            let v42 = *0x1::vector::borrow<u128>(&v11, v39);
                            if (v18) {
                                if (v13 > 340282366920938463463374607431768211455 - v40 || v14 > 340282366920938463463374607431768211455 - v41) {
                                    v18 = false;
                                } else {
                                    v13 = v13 + v40;
                                    v14 = v14 + v41;
                                    let v43 = ((1000000000 - *0x1::vector::borrow<u64>(&v12, v39)) as u256);
                                    if (arg2) {
                                        v15 = 0x1::u256::max(v15, (v42 as u256) * v43);
                                    } else {
                                        if (v42 == 0) {
                                            let v44 = (v42 as u256) * (1000000000 as u256);
                                            v15 = ((18446744073709551616 as u256) * (18446744073709551616 as u256) * v43 + v44 - 1) / v44;
                                        };
                                        if (v16 == 0 || v43 * (v16 as u256) > v17 * (v42 as u256)) {
                                            v16 = v42;
                                            v17 = v43;
                                        };
                                    };
                                };
                            };
                            v39 = v39 + 1;
                        };
                    };
                    let v45 = 0x1::vector::length<u128>(&v10);
                    let v46 = if (v18) {
                        if (v13 > 0) {
                            if (v14 > 0) {
                                v45 > 1
                            } else {
                                false
                            }
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    let v47 = v46;
                    let v48 = 0;
                    let v49 = 0;
                    if (v46) {
                        let (v50, v51) = if (arg2) {
                            (v15, (1000000000 as u256))
                        } else {
                            ((18446744073709551616 as u256) * (18446744073709551616 as u256) * v17, (v16 as u256) * (1000000000 as u256))
                        };
                        let v52 = (v50 + v51 - 1) / v51;
                        let v53 = (v14 as u256) * (18446744073709551616 as u256) / (v13 as u256);
                        v48 = v53;
                        let v54 = if (v53 > 0) {
                            if (v53 <= 340282366920938463463374607431768211455) {
                                v52 <= 340282366920938463463374607431768211455
                            } else {
                                false
                            }
                        } else {
                            false
                        };
                        v47 = v54;
                        if (v54) {
                            let v55 = if (v52 > v53) {
                                ((v52 - v53) * 10000 + v53 - 1) / v53
                            } else {
                                0
                            };
                            v49 = v55;
                            v47 = v55 <= 65535;
                        };
                    };
                    if (v47) {
                        0x1::vector::push_back<u128>(&mut v1, v13);
                        0x1::vector::push_back<u128>(&mut v2, v14);
                        0x1::vector::push_back<u128>(&mut v3, (v48 as u128));
                        0x1::vector::push_back<u64>(&mut v4, 9223372036854775808 | (v49 as u64) << 8 | v45);
                    } else {
                        let v56 = 0;
                        while (v56 < v45) {
                            0x1::vector::push_back<u128>(&mut v1, *0x1::vector::borrow<u128>(&v9, v56));
                            0x1::vector::push_back<u128>(&mut v2, *0x1::vector::borrow<u128>(&v10, v56));
                            0x1::vector::push_back<u128>(&mut v3, *0x1::vector::borrow<u128>(&v11, v56));
                            0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v12, v56));
                            v56 = v56 + 1;
                        };
                    };
                    v9 = vector[];
                    v10 = vector[];
                    v11 = vector[];
                    v12 = vector[];
                    v13 = 0;
                    v14 = 0;
                    v15 = 0;
                    v16 = 0;
                    v17 = 0;
                    v18 = true;
                };
                let v57 = &mut v9;
                let v58 = &mut v10;
                if (!append_if_nonincreasing(v57, v58, v37, v38, v33, v34, arg3.previous_price, arg3.previous_fee, arg2, 1000000000)) {
                    0x1::vector::push_back<u128>(&mut v9, v37);
                    0x1::vector::push_back<u128>(&mut v10, v38);
                    v6 = true;
                };
                0x1::vector::push_back<u128>(&mut v11, v33);
                0x1::vector::push_back<u64>(&mut v12, v34);
                if (v8 >= 16) {
                    if (v18) {
                        if (v13 > 340282366920938463463374607431768211455 - v37 || v14 > 340282366920938463463374607431768211455 - v38) {
                            v18 = false;
                        } else {
                            v13 = v13 + v37;
                            v14 = v14 + v38;
                            let v59 = ((1000000000 - v34) as u256);
                            if (arg2) {
                                v15 = 0x1::u256::max(v15, (v33 as u256) * v59);
                            } else {
                                if (v33 == 0) {
                                    let v60 = (v33 as u256) * (1000000000 as u256);
                                    v15 = ((18446744073709551616 as u256) * (18446744073709551616 as u256) * v59 + v60 - 1) / v60;
                                };
                                if (v16 == 0 || v59 * (v16 as u256) > v17 * (v33 as u256)) {
                                    v16 = v33;
                                    v17 = v59;
                                };
                            };
                        };
                    };
                };
                v8 = v8 + 1;
                arg3.previous_price = v33;
                arg3.previous_fee = v34;
                continue
            };
            if (arg3.terminal) {
                break
            };
        };
        let v61 = arg3.terminal && 0x1::vector::is_empty<CetusPendingBin>(&arg3.pending);
        if (v8 <= 16) {
            return (v9, v10, v11, v12, !v61, v6, v5, (v8 + 15) / 16, v61)
        };
        if (!0x1::vector::is_empty<u128>(&v10)) {
            let v62 = 0x1::vector::length<u128>(&v10);
            let v63 = if (v18) {
                if (v13 > 0) {
                    if (v14 > 0) {
                        v62 > 1
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            let v64 = v63;
            let v65 = 0;
            let v66 = 0;
            if (v63) {
                let (v67, v68) = if (arg2) {
                    (v15, (1000000000 as u256))
                } else {
                    ((18446744073709551616 as u256) * (18446744073709551616 as u256) * v17, (v16 as u256) * (1000000000 as u256))
                };
                let v69 = (v67 + v68 - 1) / v68;
                let v70 = (v14 as u256) * (18446744073709551616 as u256) / (v13 as u256);
                v65 = v70;
                let v71 = if (v70 > 0) {
                    if (v70 <= 340282366920938463463374607431768211455) {
                        v69 <= 340282366920938463463374607431768211455
                    } else {
                        false
                    }
                } else {
                    false
                };
                v64 = v71;
                if (v71) {
                    let v72 = if (v69 > v70) {
                        ((v69 - v70) * 10000 + v70 - 1) / v70
                    } else {
                        0
                    };
                    v66 = v72;
                    v64 = v72 <= 65535;
                };
            };
            if (v64) {
                0x1::vector::push_back<u128>(&mut v1, v13);
                0x1::vector::push_back<u128>(&mut v2, v14);
                0x1::vector::push_back<u128>(&mut v3, (v65 as u128));
                0x1::vector::push_back<u64>(&mut v4, 9223372036854775808 | (v66 as u64) << 8 | v62);
            } else {
                let v73 = 0;
                while (v73 < v62) {
                    0x1::vector::push_back<u128>(&mut v1, *0x1::vector::borrow<u128>(&v9, v73));
                    0x1::vector::push_back<u128>(&mut v2, *0x1::vector::borrow<u128>(&v10, v73));
                    0x1::vector::push_back<u128>(&mut v3, *0x1::vector::borrow<u128>(&v11, v73));
                    0x1::vector::push_back<u64>(&mut v4, *0x1::vector::borrow<u64>(&v12, v73));
                    v73 = v73 + 1;
                };
            };
        };
        (v1, v2, v3, v4, !v61, true, v5, (v8 + 15) / 16, v61)
    }

    public fun cetus_continue_with_demand_if<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut CetusCursor, arg4: u64, arg5: u64, arg6: bool, arg7: u128, arg8: u128) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool, u64, u64, bool) {
        let v0 = if (true) {
            arg8
        } else {
            0
        };
        let v1 = if (true) {
            arg7
        } else {
            0
        };
        cetus_continue_impl<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5, arg6, true, v0, v1)
    }

    public fun cetus_current<T0, T1>(arg0: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: bool) : u128 {
        let v0 = 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg0);
        let v1 = if (arg3) {
            let v2 = cetus_fee_state<T0, T1>(arg0, arg1);
            cetus_fee_for_id(&v2, v0)
        } else {
            0
        };
        rate_x64(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::bin_step<T0, T1>(arg0)), arg2, v1, 1000000000)
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
            let v5 = (v3 as u128) * (arg0.bin_step as u128);
            let v6 = ((arg0.variable_fee_control as u128) * v5 * v5 + 99999999999) / 100000000000;
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

    fun cetus_future_fee_floor(arg0: &CetusFeeState, arg1: 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32, arg2: bool) : u64 {
        let v0 = if (arg2 && 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg0.index_reference, arg1) || 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::gte(arg1, arg0.index_reference)) {
            arg1
        } else {
            arg0.index_reference
        };
        cetus_fee_for_id(arg0, v0)
    }

    fun cetus_group_secant_range(arg0: &vector<u128>, arg1: &vector<u128>, arg2: &vector<u128>, arg3: &vector<u64>, arg4: u64, arg5: u64, arg6: bool) : (bool, u128, u128, u128, u64, u64, u64) {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        let v3 = 0;
        let v4 = v3;
        let v5 = 0;
        let v6 = v5;
        while (arg4 < arg5) {
            let v7 = *0x1::vector::borrow<u128>(arg0, arg4);
            let v8 = *0x1::vector::borrow<u128>(arg1, arg4);
            let v9 = *0x1::vector::borrow<u128>(arg2, arg4);
            if (v0 > 340282366920938463463374607431768211455 - v7 || v1 > 340282366920938463463374607431768211455 - v8) {
                return (false, 0, 0, 0, 0, 0, 0)
            };
            v0 = v0 + v7;
            v1 = v1 + v8;
            let v10 = ((1000000000 - *0x1::vector::borrow<u64>(arg3, arg4)) as u256);
            if (arg6) {
                v2 = 0x1::u256::max(v2, (v9 as u256) * v10);
            } else {
                if (v9 == 0) {
                    let v11 = (v9 as u256) * (1000000000 as u256);
                    v2 = ((18446744073709551616 as u256) * (18446744073709551616 as u256) * v10 + v11 - 1) / v11;
                };
                if (v3 == 0 || v10 * (v3 as u256) > v5 * (v9 as u256)) {
                    v4 = v9;
                    v6 = v10;
                };
            };
            arg4 = arg4 + 1;
        };
        if (v0 == 0 || v1 == 0) {
            return (false, 0, 0, 0, 0, 0, 0)
        };
        let (v12, v13) = if (arg6) {
            (v2, (1000000000 as u256))
        } else {
            ((18446744073709551616 as u256) * (18446744073709551616 as u256) * v6, (v4 as u256) * (1000000000 as u256))
        };
        let v14 = (v12 + v13 - 1) / v13;
        let v15 = (v1 as u256) * (18446744073709551616 as u256) / (v0 as u256);
        let v16 = if (v15 == 0) {
            true
        } else if (v15 > 340282366920938463463374607431768211455) {
            true
        } else {
            v14 > 340282366920938463463374607431768211455
        };
        if (v16) {
            return (false, 0, 0, 0, 0, 0, 0)
        };
        let v17 = if (v14 > v15) {
            ((v14 - v15) * 10000 + v15 - 1) / v15
        } else {
            0
        };
        if (v17 > 65535) {
            return (false, 0, 0, 0, 0, 0, 0)
        };
        (true, v0, v1, (v15 as u128), 0, arg5 - arg4, (v17 as u64))
    }

    fun cetus_id_from_score(arg0: u64) : 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::I32 {
        if (arg0 >= 443636) {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(((arg0 - 443636) as u32))
        } else {
            0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::sub(0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(0), 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from(((443636 - arg0) as u32)))
        }
    }

    fun cetus_rate_upper(arg0: u128, arg1: u64, arg2: bool) : (bool, u128) {
        let v0 = if (arg2) {
            (arg0 as u256) * ((1000000000 - arg1) as u256)
        } else {
            (18446744073709551616 as u256) * (18446744073709551616 as u256) * ((1000000000 - arg1) as u256)
        };
        let v1 = if (arg2) {
            (1000000000 as u256)
        } else {
            (arg0 as u256) * (1000000000 as u256)
        };
        let v2 = (v0 + v1 - 1) / v1;
        if (v2 > 340282366920938463463374607431768211455) {
            (false, 0)
        } else {
            (true, (v2 as u128))
        }
    }

    public fun cetus_unread_rate_upper(arg0: &CetusCursor, arg1: bool) : (bool, u128) {
        let v0 = if (arg0.terminal) {
            true
        } else if (!0x1::vector::is_empty<CetusPendingBin>(&arg0.pending)) {
            true
        } else {
            0x1::vector::is_empty<CetusFeeState>(&arg0.fee_state)
        };
        if (v0) {
            return (false, 0)
        };
        let v1 = arg0.group * 16 + arg0.offset;
        if (v1 > 887272) {
            return (false, 0)
        };
        let v2 = if (v1 >= 443636) {
            v1 - 443636
        } else {
            443636 - v1
        };
        if (v2 * (0x1::vector::borrow<CetusFeeState>(&arg0.fee_state, 0).bin_step as u64) > 400000) {
            return (false, 0)
        };
        let v3 = cetus_id_from_score(v1);
        let v4 = 0x1::vector::borrow<CetusFeeState>(&arg0.fee_state, 0);
        cetus_rate_upper(0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::price_math::get_price_from_id(v3, v4.bin_step), cetus_future_fee_floor(v4, v3, arg1), arg1)
    }

    fun compact_numeric_vectors(arg0: vector<u128>, arg1: vector<u128>, arg2: vector<u128>, arg3: vector<u64>, arg4: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>) {
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = 0;
        let v5 = v4;
        while (v5 < 0x1::vector::length<u128>(&arg1)) {
            v5 = 0x1::u64::min(v5 + 16, 0x1::vector::length<u128>(&arg1));
            let (v6, v7, v8, v9, v10, v11, v12) = cetus_group_secant_range(&arg0, &arg1, &arg2, &arg3, v4, v5, arg4);
            if (v6 && v11 > 1) {
                0x1::vector::push_back<u128>(&mut v0, v7);
                0x1::vector::push_back<u128>(&mut v1, v8);
                0x1::vector::push_back<u128>(&mut v2, v9);
                0x1::vector::push_back<u64>(&mut v3, 9223372036854775808 | v10 << 24 | v12 << 8 | v11);
            } else {
                while (v5 < v5) {
                    0x1::vector::push_back<u128>(&mut v0, *0x1::vector::borrow<u128>(&arg0, v5));
                    0x1::vector::push_back<u128>(&mut v1, *0x1::vector::borrow<u128>(&arg1, v5));
                    0x1::vector::push_back<u128>(&mut v2, *0x1::vector::borrow<u128>(&arg2, v5));
                    0x1::vector::push_back<u64>(&mut v3, *0x1::vector::borrow<u64>(&arg3, v5));
                    v5 = v5 + 1;
                };
            };
        };
        (v0, v1, v2, v3)
    }

    fun fee_exclusive(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 < arg2, 801);
        if (arg0 == 0 || arg1 == 0) {
            return 0
        };
        let v0 = ((arg0 as u128) * (arg1 as u128) - 1) / ((arg2 - arg1) as u128) + 1;
        assert!(v0 <= 18446744073709551615, 802);
        (v0 as u64)
    }

    public fun ferra_after_gate<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool) {
        let (v0, v1, v2, v3, v4, v5) = ferra_after_gate_model<T0, T1>(arg0, arg1, arg2, arg3, arg4, true);
        let v6 = v4 || v5;
        (v0, v1, v2, v3, v6)
    }

    public fun ferra_after_gate_if<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool) {
        if (!arg5) {
            return (vector[], vector[], vector[], vector[], false)
        };
        ferra_after_gate<T0, T1>(arg0, arg1, arg2, arg3, arg4)
    }

    fun ferra_after_gate_model<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool) {
        assert!(arg3 > 0 && arg3 <= 512, 800);
        assert!(arg4 > 0 && arg4 <= 512, 800);
        let (v0, v1) = ferra_fee_state<T0, T1>(arg0, arg1);
        let v2 = v0;
        if (v1) {
            return (vector[], vector[], vector[], vector[], false, false)
        };
        let (v3, v4) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_range_id<T0, T1>(arg0);
        let v5 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0);
        let v6 = 0;
        let v7 = false;
        let v8 = false;
        let v9 = vector[];
        let v10 = vector[];
        let v11 = vector[];
        let v12 = vector[];
        while (0x1::vector::length<u128>(&v10) < arg3 && v6 < arg4) {
            if (arg2 && v5 < v3 || !arg2 && v5 > v4) {
                v7 = true;
                break
            };
            let (v13, v14) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, v5);
            let v15 = if (arg2) {
                v14
            } else {
                v13
            };
            if (v15 > 0) {
                let v16 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg0, v5);
                let v17 = ferra_fee_for_id(&v2, v5);
                let v18 = ferra_bin_input_capacity(v15, v16, arg2, v17);
                let v19 = &mut v9;
                let v20 = &mut v10;
                if (!append_if_nonincreasing(v19, v20, v18, (v15 as u128), v16, v17, 0, 0, arg2, 1000000000)) {
                    v8 = true;
                    if (arg5) {
                        break
                    };
                    0x1::vector::push_back<u128>(&mut v9, v18);
                    0x1::vector::push_back<u128>(&mut v10, (v15 as u128));
                };
                0x1::vector::push_back<u128>(&mut v11, v16);
                0x1::vector::push_back<u64>(&mut v12, v17);
            };
            v6 = v6 + 1;
            if (arg2 && v5 == v3 || v5 == v4) {
                v7 = true;
                break
            };
            if (arg2) {
                if (v5 == 0) {
                    v7 = true;
                    break
                };
                v5 = v5 - 1;
                continue
            };
            if (v5 == 4294967295) {
                v7 = true;
                break
            };
            v5 = v5 + 1;
        };
        (v9, v10, v11, v12, !v7, v8)
    }

    public fun ferra_after_gate_model_if<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool) {
        if (!arg5) {
            return (vector[], vector[], vector[], vector[], false, false)
        };
        ferra_after_gate_model<T0, T1>(arg0, arg1, arg2, arg3, arg4, false)
    }

    fun ferra_base_fee_prefix(arg0: &vector<u8>, arg1: u16) : (u64, bool) {
        assert!(0x1::vector::length<u8>(arg0) >= 39 && *0x1::vector::borrow<u8>(arg0, 32) <= 1, 801);
        let v0 = (*0x1::vector::borrow<u8>(arg0, 33) as u16) | (*0x1::vector::borrow<u8>(arg0, 34) as u16) << 8;
        assert!(v0 == arg1, 801);
        let v1 = (v0 as u64) * ((*0x1::vector::borrow<u8>(arg0, 35) as u64) | (*0x1::vector::borrow<u8>(arg0, 36) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, 37) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, 38) as u64) << 24);
        assert!(v1 <= 100000000, 801);
        (v1, *0x1::vector::borrow<u8>(arg0, 32) == 1)
    }

    public fun ferra_begin_if<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: u64, arg4: u64, arg5: bool) : (FerraCursor, vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool, u64, u64, bool) {
        let (v0, v1) = if (arg5) {
            0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_range_id<T0, T1>(arg0)
        } else {
            (0, 0)
        };
        let v2 = if (arg5) {
            0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0)
        } else {
            0
        };
        let (v3, v4) = if (arg5) {
            let (v5, v6) = ferra_fee_state<T0, T1>(arg0, arg1);
            let v7 = 0x1::vector::empty<FerraFeeState>();
            0x1::vector::push_back<FerraFeeState>(&mut v7, v5);
            (v7, v6)
        } else {
            (0x1::vector::empty<FerraFeeState>(), false)
        };
        let v8 = FerraCursor{
            id             : v2,
            low            : v0,
            high           : v1,
            terminal       : v4,
            fee_state      : v3,
            previous_price : 0,
            previous_fee   : 0,
        };
        let v9 = &mut v8;
        let (v10, v11, v12, v13, v14, v15, v16, v17, v18) = ferra_continue_if<T0, T1>(arg0, arg1, arg2, v9, arg3, arg4, arg5);
        (v8, v10, v11, v12, v13, v14, v15, v16, v17, v18)
    }

    fun ferra_bin_input_capacity(arg0: u64, arg1: u128, arg2: bool, arg3: u64) : u128 {
        let v0 = amount_in_for_output(arg0, arg1, arg2);
        ((v0 + fee_exclusive(v0, arg3, 1000000000)) as u128)
    }

    public fun ferra_continue_if<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: &mut FerraCursor, arg4: u64, arg5: u64, arg6: bool) : (vector<u128>, vector<u128>, vector<u128>, vector<u64>, bool, bool, u64, u64, bool) {
        if (!arg6 || arg3.terminal) {
            return (vector[], vector[], vector[], vector[], false, false, 0, 0, arg3.terminal)
        };
        let v0 = vector[];
        let v1 = vector[];
        let v2 = vector[];
        let v3 = vector[];
        let v4 = 0;
        let v5 = false;
        while (0x1::vector::length<u128>(&v1) < arg4 && v4 < arg5) {
            if (arg2 && arg3.id < arg3.low || !arg2 && arg3.id > arg3.high) {
                arg3.terminal = true;
                break
            };
            let (v6, v7) = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin<T0, T1>(arg0, arg3.id);
            let v8 = if (arg2) {
                v7
            } else {
                v6
            };
            if (v8 > 0) {
                let v9 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg0, arg3.id);
                let v10 = ferra_fee_for_id(0x1::vector::borrow<FerraFeeState>(&arg3.fee_state, 0), arg3.id);
                let v11 = ferra_bin_input_capacity(v8, v9, arg2, v10);
                let v12 = &mut v0;
                let v13 = &mut v1;
                if (!append_if_nonincreasing(v12, v13, v11, (v8 as u128), v9, v10, arg3.previous_price, arg3.previous_fee, arg2, 1000000000)) {
                    0x1::vector::push_back<u128>(&mut v0, v11);
                    0x1::vector::push_back<u128>(&mut v1, (v8 as u128));
                    v5 = true;
                };
                0x1::vector::push_back<u128>(&mut v2, v9);
                0x1::vector::push_back<u64>(&mut v3, v10);
                arg3.previous_price = v9;
                arg3.previous_fee = v10;
            };
            v4 = v4 + 1;
            let v14 = arg2 && (arg3.id == arg3.low || arg3.id == 0) || arg3.id == arg3.high || arg3.id == 4294967295;
            arg3.terminal = v14;
            if (arg3.terminal) {
                break
            };
            let v15 = if (arg2) {
                arg3.id - 1
            } else {
                arg3.id + 1
            };
            arg3.id = v15;
        };
        (v0, v1, v2, v3, !arg3.terminal, v5, v4, 0x1::vector::length<u128>(&v1), arg3.terminal)
    }

    public fun ferra_current<T0, T1>(arg0: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg1: &0x2::clock::Clock, arg2: bool, arg3: bool) : u128 {
        let v0 = 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg0);
        if (arg3) {
            let (v2, v3) = ferra_fee_state<T0, T1>(arg0, arg1);
            let v4 = v2;
            if (v3) {
                return 0
            };
            rate_x64(0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg0, v0), arg2, ferra_fee_for_id(&v4, v0), 1000000000)
        } else {
            let v5 = 0x1::bcs::to_bytes<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg0);
            let (_, v7) = ferra_base_fee_prefix(&v5, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_bin_step<T0, T1>(arg0));
            if (v7) {
                0
            } else {
                rate_x64(0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg0, v0), arg2, 0, 1000000000)
            }
        }
    }

    fun ferra_fee_for_id(arg0: &FerraFeeState, arg1: u32) : u64 {
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
        let v3 = (v2 as u256) * (arg0.bin_step as u256);
        let v4 = (arg0.base_fee_rate as u256) + ((arg0.variable_fee_control as u256) * v3 * v3 + 99) / 100;
        if (v4 > (100000000 as u256)) {
            100000000
        } else {
            (v4 as u64)
        }
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

