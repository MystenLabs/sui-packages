module 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::utils {
    struct SwapIfZeroEvent has copy, drop {
        vault_id: 0x2::object::ID,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        is_a: bool,
        amount_in: u64,
        amount_out: u64,
        timestamp_ms: u64,
    }

    struct LpResidualEvent has copy, drop {
        vault_id: 0x2::object::ID,
        lp_coin_a: u64,
        lp_coin_b: u64,
        before_sqrt_price: u128,
        after_sqrt_price: u128,
        is_a: bool,
        swap_amt: u64,
        residual_coin_a: u64,
        residual_coin_b: u64,
        timestamp_ms: u64,
    }

    public fun swap<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>, arg3: bool, arg4: bool, arg5: u64, arg6: u128, arg7: &0x2::clock::Clock, arg8: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v3 = v2;
        let (v4, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        if (arg3) {
            0x2::coin::join<T1>(&mut arg2, 0x2::coin::from_balance<T1>(v1, arg9));
            0x2::balance::destroy_zero<T0>(v0);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg1, v4, arg9)), 0x2::balance::zero<T1>(), arg8, arg9);
        } else {
            0x2::coin::join<T0>(&mut arg1, 0x2::coin::from_balance<T0>(v0, arg9));
            0x2::balance::destroy_zero<T1>(v1);
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v3, 0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v5, arg9)), arg8, arg9);
        };
        (arg1, arg2)
    }

    public fun add_liquidity<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &mut 0x2::balance::Balance<T0>, arg3: &mut 0x2::balance::Balance<T1>, arg4: &0x2::clock::Clock, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
        let v2 = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::position_borrow_mut<T0, T1, T2, T3>(arg0);
        let (_, v4, v5) = check_is_fix_coin_a(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), 0x2::balance::value<T0>(arg2), 0x2::balance::value<T1>(arg3));
        if (v4 > 0 && v5 > 0) {
            let (v6, v7) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, v2, 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg2, v4), arg6), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg3, v5), arg6), 0, 0, arg4, arg5, arg6);
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v6));
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v7));
        };
    }

    public(friend) fun close_position<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::version::Version, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::remove_liquidity<T0, T1>(arg1, 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::position_borrow<T0, T1, T2, T3>(arg0)), 0, 0, arg2, arg4, arg5);
        0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::collect::fees<T0, T1, T2, T3>(arg0, arg1, arg3, arg4, arg2, arg5);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::close_position(0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::remove_position<T0, T1, T2, T3>(arg0), arg4, arg5);
        (0x2::coin::into_balance<T0>(v0), 0x2::coin::into_balance<T1>(v1))
    }

    fun get_tick_at_sqrt_price(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg1: u32, arg2: u128) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        let v0 = get_initializable_tick_index(arg0, arg1);
        let v1 = get_next_initializable_tick_index(arg0, arg1);
        let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v0);
        let v3 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v1);
        let v4 = if (arg2 > v2) {
            arg2 - v2
        } else {
            v2 - arg2
        };
        let v5 = if (arg2 > v3) {
            arg2 - v3
        } else {
            v3 - arg2
        };
        if (v4 < v5) {
            v0
        } else {
            v1
        }
    }

    public fun assert_slippage(arg0: u128, arg1: u128, arg2: bool) {
        let v0 = arg2 && arg0 <= arg1 || arg0 >= arg1;
        assert!(!v0, 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::error::slippage_crossed());
    }

    public fun check_is_fix_coin_a(arg0: u128, arg1: u128, arg2: u128, arg3: u64, arg4: u64) : (bool, u64, u64) {
        let (v0, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(arg2, arg0, arg1, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_liquidity_for_amounts(arg2, arg0, arg1, arg3, arg4), true);
        let v2 = if (v0 == arg3) {
            true
        } else if (v0 == arg3 + 1) {
            true
        } else {
            v0 + 1 == arg3
        };
        let v3 = v2;
        (v3, v0, v1)
    }

    fun closer(arg0: u128, arg1: u128, arg2: u128) : bool {
        let v0 = if (arg0 > arg2) {
            arg0 - arg2
        } else {
            arg2 - arg0
        };
        let v1 = if (arg1 > arg2) {
            arg1 - arg2
        } else {
            arg2 - arg1
        };
        v0 < v1
    }

    public(friend) fun create_position<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg3: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &mut 0x2::tx_context::TxContext) {
        0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::update_last_rebalance_sqrt_price<T0, T1, T2, T3>(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1));
        0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::insert_position<T0, T1, T2, T3>(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::open_position<T0, T1>(arg1, arg3, arg2, arg4, arg5));
    }

    public(friend) fun generate_auth_token<T0>(arg0: &T0) : 0x1::ascii::String {
        0x1::type_name::into_string(0x1::type_name::get<T0>())
    }

    public fun get_a_to_b_price(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) * 1000000000 / (arg1 as u128)) as u64)
    }

    public fun get_amount_by_liquidity<T0, T1, T2, T3: copy + drop + store>(arg0: &0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::Vault<T0, T1, T2, T3>, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: bool) : (u64, u64) {
        let v0 = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::position_borrow<T0, T1, T2, T3>(arg0);
        let v1 = if (arg2) {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::liquidity(v0)
        } else {
            0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::liquidity<T0, T1>(arg1)
        };
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity_math::get_amounts_for_liquidity(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_lower_index(v0)), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::position::tick_upper_index(v0)), v1, false)
    }

    public fun get_b_to_a_price(arg0: u64, arg1: u64) : u64 {
        (((arg1 as u128) * 1000000000 / (arg0 as u128)) as u64)
    }

    fun get_initializable_tick_index(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg1: u32) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::sub(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::mod(arg0, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg1)))
    }

    fun get_next_initializable_tick_index(arg0: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, arg1: u32) : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32 {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::add(get_initializable_tick_index(arg0, arg1), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::from(arg1))
    }

    public fun get_optimal_swap_amount_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: bool, arg5: u64) : (u64, bool) {
        let (v0, v1) = if (arg1 == 0) {
            let (v2, v3) = if (arg4) {
                (arg3, false)
            } else {
                (0, false)
            };
            (v3, v2)
        } else {
            let (v4, v5) = if (arg2 == 0) {
                if (arg4) {
                    (0, true)
                } else {
                    (arg3, true)
                }
            } else {
                let v6 = 1000000;
                let v7 = (arg1 as u128) * v6 / (arg2 as u128);
                let v8 = 0;
                let v9 = arg3 / 2;
                let v10 = false;
                while (v8 < arg5) {
                    let v11 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculate_swap_result<T0, T1>(arg0, arg4, true, v9);
                    let v12 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::calculated_swap_result_amount_out(&v11);
                    let v13 = if (arg4) {
                        arg3 - v9
                    } else {
                        v12
                    };
                    let v14 = if (arg4) {
                        v12
                    } else {
                        arg3 - v9
                    };
                    let v15 = (v13 as u128) * (v6 as u128) / (v14 as u128);
                    if (v8 == 0) {
                    } else if (v15 > v7) {
                        if (arg4) {
                            let v16 = arg3 + v9;
                            v9 = v16 / 2;
                        } else {
                            let v17 = 0 + v9;
                            v9 = v17 / 2;
                        };
                        v10 = true;
                    } else {
                        if (arg4) {
                            let v18 = 0 + v9;
                            v9 = v18 / 2;
                        } else {
                            let v19 = arg3 + v9;
                            v9 = v19 / 2;
                        };
                        v10 = false;
                    };
                    v8 = v8 + 1;
                };
                (v9, !v10)
            };
            (v5, v4)
        };
        (v1, v0)
    }

    public fun get_optimal_swap_amount_mmt<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u64, arg3: u64, arg4: u128, arg5: bool, arg6: u64) : (u64, bool) {
        let (v0, v1) = if (arg1 == 0) {
            let (v2, v3) = if (arg5) {
                (arg3, false)
            } else {
                (0, false)
            };
            (v3, v2)
        } else {
            let (v4, v5) = if (arg2 == 0) {
                if (arg5) {
                    (0, true)
                } else {
                    (arg3, true)
                }
            } else {
                let v6 = 1000000;
                let v7 = (arg1 as u128) * (v6 as u128) / (arg2 as u128);
                let v8 = 0;
                let v9 = arg3 / 2;
                let v10 = false;
                while (v8 < arg6) {
                    let v11 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg0, arg5, true, arg4, v9);
                    let v12 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v11);
                    let v13 = if (arg5) {
                        arg3 - v9
                    } else {
                        v12
                    };
                    let v14 = if (arg5) {
                        v12
                    } else {
                        arg3 - v9
                    };
                    let v15 = (v13 as u128) * (v6 as u128) / (v14 as u128);
                    if (v8 == 0) {
                    } else if (v15 > v7) {
                        if (arg5) {
                            let v16 = arg3 + v9;
                            v9 = v16 / 2;
                        } else {
                            let v17 = 0 + v9;
                            v9 = v17 / 2;
                        };
                        v10 = true;
                    } else {
                        if (arg5) {
                            let v18 = 0 + v9;
                            v9 = v18 / 2;
                        } else {
                            let v19 = arg3 + v9;
                            v9 = v19 / 2;
                        };
                        v10 = false;
                    };
                    v8 = v8 + 1;
                };
                (v9, !v10)
            };
            (v5, v4)
        };
        (v1, v0)
    }

    public fun get_oracle_sqrt_price<T0, T1>(arg0: &0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::MmtOracle, arg1: u8, arg2: u8, arg3: &0x2::clock::Clock) : u128 {
        oracle_price_to_sqrt_price(get_a_to_b_price(0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::get_price(arg0, 0x1::type_name::get<T0>(), arg3), 0x69fea1d4f9275f58bec2465ac54ccf6477a44fb89c6ab893421ad849fb947ae::oracle::get_price(arg0, 0x1::type_name::get<T1>(), arg3)), arg1, arg2)
    }

    public fun get_scalled_position_bounds(arg0: u128, arg1: u128, arg2: u128, arg3: u32) : (0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::i32::I32) {
        (get_tick_at_sqrt_price(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_tick_at_sqrt_price(scale(arg0, arg1)), arg3, arg0), get_tick_at_sqrt_price(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_tick_at_sqrt_price(scale(arg0, arg2)), arg3, arg0))
    }

    public(friend) fun lp_residual_amount<T0, T1, T2, T3: copy + drop + store>(arg0: &mut 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::Vault<T0, T1, T2, T3>, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: bool, arg4: u64, arg5: &0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::version::Version, arg6: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg7: &mut 0x2::tx_context::TxContext) : (0x1::option::Option<LpResidualEvent>, 0x1::option::Option<LpResidualEvent>) {
        0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::version::assert_supported_version(arg5);
        0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::check_pool_compatibility<T0, T1, T2, T3>(arg0, arg1);
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1);
        let (v1, v2) = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::get_slippage<T0, T1, T2, T3>(arg0);
        let v3 = 0x1::option::none<LpResidualEvent>();
        let v4 = 0x1::option::none<LpResidualEvent>();
        if (arg3 && (0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_balance_a_val<T0, T1, T2, T3>(arg0) > 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_threshold_a<T0, T1, T2, T3>(arg0) || arg4 > 0)) {
            let v5 = if (arg4 == 0) {
                let (v6, _) = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_balance_a_val<T0, T1, T2, T3>(arg0), true, 16);
                v6
            } else {
                arg4
            };
            let v8 = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::get_free_balance_a<T0, T1, T2, T3>(arg0);
            assert!(v5 <= 0x2::balance::value<T0>(&v8), 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::error::insufficient_balance_lp_residual());
            let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v5), arg7);
            let v10 = 0x2::coin::zero<T1>(arg7);
            let (v11, v12) = swap<T0, T1>(arg1, v9, v10, true, true, v5, slippage_adjusted_sqrt_price(true, v1, v2, v0), arg2, arg6, arg7);
            let v13 = v12;
            let v14 = v11;
            assert!(0x2::coin::value<T0>(&v14) == 0, 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::error::slippage_crossed());
            0x2::coin::destroy_zero<T0>(v14);
            let v15 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1);
            let (v16, v17) = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
            let (_, v19, v20) = check_is_fix_coin_a(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v16), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v17), v15, 0x2::balance::value<T0>(&v8), 0x2::coin::value<T1>(&v13));
            let (v21, v22) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut v8, v19), arg7), 0x2::coin::split<T1>(&mut v13, v20, arg7), 0, 0, arg2, arg6, arg7);
            let v23 = v22;
            let v24 = v21;
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v24));
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v23));
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, v8);
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v13));
            let v25 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::Vault<T0, T1, T2, T3>>(arg0),
                lp_coin_a         : v19 - 0x2::coin::value<T0>(&v24),
                lp_coin_b         : v20 - 0x2::coin::value<T1>(&v23),
                before_sqrt_price : v0,
                after_sqrt_price  : v15,
                is_a              : arg3,
                swap_amt          : v5,
                residual_coin_a   : 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_balance_a_val<T0, T1, T2, T3>(arg0),
                residual_coin_b   : 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_balance_b_val<T0, T1, T2, T3>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg2),
            };
            0x1::option::fill<LpResidualEvent>(&mut v3, v25);
            0x2::event::emit<LpResidualEvent>(v25);
        };
        if (!arg3 && (0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_balance_b_val<T0, T1, T2, T3>(arg0) > 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_threshold_b<T0, T1, T2, T3>(arg0) || arg4 > 0)) {
            let v26 = if (arg4 == 0) {
                let (v27, _) = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::get_optimal_swap_amount_for_single_sided_liquidity<T0, T1, T2, T3>(arg0, arg1, 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_balance_b_val<T0, T1, T2, T3>(arg0), false, 16);
                v27
            } else {
                arg4
            };
            let v29 = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::get_free_balance_b<T0, T1, T2, T3>(arg0);
            assert!(v26 <= 0x2::balance::value<T1>(&v29), 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::error::insufficient_balance_lp_residual());
            let v30 = 0x2::coin::zero<T0>(arg7);
            let v31 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v29, v26), arg7);
            let (v32, v33) = swap<T0, T1>(arg1, v30, v31, false, true, v26, slippage_adjusted_sqrt_price(false, v1, v2, v0), arg2, arg6, arg7);
            let v34 = v33;
            let v35 = v32;
            assert!(0x2::coin::value<T1>(&v34) == 0, 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::error::slippage_crossed());
            0x2::coin::destroy_zero<T1>(v34);
            let v36 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg1);
            let (v37, v38) = 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::get_position_tick_range<T0, T1, T2, T3>(arg0);
            let (_, v40, v41) = check_is_fix_coin_a(0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v37), 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::tick_math::get_sqrt_price_at_tick(v38), v36, 0x2::coin::value<T0>(&v35), 0x2::balance::value<T1>(&v29));
            let (v42, v43) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::liquidity::add_liquidity<T0, T1>(arg1, 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::position_borrow_mut<T0, T1, T2, T3>(arg0), 0x2::coin::split<T0>(&mut v35, v40, arg7), 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(&mut v29, v41), arg7), 0, 0, arg2, arg6, arg7);
            let v44 = v43;
            let v45 = v42;
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T1>(v44));
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v45));
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_b<T0, T1, T2, T3>(arg0, v29);
            0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::add_free_balance_a<T0, T1, T2, T3>(arg0, 0x2::coin::into_balance<T0>(v35));
            let v46 = LpResidualEvent{
                vault_id          : 0x2::object::id<0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::Vault<T0, T1, T2, T3>>(arg0),
                lp_coin_a         : v40 - 0x2::coin::value<T0>(&v45),
                lp_coin_b         : v41 - 0x2::coin::value<T1>(&v44),
                before_sqrt_price : v0,
                after_sqrt_price  : v36,
                is_a              : arg3,
                swap_amt          : v26,
                residual_coin_a   : 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_balance_a_val<T0, T1, T2, T3>(arg0),
                residual_coin_b   : 0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::free_balance_b_val<T0, T1, T2, T3>(arg0),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg2),
            };
            0x1::option::fill<LpResidualEvent>(&mut v4, v46);
            0x2::event::emit<LpResidualEvent>(v46);
        };
        (v3, v4)
    }

    public fun oracle_price_to_sqrt_price(arg0: u64, arg1: u8, arg2: u8) : u128 {
        let v0 = (arg0 as u128) * 10000000000000000;
        let v1 = v0;
        let v2 = 1000000000;
        let v3 = v2;
        if (arg2 >= arg1) {
            v1 = (((v0 as u256) * (0x1::u128::pow(10, arg2 - arg1) as u256)) as u128);
        } else {
            v3 = (((v2 as u256) * (0x1::u128::pow(10, arg1 - arg2) as u256)) as u128);
        };
        ((((0x1::u128::sqrt(v1) / 0x1::u128::sqrt(v3)) as u256) * 18446744073709551616 / 100000000) as u128)
    }

    public fun scale(arg0: u128, arg1: u128) : u128 {
        (((arg0 as u256) * (arg1 as u256) / (0x9d089eb688c6dba35c651c7e24212938b744c785c53e2ed48bfc72386c849e14::vault::scalling_factor() as u256)) as u128)
    }

    public fun slippage_adjusted_sqrt_price(arg0: bool, arg1: u128, arg2: u128, arg3: u128) : u128 {
        if (arg1 == 0 && arg2 == 0) {
            if (arg0) {
                4295048017
            } else {
                79226673515401279992447579054
            }
        } else if (arg0) {
            scale(arg3, arg2)
        } else {
            scale(arg3, arg1)
        }
    }

    public fun swap_if_zero<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x2::balance::Balance<T0>, arg2: &mut 0x2::balance::Balance<T1>, arg3: u128, arg4: u128, arg5: 0x2::object::ID, arg6: &0x2::clock::Clock, arg7: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg8: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0);
        if (0x2::balance::value<T0>(arg1) == 0 && 0x2::balance::value<T1>(arg2) / 2 > 0) {
            let v1 = 0x2::balance::value<T1>(arg2) / 2;
            let v2 = 0x2::coin::zero<T0>(arg8);
            let v3 = 0x2::coin::from_balance<T1>(0x2::balance::split<T1>(arg2, v1), arg8);
            let (v4, v5) = swap<T0, T1>(arg0, v2, v3, false, true, v1, slippage_adjusted_sqrt_price(false, arg3, arg4, v0), arg6, arg7, arg8);
            let v6 = v4;
            0x2::coin::destroy_zero<T1>(v5);
            let v7 = SwapIfZeroEvent{
                vault_id          : arg5,
                before_sqrt_price : v0,
                after_sqrt_price  : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0),
                is_a              : false,
                amount_in         : v1,
                amount_out        : 0x2::coin::value<T0>(&v6),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<SwapIfZeroEvent>(v7);
            0x2::balance::join<T0>(arg1, 0x2::coin::into_balance<T0>(v6));
        };
        if (0x2::balance::value<T1>(arg2) == 0 && 0x2::balance::value<T0>(arg1) / 2 > 0) {
            let v8 = 0x2::balance::value<T0>(arg1) / 2;
            let v9 = 0x2::coin::from_balance<T0>(0x2::balance::split<T0>(arg1, v8), arg8);
            let v10 = 0x2::coin::zero<T1>(arg8);
            let (v11, v12) = swap<T0, T1>(arg0, v9, v10, true, true, v8, slippage_adjusted_sqrt_price(true, arg3, arg4, v0), arg6, arg7, arg8);
            let v13 = v12;
            0x2::coin::destroy_zero<T0>(v11);
            let v14 = SwapIfZeroEvent{
                vault_id          : arg5,
                before_sqrt_price : v0,
                after_sqrt_price  : 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::sqrt_price<T0, T1>(arg0),
                is_a              : true,
                amount_in         : v8,
                amount_out        : 0x2::coin::value<T1>(&v13),
                timestamp_ms      : 0x2::clock::timestamp_ms(arg6),
            };
            0x2::event::emit<SwapIfZeroEvent>(v14);
            0x2::balance::join<T1>(arg2, 0x2::coin::into_balance<T1>(v13));
        };
    }

    public fun swap_on_cetus<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: 0x2::coin::Coin<T1>, arg4: bool, arg5: bool, arg6: u64, arg7: u128, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg4, arg5, arg6, arg7, arg8);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        if (arg4) {
        };
        if (arg4) {
            assert!(v6 <= 0x2::coin::value<T0>(&arg2), 3);
        } else {
            assert!(v6 <= 0x2::coin::value<T1>(&arg3), 4);
        };
        let (v7, v8) = if (arg4) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v6, arg9)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg3, v6, arg9)))
        };
        0x2::coin::join<T1>(&mut arg3, 0x2::coin::from_balance<T1>(v4, arg9));
        0x2::coin::join<T0>(&mut arg2, 0x2::coin::from_balance<T0>(v5, arg9));
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v7, v8, v3);
        (arg2, arg3)
    }

    // decompiled from Move bytecode v6
}

