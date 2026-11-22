module 0x60ac9fed28fc3183914c38b6ab50430da980c4d4c5208d6db8242b714f0eb0e1::p {
    struct Z has drop {
        i: vector<u64>,
        a: vector<u64>,
        c: vector<u64>,
    }

    fun ahead(arg0: u64, arg1: u64, arg2: bool) : bool {
        arg2 && arg0 <= arg1 || arg0 > arg1
    }

    public fun best(arg0: &Z) : (u64, u64) {
        let v0 = 0x1::vector::length<u64>(&arg0.i);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = (*0x1::vector::borrow<u64>(&arg0.i, v3) as u128) + (*0x1::vector::borrow<u64>(&arg0.c, v3) as u128);
            let v5 = (*0x1::vector::borrow<u64>(&arg0.a, v3) as u128);
            if (v5 > v4) {
                let v6 = v5 - v4;
                if (v0 == v0 || v6 > v1) {
                    v2 = v6;
                };
            };
            v3 = v3 + 1;
        };
        if (v0 == v0) {
            (0, 0)
        } else {
            let v9 = if (v2 > 18446744073709551615) {
                18446744073709551615
            } else {
                (v2 as u64)
            };
            (*0x1::vector::borrow<u64>(&arg0.i, v0), v9)
        }
    }

    fun biased(arg0: u32) : u64 {
        if (arg0 >= 2147483648) {
            (arg0 as u64)
        } else {
            (arg0 as u64) + 4294967296
        }
    }

    fun clamp_tick(arg0: u64) : u64 {
        if (arg0 < 4294967296 - 443636) {
            4294967296 - 443636
        } else if (arg0 > 4294967296 + 443636) {
            4294967296 + 443636
        } else {
            arg0
        }
    }

    fun deep_cost(arg0: u64, arg1: u64) : u64 {
        let v0 = ((arg0 as u128) * (arg1 as u128) + 1000000000 - 1) / 1000000000;
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun floor_div(arg0: u64, arg1: u64) : u64 {
        let v0 = (4294967296 + arg1 - 1) / arg1 * arg1;
        (arg0 + v0 - 4294967296) / arg1 + 4294967296 - v0 / arg1
    }

    fun magma_walk<T0, T1>(arg0: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg1: bool, arg2: u64) : u64 {
        let v0 = if (arg1) {
            4295048017
        } else {
            79226673515401279992447579054
        };
        let v1 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_sqrt_price<T0, T1>(arg0);
        if (arg1 && v1 <= v0 || !arg1 && v1 >= v0) {
            return 0
        };
        let v2 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::liquidity<T0, T1>(arg0);
        let v3 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::get_magma_distribution_staked_liquidity<T0, T1>(arg0);
        let v4 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::tick_manager<T0, T1>(arg0);
        let v5 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::first_score_for_swap(v4, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::current_tick_index<T0, T1>(arg0), arg1);
        let v6 = arg2;
        let v7 = 0;
        let v8 = 0;
        let v9 = 0;
        let v10 = 18446744073709551615;
        let v11 = 340282366920938463463374607431768211455;
        while (v6 > 0 && v1 != v0) {
            if (0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::is_none(&v5)) {
                return 0
            };
            let (v12, v13) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::borrow_tick_for_swap(v4, 0x682eaba7450909645bf949db3fc5881432a00b49b4c06d6974ecc4ee684e7992::option_u64::borrow(&v5), arg1);
            v5 = v13;
            let v14 = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::sqrt_price(v12);
            let v15 = if (arg1) {
                if (v0 > v14) {
                    v0
                } else {
                    v14
                }
            } else if (v0 < v14) {
                v0
            } else {
                v14
            };
            if (v2 > 0) {
                if (arg1 && v1 < v15 || !arg1 && v1 >= v15) {
                    return 0
                };
            };
            let (v16, v17, v18, v19) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::clmm_math::compute_swap_step(v1, v15, v2, v6, 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::fee_rate<T0, T1>(arg0), arg1, true);
            if (v16 != 0 || v19 != 0) {
                if (v6 < v16) {
                    return 0
                };
                let v20 = v6 - v16;
                if (v20 < v19) {
                    return 0
                };
                v6 = v20 - v19;
                let v21 = v7 + (v16 as u128);
                v7 = v21;
                let v22 = v8 + (v17 as u128);
                v8 = v22;
                let v23 = v9 + (v19 as u128);
                v9 = v23;
                let v24 = if (v21 > v10) {
                    true
                } else if (v22 > v10) {
                    true
                } else {
                    v23 > v10
                };
                if (v24) {
                    return 0
                };
            };
            if (v18 == v14) {
                v1 = v15;
                let (v25, v26) = if (arg1) {
                    (0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v12)), 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::neg(0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::magma_distribution_staked_liquidity_net(v12)))
                } else {
                    (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::liquidity_net(v12), 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::tick::magma_distribution_staked_liquidity_net(v12))
                };
                let v27 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v25);
                let v28 = 0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::abs_u128(v26);
                if (!0x659c0e9c4c8a416f040fa758d4fc4073a5fdd1fed97edadcd5cba5180fb36246::i128::is_neg(v25)) {
                    if (v11 - v2 < v27 || v11 - v3 < v28) {
                        return 0
                    };
                    v2 = v2 + v27;
                    continue
                };
                if (v2 < v27 || v3 < v28) {
                    return 0
                };
                v2 = v2 - v27;
                continue
            };
            if (v1 != v18) {
                v1 = v18;
            };
        };
        if (v6 > 0 || v8 == 0) {
            return 0
        };
        let (v29, v30) = 0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::balances<T0, T1>(arg0);
        let v31 = if (arg1) {
            v30
        } else {
            v29
        };
        let v32 = (v8 as u64);
        if (v32 > v31) {
            return 0
        };
        v32
    }

    public fun n(arg0: vector<u64>) : Z {
        let v0 = 0x1::vector::length<u64>(&arg0);
        assert!(v0 > 0 && v0 <= 16, 1);
        let v1 = vector[];
        let v2 = 0;
        while (v2 < v0) {
            0x1::vector::push_back<u64>(&mut v1, 0);
            v2 = v2 + 1;
        };
        Z{
            i : arg0,
            a : arg0,
            c : v1,
        }
    }

    public fun o(arg0: &Z) : (vector<u64>, vector<u64>, vector<u64>) {
        (arg0.i, arg0.a, arg0.c)
    }

    public fun pk(arg0: &Z, arg1: u64) : u64 {
        let v0 = 0x1::vector::length<u64>(&arg0.i);
        let v1 = 0;
        let v2 = v1;
        let v3 = 0;
        while (v3 < v0) {
            let v4 = (*0x1::vector::borrow<u64>(&arg0.i, v3) as u128) + (*0x1::vector::borrow<u64>(&arg0.c, v3) as u128);
            let v5 = (*0x1::vector::borrow<u64>(&arg0.a, v3) as u128);
            if (v5 > v4) {
                let v6 = v5 - v4;
                if (v0 == v0 || v6 > v1) {
                    v2 = v6;
                };
            };
            v3 = v3 + 1;
        };
        assert!(v0 < v0 && v2 >= (arg1 as u128), 0);
        *0x1::vector::borrow<u64>(&arg0.i, v0)
    }

    public fun qb<T0, T1>(arg0: &mut Z, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, T1>, arg2: bool, arg3: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                let v2 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::calculate_swap_results<T0, T1>(arg1, arg2, true, v1, arg3);
                let v3 = if (0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_is_exceed(&v2)) {
                    0
                } else {
                    0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::get_swap_result_amount_calculated(&v2)
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = v3;
            };
            v0 = v0 + 1;
        };
    }

    public fun qc<T0, T1>(arg0: &mut Z, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                let v2 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, v1);
                let v3 = if (0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_is_exceed(&v2)) {
                    0
                } else {
                    0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v2)
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = v3;
            };
            v0 = v0 + 1;
        };
    }

    public fun qd<T0, T1>(arg0: &mut Z, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: &0x2::clock::Clock) {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(&arg0.a)) {
            let v4 = *0x1::vector::borrow<u64>(&arg0.a, v3);
            if (v4 > 0) {
                let (v5, v6) = if (arg2) {
                    let v7 = v4 - v4 % v1;
                    if (v7 == 0 || v7 < v2) {
                        (0, 0)
                    } else {
                        let (_, v9, v10) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, v7, 0, arg4);
                        (v9, v10)
                    }
                } else {
                    let (v11, _, v13) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, 0, v4, arg4);
                    let v14 = v11 - v11 % v1;
                    if (v14 == 0 || v14 < v2) {
                        (0, 0)
                    } else {
                        (v14, v13)
                    }
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v3) = v5;
                if (v5 > 0) {
                    *0x1::vector::borrow_mut<u64>(&mut arg0.c, v3) = *0x1::vector::borrow<u64>(&arg0.c, v3) + deep_cost(v6, arg3);
                };
            };
            v3 = v3 + 1;
        };
    }

    public fun qf<T0, T1>(arg0: &mut Z, arg1: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::config::GlobalConfig, arg2: &0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::Pool<T0, T1>, arg3: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                let v2 = 0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculate_swap_result<T0, T1>(arg1, arg2, arg3, true, v1);
                let v3 = if (0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_is_exceed(&v2)) {
                    0
                } else {
                    0xe74104c66dd9f16b3096db2cc00300e556aa92edc871be4bc052b5dfb80db239::pool::calculated_swap_result_amount_out(&v2)
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = v3;
            };
            v0 = v0 + 1;
        };
    }

    public fun qfe<T0, T1>(arg0: &mut Z, arg1: &0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                let v2 = 0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculate_swap_result<T0, T1>(arg1, arg2, true, v1);
                let v3 = if (0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_is_exceed(&v2)) {
                    0
                } else {
                    0xc895342d87127c9c67b76c8ad7f9a22b8bfe1dcdc2c5af82bd85266783115e31::pool::calculated_swap_result_amount_out(&v2)
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = v3;
            };
            v0 = v0 + 1;
        };
    }

    public fun qi<T0, T1>(arg0: &mut Z, arg1: &0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg2: bool, arg3: &0x2::clock::Clock) {
        let (_, v1, v2) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_book_params<T0, T1>(arg1);
        let (v3, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg1);
        let v6 = 0;
        while (v6 < 0x1::vector::length<u64>(&arg0.a)) {
            let v7 = *0x1::vector::borrow<u64>(&arg0.a, v6);
            if (v7 > 0) {
                let v8 = if (arg2) {
                    let v9 = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::div(v7, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::float_scaling() + 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::math::mul(v3, 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::constants::fee_penalty_multiplier()));
                    let v10 = v9 - v9 % v1;
                    if (v10 == 0 || v10 < v2) {
                        0
                    } else {
                        let (_, v12, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg1, v10, 0, arg3);
                        v12
                    }
                } else {
                    let (v14, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_base_quantity_out_input_fee<T0, T1>(arg1, v7, arg3);
                    let v17 = v14 - v14 % v1;
                    if (v17 == 0 || v17 < v2) {
                        0
                    } else {
                        v17
                    }
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v6) = v8;
            };
            v6 = v6 + 1;
        };
    }

    public fun qk<T0, T1>(arg0: &mut Z, arg1: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: bool, arg3: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                let v2 = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::compute_swap_result<T0, T1>(arg1, arg2, true, arg3, v1);
                let v3 = if (0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_state_amount_specified(&v2) > 0) {
                    0
                } else {
                    0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::get_state_amount_calculated(&v2)
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = v3;
            };
            v0 = v0 + 1;
        };
    }

    public fun qm<T0, T1>(arg0: &mut Z, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool, arg3: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg2, true, arg3, v1);
                let v3 = if (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_specified(&v2) > 0) {
                    0
                } else {
                    0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v2)
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = v3;
            };
            v0 = v0 + 1;
        };
    }

    public fun qma<T0, T1>(arg0: &mut Z, arg1: &0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::Pool<T0, T1>, arg2: bool) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                let v2 = if (0x4a35d3dfef55ed3631b7158544c6322a23bc434fe4fca1234cb680ce0505f82d::pool::is_pause<T0, T1>(arg1)) {
                    0
                } else {
                    magma_walk<T0, T1>(arg1, arg2, v1)
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = v2;
            };
            v0 = v0 + 1;
        };
    }

    public fun qsd<T0, T1>(arg0: &mut Z, arg1: &0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::pool::Pool<T0, T1>, arg2: bool, arg3: u128) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                let v2 = 0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::compute_swap_result<T0, T1>(arg1, arg2, true, arg3, v1);
                let v3 = if (0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_specified(&v2) > 0) {
                    0
                } else {
                    0xb5f529c1dcda6580a61bf7ee9fbd524b50be62f11044d137c8202c8cbace9e56::trade::get_state_amount_calculated(&v2)
                };
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = v3;
            };
            v0 = v0 + 1;
        };
    }

    public fun qt<T0, T1, T2>(arg0: &mut Z, arg1: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg2: bool, arg3: u128, arg4: vector<u32>, arg5: u32) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u64>(&arg0.a)) {
            let v1 = *0x1::vector::borrow<u64>(&arg0.a, v0);
            if (v1 > 0) {
                *0x1::vector::borrow_mut<u64>(&mut arg0.a, v0) = turbos_walk<T0, T1, T2>(arg1, arg2, arg3, &arg4, biased(arg5), v1);
            };
            v0 = v0 + 1;
        };
    }

    fun times(arg0: u64, arg1: u64) : u64 {
        if (arg0 >= 4294967296) {
            4294967296 + (arg0 - 4294967296) * arg1
        } else {
            4294967296 - (4294967296 - arg0) * arg1
        }
    }

    fun to_i32(arg0: u64) : 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::I32 {
        if (arg0 >= 4294967296) {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::from(((arg0 - 4294967296) as u32))
        } else {
            0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::neg_from(((4294967296 - arg0) as u32))
        }
    }

    fun turbos_walk<T0, T1, T2>(arg0: &0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::Pool<T0, T1, T2>, arg1: bool, arg2: u128, arg3: &vector<u32>, arg4: u64, arg5: u64) : u64 {
        if (!0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_unlocked<T0, T1, T2>(arg0)) {
            return 0
        };
        let v0 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_sqrt_price<T0, T1, T2>(arg0);
        if (arg2 < 4295048016 || arg2 > 79226673515401279992447579055) {
            return 0
        };
        if (arg1 && arg2 > v0 || !arg1 && arg2 < v0) {
            return 0
        };
        let v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_liquidity<T0, T1, T2>(arg0);
        let v2 = biased(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_current_index<T0, T1, T2>(arg0)));
        let v3 = (arg5 as u128);
        let v4 = 0;
        let v5 = 0;
        let v6 = 0x1::vector::length<u32>(arg3);
        while (v3 > 0 && v0 != arg2) {
            while (v5 < v6 && !ahead(biased(*0x1::vector::borrow<u32>(arg3, v5)), v2, arg1)) {
                v5 = v5 + 1;
            };
            let v7 = word_edge(v2, (0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_tick_spacing<T0, T1, T2>(arg0) as u64), arg1);
            let (v8, v9) = if (v5 < v6 && within(biased(*0x1::vector::borrow<u32>(arg3, v5)), v7, arg1)) {
                (biased(*0x1::vector::borrow<u32>(arg3, v5)), true)
            } else {
                (v7, false)
            };
            let v10 = clamp_tick(v8);
            if (!v9 && (arg1 && v10 < arg4 || !arg1 && v10 > arg4)) {
                return 0
            };
            let v11 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::sqrt_price_from_tick_index(to_i32(v10));
            let v12 = if (arg1) {
                if (v11 < arg2) {
                    arg2
                } else {
                    v11
                }
            } else if (v11 > arg2) {
                arg2
            } else {
                v11
            };
            let v13 = v0;
            let (v14, v15, v16, v17) = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_swap::compute_swap(v0, v12, v1, v3, true, 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_pool_fee<T0, T1, T2>(arg0));
            v0 = v14;
            let v18 = v3 - v15;
            v3 = v18 - v17;
            v4 = v4 + v16;
            if (v14 == v11) {
                if (v9) {
                    let v19 = if (arg1) {
                        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i128::neg(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, to_i32(v10))))
                    } else {
                        0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick_liquidity_net(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::pool::get_tick<T0, T1, T2>(arg0, to_i32(v10)))
                    };
                    v1 = 0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_liquidity::add_delta(v1, v19);
                };
                let v20 = if (arg1) {
                    v10 - 1
                } else {
                    v10
                };
                v2 = v20;
            } else if (v14 != v13) {
                v2 = biased(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::i32::as_u32(0x91bfbc386a41afcfd9b2533058d7e915a1d3829089cc268ff4333d54d6339ca1::math_tick::tick_index_from_sqrt_price(v14)));
            };
            if (v1 == 0) {
                return 0
            };
        };
        if (v4 > 18446744073709551615) {
            0
        } else {
            (v4 as u64)
        }
    }

    fun within(arg0: u64, arg1: u64, arg2: bool) : bool {
        arg2 && arg0 >= arg1 || arg0 <= arg1
    }

    fun word_edge(arg0: u64, arg1: u64, arg2: bool) : u64 {
        let v0 = floor_div(arg0, arg1);
        if (arg2) {
            times(v0 - v0 % 256, arg1)
        } else {
            let v2 = v0 + 1;
            times(v2 - v2 % 256 + 255, arg1)
        }
    }

    // decompiled from Move bytecode v7
}

