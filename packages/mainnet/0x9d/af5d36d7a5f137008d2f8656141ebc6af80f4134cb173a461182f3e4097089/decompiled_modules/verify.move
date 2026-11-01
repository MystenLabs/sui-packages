module 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::verify {
    public fun bluefin<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg1);
        let v2 = bluefin_limit(v1, arg2);
        if (v2 == v1) {
            0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0, 0, arg3);
            return
        };
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, arg2, true, v0, v2);
        let (v4, v5) = bounded_quote(v0, (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_specified_remaining(&v3) as u128), (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v3) as u128));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_bounded_step(arg0, v4, v5, arg3);
    }

    public fun bluefin_bounded<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        bluefin_bounded_steps<T0, T1>(arg0, arg1, arg2, arg3, 4);
    }

    public fun bluefin_bounded_steps<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: u64) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let (v0, v1) = bluefin_quote_bounded<T0, T1>(arg1, arg2, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0), arg4);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_bounded_step(arg0, v0, v1, arg3);
    }

    public fun bluefin_limit(arg0: u128, arg1: bool) : u128 {
        let v0 = if (arg1) {
            88
        } else {
            112
        };
        let v1 = (arg0 as u256) * v0 / 100;
        if (arg1) {
            if (v1 < (4295048017 as u256)) {
                4295048017
            } else {
                (v1 as u128)
            }
        } else if (v1 > (79226673515401279992447579054 as u256)) {
            79226673515401279992447579054
        } else {
            (v1 as u128)
        }
    }

    public fun bluefin_quote_bounded<T0, T1>(arg0: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg2 == 0 || arg3 == 0) {
            return (0, 0)
        };
        let v0 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_manager<T0, T1>(arg0);
        let v1 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::bitmap(v0);
        let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_tick_index<T0, T1>(arg0);
        let v3 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::current_sqrt_price<T0, T1>(arg0);
        let v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::liquidity<T0, T1>(arg0);
        let v5 = bluefin_limit(v3, arg1);
        let v6 = arg2;
        let v7 = 0;
        let v8 = 0;
        loop {
            let v9 = if (v6 > 0) {
                if (v3 != v5) {
                    let v10 = &mut v8;
                    take_tick(v10, arg3)
                } else {
                    false
                }
            } else {
                false
            };
            if (v9) {
                let (v11, v12) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_bitmap::next_initialized_tick_within_one_word(v1, v2, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_tick_spacing<T0, T1>(arg0), arg1);
                let v13 = v11;
                if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::lt(v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick())) {
                    v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::min_tick();
                } else if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::gt(v11, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick())) {
                    v13 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::max_tick();
                };
                let v14 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_sqrt_price_at_tick(v13);
                let v15 = if (arg1) {
                    if (v14 < v5) {
                        v5
                    } else {
                        v14
                    }
                } else if (v14 > v5) {
                    v5
                } else {
                    v14
                };
                let (v16, v17, v18, v19) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::clmm_math::compute_swap_step(v3, v15, v4, v6, 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_fee_rate<T0, T1>(arg0), arg1, true);
                let v20 = (v16 as u128) + (v19 as u128);
                if (v20 > (v6 as u128)) {
                    return (0, 0)
                };
                let v21 = v6 - (v20 as u64);
                v6 = v21;
                let v22 = v7 + (v17 as u128);
                v7 = v22;
                if (v22 > 18446744073709551615) {
                    return (0, 0)
                };
                v3 = v18;
                if (v21 > 0 && v18 != v5) {
                    if (v18 == v14) {
                        if (v12) {
                            let v23 = if (arg1) {
                                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i128H::neg(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v0, v13)))
                            } else {
                                0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::liquidity_net(0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick::get_tick_from_manager(v0, v13))
                            };
                            v4 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::utils::add_delta(v4, v23);
                        };
                        let v24 = if (arg1) {
                            0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::i32H::sub(v13, 0x714a63a0dba6da4f017b42d5d0fb78867f18bcde904868e51d951a5a6f5b7f57::i32::from_u32(1))
                        } else {
                            v13
                        };
                        v2 = v24;
                        continue
                    };
                    if (v18 != v3) {
                        v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::tick_math::get_tick_at_sqrt_price(v18);
                    };
                };
            } else {
                break
            };
        };
        bounded_quote(arg2, (v6 as u128), v7)
    }

    public(friend) fun bounded_quote(arg0: u64, arg1: u128, arg2: u128) : (u64, u64) {
        if (arg1 > (arg0 as u128) || arg2 > 18446744073709551615) {
            (0, 0)
        } else {
            (arg0 - (arg1 as u64), (arg2 as u64))
        }
    }

    public fun cetus<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_in(&v0) + 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_fee_amount(&v0), 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun ferra<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_amount_in(&v0) + 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_fee_amount(&v0), 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun fullsail<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg4, arg1, arg2, true, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0));
        let (v1, _, _, _) = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_fees_amount(&v0);
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_step(arg0, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_in(&v0) + v1, 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v0), arg3);
    }

    public fun magma<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool, arg3: bool, arg4: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::config::GlobalConfig) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let (v0, v1) = magma_quote<T0, T1>(arg1, arg2, 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_bounded_step(arg0, v0, v1, arg3);
    }

    public fun magma_quote<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : (u64, u64) {
        magma_quote_bounded<T0, T1>(arg0, arg1, arg2, 64)
    }

    public fun magma_quote_bounded<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64, arg3: u64) : (u64, u64) {
        if (arg2 == 0 || arg3 == 0) {
            return (0, 0)
        };
        let v0 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v0, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v4 = if (arg1) {
            4295048016
        } else {
            79226673515401279992447579055
        };
        let v5 = arg2;
        let v6 = 0;
        let v7 = 0;
        while (v5 > 0 && v2 != v4) {
            let v8 = &mut v7;
            if (!take_tick(v8, arg3) || 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v1)) {
                break
            };
            let (v9, v10) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v0, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v1), arg1);
            v1 = v10;
            let v11 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v9);
            let v12 = if (arg1) {
                if (v11 < v4) {
                    v4
                } else {
                    v11
                }
            } else if (v11 > v4) {
                v4
            } else {
                v11
            };
            let (v13, v14, v15, v16) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v2, v12, v3, v5, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, true);
            let v17 = (v13 as u128) + (v16 as u128);
            if (v17 > (v5 as u128)) {
                return (0, 0)
            };
            let v18 = v5 - (v17 as u64);
            v5 = v18;
            let v19 = v6 + (v14 as u128);
            v6 = v19;
            if (v19 > 18446744073709551615) {
                return (0, 0)
            };
            v2 = v15;
            if (v18 > 0 && v15 == v11) {
                let v20 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v9);
                let v21 = if (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v20) == arg1) {
                    v3 + 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v20)
                } else {
                    v3 - 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v20)
                };
                v3 = v21;
                continue
            };
        };
        bounded_quote(arg2, (v5 as u128), v6)
    }

    public fun momentum<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg2, true, v1, v0);
        let (v3, v4) = bounded_quote(v0, (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v2) as u128), (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v2) as u128));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_bounded_step(arg0, v3, v4, arg3);
    }

    public fun suidex_v3<T0, T1>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool, arg3: bool) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::compute_swap_result<T0, T1>(arg1, arg2, true, v1, v0);
        let (v3, v4) = bounded_quote(v0, (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_specified(&v2) as u128), (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_calculated(&v2) as u128));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_bounded_step(arg0, v3, v4, arg3);
    }

    public(friend) fun take_tick(arg0: &mut u64, arg1: u64) : bool {
        if (*arg0 >= arg1) {
            return false
        };
        *arg0 = *arg0 + 1;
        true
    }

    public fun turbos<T0, T1, T2>(arg0: &mut 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::Probe, arg1: &mut 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Versioned, arg6: &mut 0x2::tx_context::TxContext) {
        if (!0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::checking(arg0)) {
            return
        };
        let v0 = 0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_amount(arg0);
        let v1 = if (arg2) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v2 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool_fetcher::compute_swap_result<T0, T1, T2>(arg1, arg2, (v0 as u128), true, v1, arg4, arg5, arg6);
        let v3 = 0x2::bcs::new(0x2::bcs::to_bytes<0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::ComputeSwapState>(&v2));
        0x2::bcs::peel_u128(&mut v3);
        0x2::bcs::peel_u128(&mut v3);
        let (v4, v5) = bounded_quote(v0, 0x2::bcs::peel_u128(&mut v3), 0x2::bcs::peel_u128(&mut v3));
        0x720b652bb0410ea9d1b4f56c4d15ce1a57bb04796fa145e50100e8f0f27872a7::probe::check_bounded_step(arg0, v4, v5, arg3);
    }

    // decompiled from Move bytecode v7
}

