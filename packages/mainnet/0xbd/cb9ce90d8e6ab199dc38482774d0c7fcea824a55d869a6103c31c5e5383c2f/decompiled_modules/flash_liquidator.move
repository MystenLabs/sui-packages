module 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_liquidator {
    struct OperatorCap has store, key {
        id: 0x2::object::UID,
    }

    public fun a<T0, T1, T2, T3>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_swap_borrow_a<T1, T2>(arg1, arg2, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg11);
        0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T2>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T1, T2>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg10);
            let v8 = v6;
            0x2::balance::join<T2>(&mut v4, v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg11), 0x2::tx_context::sender(arg11));
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let v9 = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_pay_amount<T1, T2>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v9, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_swap_pay_b<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, v9), v3);
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    fun assert_package_upgrade_cap(arg0: &0x2::package::UpgradeCap) {
        let v0 = 0x2::package::upgrade_package(arg0);
        assert!(0x2::object::id_to_address(&v0) == 0x1::type_name::defining_id<OperatorCap>(), 3);
    }

    public fun b<T0, T1, T2, T3>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_swap_borrow_b<T2, T1>(arg1, arg2, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg11);
        0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T2>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg10);
            let v8 = v6;
            0x2::balance::join<T2>(&mut v4, v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg11), 0x2::tx_context::sender(arg11));
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let v9 = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_pay_amount<T2, T1>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v9, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_swap_pay_b<T2, T1>(arg1, arg2, 0x2::balance::split<T2>(&mut v4, v9), 0x2::balance::zero<T1>(), v3);
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg11), 0x2::tx_context::sender(arg11));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    public fun burn_operator_cap(arg0: &0x2::package::UpgradeCap, arg1: OperatorCap) {
        assert_package_upgrade_cap(arg0);
        let OperatorCap { id: v0 } = arg1;
        0x2::object::delete(v0);
    }

    public fun c<T0>(arg0: &OperatorCap, arg1: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg2: 0x2::object::ID, arg3: u256) {
        assert!(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::eq(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::obligation::weighted_borrowed_value_usd<T0>(0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::obligation<T0>(arg1, arg2)), 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::decimal::from_scaled_val(arg3)), 4);
    }

    public fun d<T0, T1, T2, T3>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_a<T1, T2>(arg1, arg2, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T1, T2>(arg1, arg2, 0x2::coin::into_balance<T2>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T2>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg11)), arg10);
        0x2::balance::join<T1>(&mut v6, v8);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T1, T2>(arg1, arg2, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v7, arg11);
    }

    public fun d_sui<T0, T1, T2>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_a<T1, 0x2::sui::SUI>(arg1, arg2, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T1, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem_sui<T0, T1>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg3, arg11)), arg10);
        0x2::balance::join<T1>(&mut v6, v8);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T1, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg11);
    }

    public fun e<T0, T1, T2, T3>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_b<T2, T1>(arg1, arg2, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T2>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T2>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg11)), arg10);
        0x2::balance::join<T1>(&mut v6, v8);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T2, T1>(arg1, arg2, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v7, arg11);
    }

    public fun e_sui<T0, T1, T2>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_b<0x2::sui::SUI, T1>(arg1, arg2, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<0x2::sui::SUI, T1>(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem_sui<T0, T1>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg3, arg11)), arg10);
        0x2::balance::join<T1>(&mut v6, v8);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<0x2::sui::SUI, T1>(arg1, arg2, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg11);
    }

    public fun f<T0, T1, T2, T3, T4>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_swap_borrow_a<T1, T2>(arg1, arg2, arg9, arg10, arg11);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v6 = 0x2::coin::into_balance<T3>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T3>(arg5, arg6, arg7, arg8, arg11, &mut v5, arg12));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T1, T2>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg11);
            0x2::balance::join<T2>(&mut v4, v8);
            transfer_or_destroy_balance<T1>(v7, arg12);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, T3>(arg1, arg3, v6, arg11);
        0x2::balance::join<T2>(&mut v4, v10);
        let v11 = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_pay_amount<T1, T2>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v11, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_swap_pay_b<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, v11), v3);
        transfer_or_destroy_balance<T2>(v4, arg12);
        transfer_or_destroy_balance<T3>(v9, arg12);
    }

    public fun g<T0, T1, T2, T3, T4>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_swap_borrow_a<T1, T2>(arg1, arg2, arg9, arg10, arg11);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v6 = 0x2::coin::into_balance<T3>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T3>(arg5, arg6, arg7, arg8, arg11, &mut v5, arg12));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T1, T2>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg11);
            0x2::balance::join<T2>(&mut v4, v8);
            transfer_or_destroy_balance<T1>(v7, arg12);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T3, T2>(arg1, arg3, v6, arg11);
        0x2::balance::join<T2>(&mut v4, v10);
        let v11 = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_pay_amount<T1, T2>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v11, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_swap_pay_b<T1, T2>(arg1, arg2, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, v11), v3);
        transfer_or_destroy_balance<T2>(v4, arg12);
        transfer_or_destroy_balance<T3>(v9, arg12);
    }

    public fun h<T0, T1, T2, T3, T4>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_swap_borrow_b<T2, T1>(arg1, arg2, arg9, arg10, arg11);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg12);
        let v6 = 0x2::coin::into_balance<T3>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T3>(arg5, arg6, arg7, arg8, arg11, &mut v5, arg12));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg11);
            0x2::balance::join<T2>(&mut v4, v8);
            transfer_or_destroy_balance<T1>(v7, arg12);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, T3>(arg1, arg3, v6, arg11);
        0x2::balance::join<T2>(&mut v4, v10);
        let v11 = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_pay_amount<T2, T1>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v11, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_swap_pay_b<T2, T1>(arg1, arg2, 0x2::balance::split<T2>(&mut v4, v11), 0x2::balance::zero<T1>(), v3);
        transfer_or_destroy_balance<T2>(v4, arg12);
        transfer_or_destroy_balance<T3>(v9, arg12);
    }

    public fun i<T0, T1, T2, T3, T4>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_swap_borrow_b<T2, T1>(arg1, arg2, arg9, arg10, arg11);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg12);
        let v6 = 0x2::coin::into_balance<T3>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T3>(arg5, arg6, arg7, arg8, arg11, &mut v5, arg12));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, T1>(arg1, arg2, 0x2::coin::into_balance<T1>(v5), arg11);
            0x2::balance::join<T2>(&mut v4, v8);
            transfer_or_destroy_balance<T1>(v7, arg12);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T3, T2>(arg1, arg3, v6, arg11);
        0x2::balance::join<T2>(&mut v4, v10);
        let v11 = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_pay_amount<T2, T1>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v11, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_swap_pay_b<T2, T1>(arg1, arg2, 0x2::balance::split<T2>(&mut v4, v11), 0x2::balance::zero<T1>(), v3);
        transfer_or_destroy_balance<T2>(v4, arg12);
        transfer_or_destroy_balance<T3>(v9, arg12);
    }

    public fun j<T0, T1, T2, T3, T4>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_a<T1, T2>(arg1, arg2, arg9);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, T3>(arg1, arg3, 0x2::coin::into_balance<T3>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T3>(arg5, arg6, arg7, arg8, arg11, &mut v4, arg12)), arg11);
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T1, T2>(arg1, arg2, v8, arg11);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T1, T2>(arg1, arg2, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg12);
        transfer_or_destroy_balance<T2>(v9, arg12);
        transfer_or_destroy_balance<T3>(v7, arg12);
    }

    public fun j_sui<T0, T1, T2, T3>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_a<T1, T2>(arg1, arg2, arg9);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, 0x2::sui::SUI>(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem_sui<T0, T1>(arg5, arg6, arg7, arg8, arg11, &mut v4, arg4, arg12)), arg11);
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T1, T2>(arg1, arg2, v8, arg11);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T1, T2>(arg1, arg2, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg12);
        transfer_or_destroy_balance<T2>(v9, arg12);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg12);
    }

    public fun k<T0, T1, T2, T3, T4>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_a<T1, T2>(arg1, arg2, arg9);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T3, T2>(arg1, arg3, 0x2::coin::into_balance<T3>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T3>(arg5, arg6, arg7, arg8, arg11, &mut v4, arg12)), arg11);
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T1, T2>(arg1, arg2, v8, arg11);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T1, T2>(arg1, arg2, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg12);
        transfer_or_destroy_balance<T2>(v9, arg12);
        transfer_or_destroy_balance<T3>(v7, arg12);
    }

    public fun k_sui<T0, T1, T2, T3>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_a<T1, T2>(arg1, arg2, arg9);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg12);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<0x2::sui::SUI, T2>(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem_sui<T0, T1>(arg5, arg6, arg7, arg8, arg11, &mut v4, arg4, arg12)), arg11);
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T1, T2>(arg1, arg2, v8, arg11);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T1, T2>(arg1, arg2, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg12);
        transfer_or_destroy_balance<T2>(v9, arg12);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg12);
    }

    public fun l<T0, T1, T2, T3, T4>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_b<T2, T1>(arg1, arg2, arg9);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg12);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, T3>(arg1, arg3, 0x2::coin::into_balance<T3>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T3>(arg5, arg6, arg7, arg8, arg11, &mut v4, arg12)), arg11);
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T2, T1>(arg1, arg2, v8, arg11);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T2, T1>(arg1, arg2, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg12);
        transfer_or_destroy_balance<T2>(v9, arg12);
        transfer_or_destroy_balance<T3>(v7, arg12);
    }

    public fun l_sui<T0, T1, T2, T3>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_b<T2, T1>(arg1, arg2, arg9);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg12);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_b_to_a<T2, 0x2::sui::SUI>(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem_sui<T0, T1>(arg5, arg6, arg7, arg8, arg11, &mut v4, arg4, arg12)), arg11);
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T2, T1>(arg1, arg2, v8, arg11);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T2, T1>(arg1, arg2, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg12);
        transfer_or_destroy_balance<T2>(v9, arg12);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg12);
    }

    public fun m<T0, T1, T2, T3, T4>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_b<T2, T1>(arg1, arg2, arg9);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg12);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T3, T2>(arg1, arg3, 0x2::coin::into_balance<T3>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem<T0, T1, T3>(arg5, arg6, arg7, arg8, arg11, &mut v4, arg12)), arg11);
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T2, T1>(arg1, arg2, v8, arg11);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T2, T1>(arg1, arg2, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg12);
        transfer_or_destroy_balance<T2>(v9, arg12);
        transfer_or_destroy_balance<T3>(v7, arg12);
    }

    public fun m_sui<T0, T1, T2, T3>(arg0: &OperatorCap, arg1: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: &0x2::clock::Clock, arg12: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::flash_loan_borrow_b<T2, T1>(arg1, arg2, arg9);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg12);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<0x2::sui::SUI, T2>(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::executor::liquidate_and_redeem_sui<T0, T1>(arg5, arg6, arg7, arg8, arg11, &mut v4, arg4, arg12)), arg11);
        let (v9, v10) = 0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::swap_a_to_b<T2, T1>(arg1, arg2, v8, arg11);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x13cf302810add3947602f20469ddd9e31b15dbe1271acc3e17f87bb9fb6d97e::flash_adapters::repay_flash_loan<T2, T1>(arg1, arg2, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg12);
        transfer_or_destroy_balance<T2>(v9, arg12);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg12);
    }

    public fun mint_operator_cap(arg0: &0x2::package::UpgradeCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        assert_package_upgrade_cap(arg0);
        let v0 = OperatorCap{id: 0x2::object::new(arg2)};
        0x2::transfer::public_transfer<OperatorCap>(v0, arg1);
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

