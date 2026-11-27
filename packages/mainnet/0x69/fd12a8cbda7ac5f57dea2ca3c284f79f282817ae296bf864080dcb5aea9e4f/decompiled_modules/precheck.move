module 0x95856d3a325965f1fc863940aaf113e901f8c1774e15228fe5009952b1006c86::precheck {
    struct Bound {
        input: u64,
        amount: u64,
        dust: u64,
        floor: u64,
        unbounded: bool,
    }

    public fun aftermath<T0: key>(arg0: &mut Bound, arg1: &T0, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        aftermath_weighted_bound(arg0, 0x2::bcs::to_bytes<T0>(arg1), arg2, arg3, arg4, arg5);
    }

    fun aftermath_weighted_bound(arg0: &mut Bound, arg1: vector<u8>, arg2: u64, arg3: u64, arg4: u64, arg5: u128) {
        if (arg0.unbounded) {
            return
        };
        if (arg5 == 0 || arg4 == 0) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        let v0 = 0x2::bcs::new(arg1);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_vec_u8(&mut v0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        let v1 = 0x2::bcs::peel_vec_length(&mut v0);
        let v2 = if (arg2 >= v1) {
            true
        } else if (arg3 >= v1) {
            true
        } else {
            arg2 == arg3
        };
        if (v2) {
            arg0.unbounded = true;
            return
        };
        let v3 = 0;
        while (v3 < v1) {
            0x2::bcs::peel_vec_u8(&mut v0);
            v3 = v3 + 1;
        };
        if (0x2::bcs::peel_vec_length(&mut v0) != v1) {
            arg0.unbounded = true;
            return
        };
        let v4 = 0;
        let v5 = 0;
        let v6 = 0;
        while (v6 < v1) {
            let v7 = 0x2::bcs::peel_u128(&mut v0);
            if (v6 == arg2) {
                v4 = v7;
            };
            if (v6 == arg3) {
                v5 = v7;
            };
            v6 = v6 + 1;
        };
        let v8 = v5 / arg5;
        if (v4 == 0 || v8 == 0) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        ratio(arg0, (arg4 as u256), 1000000000);
        ratio(arg0, (v5 as u256), (v4 as u256));
        let v9 = (v8 as u256);
        if (!arg0.unbounded && (arg0.amount as u256) + (arg0.dust as u256) > v9) {
            set(arg0, 0, v9);
        };
    }

    public fun begin(arg0: u64, arg1: u64) : Bound {
        Bound{
            input     : arg0,
            amount    : arg0,
            dust      : 0,
            floor     : arg1,
            unbounded : false,
        }
    }

    public fun bluefin<T0, T1>(arg0: &mut Bound, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1), 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg1), arg2);
    }

    public fun bolt<T0, T1>(arg0: &mut Bound, arg1: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::LiquidityPool<T0>, arg2: bool, arg3: &0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::price_oracle::Oracle, arg4: &0x2::clock::Clock) {
        let v0 = if (arg2) {
            0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_quote_balance<T0, T1>(arg1)
        } else {
            let (v1, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_base_liquidity_inner<T0>(arg1);
            v1
        };
        let v3 = if (arg2) {
            let (v4, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T1, T0>(arg3, arg4);
            v4
        } else {
            let (v6, _) = 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_price<T0, T1>(arg3, arg4);
            v6
        };
        bolt_bound(arg0, v0, v3, 0xc8724de692400a2a08585f6f7c8617acfb783abe2c66ae6a4680a21b36a504c5::pool::get_precision());
    }

    fun bolt_bound(arg0: &mut Bound, arg1: u64, arg2: u128, arg3: u128) {
        if (arg0.unbounded) {
            return
        };
        if (arg1 == 0) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        let v0 = (arg3 as u256);
        let v1 = (arg2 as u256);
        let v2 = if (v1 != 0) {
            if (v0 != 0) {
                if (arg0.amount == arg0.input) {
                    if (arg0.dust == 0) {
                        (arg1 as u256) <= 115792089237316195423570985008687907853269984665640564039457584007913129639935 / v1
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        };
        if (v2) {
            let v3 = ceil((arg1 as u256) * v1, v0);
            if (v3 < (arg0.input as u256)) {
                arg0.input = (v3 as u64);
                arg0.amount = (v3 as u64);
            };
        };
        ratio(arg0, v0, v1);
        if (!arg0.unbounded && (arg0.amount as u256) + (arg0.dust as u256) > (arg1 as u256)) {
            set(arg0, 0, (arg1 as u256));
        };
    }

    public fun book(arg0: &mut Bound, arg1: u64, arg2: bool) {
        if (arg0.unbounded) {
            return
        };
        if (arg1 == 0) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        let (v0, v1) = if (arg2) {
            let v1 = ceil((arg0.dust as u256) * (arg1 as u256), 1000000000);
            let v0 = ceil((arg0.amount as u256) * (arg1 as u256), 1000000000);
            (v0, v1)
        } else {
            let v1 = ceil(((arg0.dust as u256) + (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fills() as u256)) * 1000000000, (arg1 as u256));
            let v0 = ceil((arg0.amount as u256) * 1000000000, (arg1 as u256));
            (v0, v1)
        };
        set(arg0, v0, v1);
    }

    fun book_levels(arg0: &mut Bound, arg1: &vector<u64>, arg2: &vector<u64>, arg3: bool) {
        if (arg0.unbounded) {
            return
        };
        let v0 = 0x1::vector::length<u64>(arg1);
        let v1 = 0x1::vector::length<u64>(arg2);
        let v2 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        if (v2 == 0 || *0x1::vector::borrow<u64>(arg1, 0) == 0) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        let v3 = (*0x1::vector::borrow<u64>(arg1, 0) as u256);
        let v4 = (*0x1::vector::borrow<u64>(arg2, 0) as u256);
        if (arg3) {
            let v5 = if (v2 >= 2) {
                (*0x1::vector::borrow<u64>(arg1, 1) as u256)
            } else {
                0
            };
            let v6 = if (v2 >= 2) {
                (*0x1::vector::borrow<u64>(arg2, 1) as u256)
            } else {
                0
            };
            let v7 = if (v2 < 3) {
                if (arg0.amount == arg0.input) {
                    arg0.dust == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                let v8 = v4 + v6;
                if (v8 < (arg0.input as u256)) {
                    arg0.input = (v8 as u64);
                    arg0.amount = (v8 as u64);
                };
            };
            let v9 = (arg0.amount as u256) + (arg0.dust as u256);
            let (v10, v11) = if (v9 <= v4) {
                (v3, 0)
            } else if (v2 >= 2 && v9 <= v4 + v6) {
                let v12 = if (v3 > v5) {
                    v3 - v5
                } else {
                    0
                };
                (v5, v12 * v4)
            } else {
                let v13 = if (v2 >= 3) {
                    (*0x1::vector::borrow<u64>(arg1, 2) as u256)
                } else {
                    0
                };
                let v14 = if (v3 > v13) {
                    v3 - v13
                } else {
                    0
                };
                let v15 = if (v5 > v13) {
                    v5 - v13
                } else {
                    0
                };
                (v13, v14 * v4 + v15 * v6)
            };
            let v16 = ceil((arg0.amount as u256) * v10, 1000000000);
            let v17 = ceil((arg0.dust as u256) * v10 + v11, 1000000000);
            set(arg0, v16, v17);
        } else {
            let v18 = if (v2 >= 2) {
                (*0x1::vector::borrow<u64>(arg1, 1) as u256)
            } else {
                0
            };
            let v19 = if (v2 >= 2) {
                (*0x1::vector::borrow<u64>(arg2, 1) as u256)
            } else {
                0
            };
            let v20 = if (v2 < 3) {
                if (arg0.amount == arg0.input) {
                    arg0.dust == 0
                } else {
                    false
                }
            } else {
                false
            };
            if (v20) {
                let v21 = ceil(v3 * v4 + v18 * v19, 1000000000);
                if (v21 < (arg0.input as u256)) {
                    arg0.input = (v21 as u64);
                    arg0.amount = (v21 as u64);
                };
            };
            let v22 = (0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::max_fills() as u256);
            let v23 = ((arg0.amount as u256) + (arg0.dust as u256) + v22) * 1000000000;
            let v24 = v3 * v4;
            if (v23 <= v24) {
                let v25 = ceil((arg0.amount as u256) * 1000000000, v3);
                let v26 = ceil(((arg0.dust as u256) + v22) * 1000000000, v3);
                set(arg0, v25, v26);
            } else if (v2 == 1 || v18 == 0) {
                set(arg0, 0, v4);
            } else if (v23 <= v24 + v18 * v19) {
                let v27 = if (v18 > v3) {
                    v18 - v3
                } else {
                    0
                };
                let v28 = ceil((arg0.amount as u256) * 1000000000, v18);
                let v29 = ceil(((arg0.dust as u256) + v22) * 1000000000 + v27 * v4, v18);
                set(arg0, v28, v29);
            } else if (v2 == 2 || *0x1::vector::borrow<u64>(arg1, 2) == 0) {
                set(arg0, 0, v4 + v19);
            } else {
                let v30 = (*0x1::vector::borrow<u64>(arg1, 2) as u256);
                let v31 = if (v30 > v3) {
                    v30 - v3
                } else {
                    0
                };
                let v32 = if (v30 > v18) {
                    v30 - v18
                } else {
                    0
                };
                let v33 = ceil((arg0.amount as u256) * 1000000000, v30);
                let v34 = ceil(((arg0.dust as u256) + v22) * 1000000000 + v31 * v4 + v32 * v19, v30);
                set(arg0, v33, v34);
            };
        };
    }

    fun ceil(arg0: u256, arg1: u256) : u256 {
        let v0 = if (arg0 % arg1 == 0) {
            0
        } else {
            1
        };
        arg0 / arg1 + v0
    }

    public fun cetus<T0, T1>(arg0: &mut Bound, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::current_sqrt_price<T0, T1>(arg1), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun deepbook<T0, T1>(arg0: &mut Bound, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let (v0, v1, v2, v3) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_level2_ticks_from_mid<T0, T1>(arg1, 3, arg3);
        let v4 = v3;
        let v5 = v2;
        let v6 = v1;
        let v7 = v0;
        if (arg2) {
            book_levels(arg0, &v7, &v6, true);
        } else {
            book_levels(arg0, &v5, &v4, false);
        };
    }

    public fun dipcoin<T0, T1>(arg0: &mut Bound, arg1: &0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>, arg2: bool) {
        let (v0, v1, v2) = dipcoin_state(0x2::bcs::to_bytes<0xdae28ab9ab072c647c4e8f2057a8f17dcc4847e42d6a8258df4b376ae183c872::manage::Pool<T0, T1>>(arg1));
        input_fee(arg0, v2, 10000);
        if (arg2) {
            ratio(arg0, (v1 as u256), (v0 as u256));
        } else {
            ratio(arg0, (v0 as u256), (v1 as u256));
        };
    }

    fun dipcoin_state(arg0: vector<u8>) : (u64, u64, u64) {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        0x2::bcs::peel_u64(&mut v0);
        (0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0), 0x2::bcs::peel_u64(&mut v0))
    }

    public fun dlmm<T0, T1>(arg0: &mut Bound, arg1: &0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::Pool<T0, T1>, arg2: bool) {
        input_fee(arg0, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::base_fee_rate<T0, T1>(arg1), 1000000000);
        if (arg2) {
            ratio(arg0, (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::effective_bin_price<T0, T1>(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg1)) as u256), 18446744073709551616);
        } else {
            ratio(arg0, 18446744073709551616, (0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::effective_bin_price<T0, T1>(arg1, 0x5664f9d3fd82c84023870cfbda8ea84e14c8dd56ce557ad2116e0668581a682b::pool::active_id<T0, T1>(arg1)) as u256));
        };
    }

    public fun ferra<T0, T1>(arg0: &mut Bound, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::current_sqrt_price<T0, T1>(arg1), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun ferra_lb<T0, T1>(arg0: &mut Bound, arg1: &0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>, arg2: bool) {
        input_fee(arg0, ferra_lb_fee(0x2::bcs::to_bytes<0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::LBPair<T0, T1>>(arg1)), 1000000000);
        if (arg2) {
            ratio(arg0, (0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg1, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg1)) as u256), 18446744073709551616);
        } else {
            ratio(arg0, 18446744073709551616, (0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_price_from_id<T0, T1>(arg1, 0x5a5c1d10e4782dbbdec3eb8327ede04bd078b294b97cfdba447b11b846b383ac::lb_pair::get_active_id<T0, T1>(arg1)) as u256));
        };
    }

    fun ferra_lb_fee(arg0: vector<u8>) : u64 {
        let v0 = 0x2::bcs::new(arg0);
        0x2::bcs::peel_address(&mut v0);
        0x2::bcs::peel_bool(&mut v0);
        let v1 = (0x2::bcs::peel_u32(&mut v0) as u64) * (0x2::bcs::peel_u16(&mut v0) as u64);
        if (v1 > 100000000) {
            100000000
        } else {
            v1
        }
    }

    public fun finish(arg0: Bound) {
        let Bound {
            input     : v0,
            amount    : v1,
            dust      : v2,
            floor     : v3,
            unbounded : v4,
        } = arg0;
        let v5 = if (v1 > v0) {
            ((v1 - v0) as u128)
        } else {
            0
        };
        assert!(v4 || v5 + (v2 as u128) >= (v3 as u128), 0);
    }

    public fun flowx_clmm<T0, T1>(arg0: &mut Bound, arg1: &0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::PoolRegistry, arg2: u64, arg3: bool) {
        let v0 = 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool_manager::borrow_pool<T0, T1>(arg1, arg2);
        rounded_tick(arg0, 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::sqrt_price_current<T0, T1>(v0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::swap_fee_rate<T0, T1>(v0), 0x25929e7f29e0a30eb4e692952ba1b5b65a3a4d65ab5f2a32e1ba3edcb587f26d::pool::tick_spacing<T0, T1>(v0), arg3);
    }

    public fun fullsail<T0, T1>(arg0: &mut Bound, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::current_sqrt_price<T0, T1>(arg1), 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    fun input_fee(arg0: &mut Bound, arg1: u64, arg2: u64) {
        if (arg0.unbounded) {
            return
        };
        if (arg2 == 0 || arg1 >= arg2) {
            arg0.unbounded = true;
            return
        };
        ratio(arg0, ((arg2 - arg1) as u256), (arg2 as u256));
    }

    public fun magma<T0, T1>(arg0: &mut Bound, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool) {
        tick(arg0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg1), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg1), arg2);
    }

    public fun momentum<T0, T1>(arg0: &mut Bound, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) {
        rounded_tick(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::swap_fee_rate<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::tick_spacing<T0, T1>(arg1), arg2);
    }

    public fun ratio(arg0: &mut Bound, arg1: u256, arg2: u256) {
        if (arg0.unbounded) {
            return
        };
        if (arg2 == 0 || arg1 != 0 && ((arg0.amount as u256) > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1 || (arg0.dust as u256) > 115792089237316195423570985008687907853269984665640564039457584007913129639935 / arg1)) {
            arg0.unbounded = true;
            return
        };
        let v0 = ceil((arg0.amount as u256) * arg1, arg2);
        let v1 = ceil((arg0.dust as u256) * arg1, arg2);
        set(arg0, v0, v1);
    }

    fun read_u64_le(arg0: &vector<u8>, arg1: u64) : u64 {
        (*0x1::vector::borrow<u8>(arg0, arg1) as u64) | (*0x1::vector::borrow<u8>(arg0, arg1 + 1) as u64) << 8 | (*0x1::vector::borrow<u8>(arg0, arg1 + 2) as u64) << 16 | (*0x1::vector::borrow<u8>(arg0, arg1 + 3) as u64) << 24 | (*0x1::vector::borrow<u8>(arg0, arg1 + 4) as u64) << 32 | (*0x1::vector::borrow<u8>(arg0, arg1 + 5) as u64) << 40 | (*0x1::vector::borrow<u8>(arg0, arg1 + 6) as u64) << 48 | (*0x1::vector::borrow<u8>(arg0, arg1 + 7) as u64) << 56
    }

    fun rounded_tick(arg0: &mut Bound, arg1: u128, arg2: u64, arg3: u32, arg4: bool) {
        if (arg0.unbounded) {
            return
        };
        if (arg2 != 0) {
            if (arg3 == 0) {
                arg0.unbounded = true;
                return
            };
            let v0 = 887272 / (arg3 as u256) + 3;
            let v1 = if (v0 > 64) {
                64
            } else {
                v0
            };
            let v2 = (arg0.amount as u256);
            let v3 = if (v1 > v2) {
                v2
            } else {
                v1
            };
            let v4 = (arg0.dust as u256) + ceil(v3, 2);
            set(arg0, v2, v4);
        };
        tick(arg0, arg1, arg2, arg4);
    }

    fun set(arg0: &mut Bound, arg1: u256, arg2: u256) {
        if (arg1 > 18446744073709551615 || arg2 > 18446744073709551615) {
            arg0.unbounded = true;
        };
        let v0 = if (arg1 > 18446744073709551615) {
            18446744073709551615
        } else {
            arg1
        };
        arg0.amount = (v0 as u64);
        let v1 = if (arg2 > 18446744073709551615) {
            18446744073709551615
        } else {
            arg2
        };
        arg0.dust = (v1 as u64);
    }

    public fun steamm_cpmm<T0: key>(arg0: &mut Bound, arg1: &T0, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = 0x2::bcs::to_bytes<T0>(arg1);
        steamm_cpmm_bound(arg0, &v0, arg2, arg3, arg4);
    }

    fun steamm_cpmm_bound(arg0: &mut Bound, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: bool) {
        if (arg0.unbounded) {
            return
        };
        let v0 = 0x1::vector::length<u8>(arg1);
        if (v0 < 228) {
            arg0.unbounded = true;
            return
        };
        let v1 = read_u64_le(arg1, v0 - 186);
        let v2 = read_u64_le(arg1, v0 - 178);
        let v3 = read_u64_le(arg1, v0 - 122);
        let v4 = read_u64_le(arg1, v0 - 114);
        let v5 = if (v0 == 228) {
            read_u64_le(arg1, 34)
        } else {
            0
        };
        let v6 = if (arg4) {
            v2
        } else {
            v1
        };
        let v7 = if (v6 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v7) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        let (v8, v9) = if (arg4) {
            ((v1 as u256), (v2 as u256) + (v5 as u256))
        } else {
            ((v2 as u256) + (v5 as u256), (v1 as u256))
        };
        let v10 = if (v8 == 0) {
            true
        } else if (v4 == 0) {
            true
        } else {
            v3 >= v4
        };
        if (v10) {
            arg0.unbounded = true;
            return
        };
        let v11 = ceil((v6 as u256) * (arg3 as u256), 1000000000);
        ratio(arg0, (arg2 as u256), 1000000000);
        input_fee(arg0, v3, v4);
        ratio(arg0, v9, v8);
        ratio(arg0, (arg3 as u256), 1000000000);
        if (!arg0.unbounded && (arg0.amount as u256) + (arg0.dust as u256) > v11) {
            set(arg0, 0, v11);
        };
    }

    public fun steamm_omm<T0: key>(arg0: &mut Bound, arg1: &T0, arg2: u64, arg3: u64, arg4: bool) {
        let v0 = 0x2::bcs::to_bytes<T0>(arg1);
        steamm_omm_bound(arg0, &v0, arg2, arg3, arg4);
    }

    fun steamm_omm_bound(arg0: &mut Bound, arg1: &vector<u8>, arg2: u64, arg3: u64, arg4: bool) {
        if (arg0.unbounded) {
            return
        };
        let v0 = 0x1::vector::length<u8>(arg1);
        if (v0 < 228) {
            arg0.unbounded = true;
            return
        };
        let v1 = if (arg4) {
            read_u64_le(arg1, v0 - 178)
        } else {
            read_u64_le(arg1, v0 - 186)
        };
        let v2 = if (v1 == 0) {
            true
        } else if (arg2 == 0) {
            true
        } else {
            arg3 == 0
        };
        if (v2) {
            arg0.amount = 0;
            arg0.dust = 0;
            return
        };
        let v3 = ceil((v1 as u256) * (arg2 as u256), 1000000000);
        let v4 = if (v3 > 18446744073709551615) {
            (18446744073709551615 as u64)
        } else {
            (v3 as u64)
        };
        bolt_bound(arg0, v4, (1000000000 as u128), (arg3 as u128));
    }

    public fun suidex<T0, T1>(arg0: &mut Bound, arg1: &0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::Pair<T0, T1>, arg2: bool) {
        let (v0, v1, _) = 0xbfac5e1c6bf6ef29b12f7723857695fd2f4da9a11a7d88162c15e9124c243a4a::pair::get_reserves<T0, T1>(arg1);
        input_fee(arg0, 30, 10000);
        if (arg2) {
            ratio(arg0, v1, v0);
        } else {
            ratio(arg0, v0, v1);
        };
    }

    public fun suidex_v3<T0, T1>(arg0: &mut Bound, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool) {
        rounded_tick(arg0, 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::sqrt_price<T0, T1>(arg1), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::swap_fee_rate<T0, T1>(arg1), 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::tick_spacing<T0, T1>(arg1), arg2);
    }

    public fun tick(arg0: &mut Bound, arg1: u128, arg2: u64, arg3: bool) {
        if (arg0.unbounded) {
            return
        };
        let v0 = (arg1 as u256);
        if (v0 == 0) {
            arg0.unbounded = true;
            return
        };
        input_fee(arg0, arg2, 1000000);
        if (arg3) {
            ratio(arg0, v0 * v0, 340282366920938463463374607431768211456);
        } else {
            ratio(arg0, 340282366920938463463374607431768211456, v0 * v0);
        };
    }

    public fun turbos<T0, T1, T2>(arg0: &mut Bound, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool) {
        rounded_tick(arg0, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg1), (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg1) as u64), 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg1), arg2);
    }

    // decompiled from Move bytecode v7
}

