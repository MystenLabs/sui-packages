module 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user {
    fun assert_global_pause_allows(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount, arg2: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount) {
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg1)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_global_allows(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_supply());
        } else if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&arg1)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_global_allows(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_withdraw());
        };
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg2)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_global_allows(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_borrow());
        } else if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&arg2)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_global_allows(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_payback());
        };
    }

    fun assert_reserve_pause_allows<T0>(arg0: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount, arg2: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount) {
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg1)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::assert_reserve_allows<T0>(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_supply());
        } else if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&arg1)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::assert_reserve_allows<T0>(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_withdraw());
        };
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg2)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::assert_reserve_allows<T0>(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_borrow());
        } else if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&arg2)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::assert_reserve_allows<T0>(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::pause::action_payback());
        };
    }

    public fun operate<T0>(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg1: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::Registry, arg2: &0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::UserCap<T0>, arg3: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount, arg4: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount, arg5: 0x2::balance::Balance<T0>, arg6: address, arg7: address, arg8: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::TransferType, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, u64, u64) {
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::registry::assert_version(arg1);
        assert_global_pause_allows(arg1, arg3, arg4);
        let v0 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_direct(&arg8);
        if (v0 && (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&arg3) && arg6 == @0x0 || 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg4) && arg7 == @0x0)) {
            abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_receiver_not_defined()
        };
        let (v1, v2, v3, v4) = operate_internal<T0>(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::user_cap::assert_active<T0>(arg1, arg2), arg3, arg4, arg5, arg6, arg7, arg9);
        let v5 = v2;
        let v6 = v1;
        if (v0) {
            let v7 = if (0x2::balance::value<T0>(&v6) > 0) {
                if (0x2::balance::value<T0>(&v5) > 0) {
                    arg6 == arg7
                } else {
                    false
                }
            } else {
                false
            };
            if (v7) {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::custody::deposit<T0>(&mut v6, v5);
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg10), arg6);
                v6 = 0x2::balance::zero<T0>();
                v5 = 0x2::balance::zero<T0>();
            } else {
                if (0x2::balance::value<T0>(&v6) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v6, arg10), arg6);
                    v6 = 0x2::balance::zero<T0>();
                };
                if (0x2::balance::value<T0>(&v5) > 0) {
                    0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(v5, arg10), arg7);
                    v5 = 0x2::balance::zero<T0>();
                };
            };
        };
        (v6, v5, v3, v4)
    }

    fun operate_internal<T0>(arg0: &mut 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::TokenReserve<T0>, arg1: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::keys::Holder, arg2: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount, arg3: 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::Amount, arg4: 0x2::balance::Balance<T0>, arg5: address, arg6: address, arg7: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T0>, u64, u64) {
        assert_reserve_pause_allows<T0>(arg0, arg2, arg3);
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_none(&arg2) && 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_none(&arg3)) {
            abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_operate_amounts_zero()
        };
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg2) < 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::min_operate_amount() && 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg3) < 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::min_operate_amount()) {
            abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::operate_amounts_nearly_zero()
        };
        if ((0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg2) as u128) > 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::max_i64() || (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg3) as u128) > 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::constants::max_i64()) {
            abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_operate_amount_too_big()
        };
        let v0 = if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg2)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg2)
        } else {
            0
        };
        let v1 = if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&arg3)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg3)
        } else {
            0
        };
        assert!((0x2::balance::value<T0>(&arg4) as u128) == (v0 as u128) + (v1 as u128), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_transfer_amount_out_of_bounds());
        let v2 = 0x8dd99ecce2f05548858a39694aa5bbdd1c61adc260f9b90dc3889a9c7930ad01::units::from_clock(arg7);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::deposit<T0>(arg0, arg4);
        let (v3, v4) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::calculate_exchange_prices<T0>(arg0, v2);
        if (!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_none(&arg2)) {
            let (v5, v6) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_as_signed_decomposition(&arg2);
            let v7 = !v6;
            let (v8, v9) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::supply_position::supply_or_withdraw(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_supply_position_mut<T0>(arg0, arg1), v7, v5, v3, v2);
            if (v9 == 0) {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_supply_with_interest<T0>(arg0, v7, v8);
            } else {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_supply_interest_free<T0>(arg0, v7, v9);
            };
        };
        if (!0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::is_none(&arg3)) {
            let (v10, v11) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_as_signed_decomposition(&arg3);
            let v12 = !v11;
            let (v13, v14) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::borrow_position::borrow_or_payback(0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_borrow_position_mut<T0>(arg0, arg1), v12, v10, v4, v2);
            if (v14 == 0) {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_borrow_with_interest<T0>(arg0, v12, v13);
            } else {
                0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::set_new_total_borrow_interest_free<T0>(arg0, v12, v14);
            };
        };
        let v15 = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::calc_utilization<T0>(arg0, v3, v4, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg2), 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg3));
        if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg3) && v15 > 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::get_max_utilization<T0>(arg0)) {
            abort 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::errors::user_module_max_utilization_reached()
        };
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::store_reserve_state<T0>(arg0, v3, v4, v15, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::calc_borrow_rate<T0>(arg0, v15), v2);
        let v16 = if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_negative(&arg2)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::withdraw<T0>(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg2))
        } else {
            0x2::balance::zero<T0>()
        };
        let v17 = if (0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_is_positive(&arg3)) {
            0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::reserve::withdraw<T0>(arg0, 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::value(&arg3))
        } else {
            0x2::balance::zero<T0>()
        };
        let (v18, v19) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_as_signed_decomposition(&arg2);
        let (v20, v21) = 0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::structs::get_as_signed_decomposition(&arg3);
        0x6949079b5873a2bbb94439acf9c85836a5a96189c687199e6cec0308348867f8::events::emit_log_operate(arg1, 0x1::type_name::with_defining_ids<T0>(), v18, v19, v20, v21, arg5, arg6, (v3 as u64), (v4 as u64));
        (v16, v17, (v3 as u64), (v4 as u64))
    }

    // decompiled from Move bytecode v7
}

