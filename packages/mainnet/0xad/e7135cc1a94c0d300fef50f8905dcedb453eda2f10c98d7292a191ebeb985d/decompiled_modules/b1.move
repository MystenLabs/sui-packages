module 0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::b1 {
    public fun s1bdhfl<T0>(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg10, arg1, arg2, false, false, arg9, 79226673515401279992447579055);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg5, arg6, arg7, arg8, 0x2::coin::from_balance<T0>(v0, arg11), arg10, arg11);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg5, v4, arg4, arg10, arg11));
        let (v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg10, arg1, arg3, v7, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, 0x2::balance::value<0x2::sui::SUI>(&v7), 0, 4295048017);
        let v10 = v9;
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            let v11 = 0x2::coin::into_balance<T0>(v6);
            let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg10, arg1, arg2, v11, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, 0x2::balance::value<T0>(&v11), 0, 4295048017);
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v10, v13);
            tb<T0>(v12, arg11);
        };
        let v14 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v10) > v14, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v10, v14), v3);
        tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v10, arg11);
        tb<0x2::sui::SUI>(v8, arg11);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1);
    }

    public fun s1bdhflr<T0>(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg9, arg1, arg3, false, false, arg8, 79226673515401279992447579055);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0x2::sui::SUI, T0>(arg4, arg5, arg6, arg7, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg10), arg9, arg10);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v4, arg9, arg10));
        let (v8, v9) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg9, arg1, arg2, v7, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, 0x2::balance::value<T0>(&v7), 0, 4295048017);
        let v10 = v9;
        if (0x2::coin::value<0x2::sui::SUI>(&v6) == 0) {
            0x2::coin::destroy_zero<0x2::sui::SUI>(v6);
        } else {
            let v11 = 0x2::coin::into_balance<0x2::sui::SUI>(v6);
            let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg9, arg1, arg3, v11, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, 0x2::balance::value<0x2::sui::SUI>(&v11), 0, 4295048017);
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v10, v13);
            tb<0x2::sui::SUI>(v12, arg10);
        };
        let v14 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v10) > v14, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v10, v14), v3);
        tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v10, arg10);
        tb<T0>(v8, arg10);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1);
    }

    public fun s1bfl<T0>(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T0>(arg9, arg1, arg2, true, false, arg8, 4295048017);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(v1, arg10), arg9, arg10);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg4, v4, arg3, arg9, arg10));
        let v7 = 0x2::coin::into_balance<T0>(v5);
        let v8 = 0x2::balance::value<T0>(&v7);
        if (v8 == 0) {
            0x2::balance::destroy_zero<T0>(v7);
        } else {
            let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, T0>(arg9, arg1, arg2, 0x2::balance::zero<0x2::sui::SUI>(), v7, false, true, v8, 0, 79226673515401279992447579054);
            0x2::balance::join<0x2::sui::SUI>(&mut v6, v9);
            tb<T0>(v10, arg10);
        };
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v6) > v11, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg2, 0x2::balance::split<0x2::sui::SUI>(&mut v6, v11), 0x2::balance::zero<T0>(), v3);
        tb<0x2::sui::SUI>(v6, arg10);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
    }

    public fun s1bfli<T0>(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg9, arg1, arg2, false, false, arg8, 79226673515401279992447579055);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(v0, arg10), arg9, arg10);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg4, v4, arg3, arg9, arg10));
        let v7 = 0x2::coin::into_balance<T0>(v5);
        let v8 = 0x2::balance::value<T0>(&v7);
        if (v8 == 0) {
            0x2::balance::destroy_zero<T0>(v7);
        } else {
            let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0x2::sui::SUI>(arg9, arg1, arg2, v7, 0x2::balance::zero<0x2::sui::SUI>(), true, true, v8, 0, 4295048017);
            0x2::balance::join<0x2::sui::SUI>(&mut v6, v10);
            tb<T0>(v9, arg10);
        };
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v6) > v11, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v6, v11), v3);
        tb<0x2::sui::SUI>(v6, arg10);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
    }

    public fun s1bflir<T0>(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0x2::sui::SUI>(arg8, arg1, arg2, true, false, arg7, 4295048017);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0x2::sui::SUI, T0>(arg3, arg4, arg5, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg9), arg8, arg9);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(v5);
        let v7 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v4, arg8, arg9));
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v3);
        let v9 = 0x2::balance::value<T0>(&v7);
        let (v10, v11) = if (v9 >= v8) {
            (v6, 0x2::balance::split<T0>(&mut v7, v8))
        } else {
            let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0x2::sui::SUI>(arg8, arg1, arg2, 0x2::balance::zero<T0>(), v6, false, false, v8 - v9, 0x2::balance::value<0x2::sui::SUI>(&v6), 79226673515401279992447579054);
            let v14 = 0x2::balance::split<T0>(&mut v7, v9);
            0x2::balance::join<T0>(&mut v14, v12);
            (v13, v14)
        };
        let v15 = v11;
        let v16 = v10;
        assert!(0x2::balance::value<T0>(&v15) == v8, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg1, arg2, v15, 0x2::balance::zero<0x2::sui::SUI>(), v3);
        let v17 = 0x2::balance::value<T0>(&v7);
        if (v17 > 0) {
            let (v18, v19) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0x2::sui::SUI>(arg8, arg1, arg2, v7, 0x2::balance::zero<0x2::sui::SUI>(), true, true, v17, 0, 4295048017);
            0x2::balance::join<0x2::sui::SUI>(&mut v16, v19);
            tb<T0>(v18, arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        tb<0x2::sui::SUI>(v16, arg9);
        0x2::balance::destroy_zero<T0>(v0);
    }

    public fun s1bflr<T0>(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<0x2::sui::SUI, T0>(arg8, arg1, arg2, false, false, arg7, 79226673515401279992447579054);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0x2::sui::SUI, T0>(arg3, arg4, arg5, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg9), arg8, arg9);
        let v6 = 0x2::coin::into_balance<0x2::sui::SUI>(v5);
        let v7 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v4, arg8, arg9));
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v3);
        let v9 = 0x2::balance::value<T0>(&v7);
        let (v10, v11) = if (v9 >= v8) {
            (v6, 0x2::balance::split<T0>(&mut v7, v8))
        } else {
            let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, T0>(arg8, arg1, arg2, v6, 0x2::balance::zero<T0>(), true, false, v8 - v9, 0x2::balance::value<0x2::sui::SUI>(&v6), 4295048017);
            let v14 = 0x2::balance::split<T0>(&mut v7, v9);
            0x2::balance::join<T0>(&mut v14, v13);
            (v12, v14)
        };
        let v15 = v11;
        let v16 = v10;
        assert!(0x2::balance::value<T0>(&v15) == v8, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg1, arg2, 0x2::balance::zero<0x2::sui::SUI>(), v15, v3);
        let v17 = 0x2::balance::value<T0>(&v7);
        if (v17 > 0) {
            let (v18, v19) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<0x2::sui::SUI, T0>(arg8, arg1, arg2, 0x2::balance::zero<0x2::sui::SUI>(), v7, false, true, v17, 0, 79226673515401279992447579054);
            0x2::balance::join<0x2::sui::SUI>(&mut v16, v18);
            tb<T0>(v19, arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        tb<0x2::sui::SUI>(v16, arg9);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun s6bfl<T0>(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg1, arg2, false, false, arg7, 79226673515401279992447579055);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(v0, arg9), arg8, arg9);
        let v6 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v4, arg8, arg9));
        let v7 = 0x2::coin::into_balance<T0>(v5);
        let v8 = 0x2::balance::value<T0>(&v7);
        if (v8 == 0) {
            0x2::balance::destroy_zero<T0>(v7);
        } else {
            let (v9, v10) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg1, arg2, v7, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, v8, 0, 4295048017);
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v6, v10);
            tb<T0>(v9, arg9);
        };
        let v11 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v6) > v11, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, 0x2::balance::zero<T0>(), 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v6, v11), v3);
        tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v6, arg9);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1);
    }

    public fun s6bflr<T0>(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap, arg1: &0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::config::GlobalConfig, arg2: &mut 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg1, arg2, true, false, arg7, 4295048017);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg3, arg4, arg5, arg6, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1, arg9), arg8, arg9);
        let v6 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v5);
        let v7 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v4, arg8, arg9));
        let v8 = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap_pay_amount<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v3);
        let v9 = 0x2::balance::value<T0>(&v7);
        let (v10, v11) = if (v9 >= v8) {
            (v6, 0x2::balance::split<T0>(&mut v7, v8))
        } else {
            let (v12, v13) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg1, arg2, 0x2::balance::zero<T0>(), v6, false, false, v8 - v9, 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v6), 79226673515401279992447579054);
            let v14 = 0x2::balance::split<T0>(&mut v7, v9);
            0x2::balance::join<T0>(&mut v14, v12);
            (v13, v14)
        };
        let v15 = v11;
        let v16 = v10;
        assert!(0x2::balance::value<T0>(&v15) == v8, 20);
        0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v15, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), v3);
        let v17 = 0x2::balance::value<T0>(&v7);
        if (v17 > 0) {
            let (v18, v19) = 0x3492c874c1e3b3e2984e8c41b589e642d4d0a5d6459e5a9cfc2d52fd7c89c267::pool::swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg8, arg1, arg2, v7, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), true, true, v17, 0, 4295048017);
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v16, v19);
            tb<T0>(v18, arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v7);
        };
        tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v16, arg9);
        0x2::balance::destroy_zero<T0>(v0);
    }

    fun tb<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun v(arg0: &0xf99a4fd426fc4289f0b97de544b5a2165648e49ca5512b8c0b6b52c9b6d7a177::admin::AdminCap) : u64 {
        5
    }

    // decompiled from Move bytecode v6
}

