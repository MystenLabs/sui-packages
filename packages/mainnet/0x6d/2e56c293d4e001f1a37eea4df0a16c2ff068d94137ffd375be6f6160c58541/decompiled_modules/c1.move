module 0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::c1 {
    public fun s0mdhfl<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0x3::sui_system::SuiSystemState, arg5: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg6: 0x2::object::ID, arg7: u64, arg8: u64, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, false, false, arg9, 79226673515401279992447579055, arg10, arg1, arg11);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg5, arg6, arg7, arg8, 0x2::coin::from_balance<T0>(v0, arg11), arg10, arg11);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg5, v4, arg4, arg10, arg11));
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            let (v8, v9) = sbm_a_b<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, 0x2::coin::into_balance<T0>(v6), arg10, arg11);
            let (v10, v11) = sbm_b_a<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, v9, arg10, arg11);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v11);
            tb<T0>(v8, arg11);
            tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v10, arg11);
        };
        let (_, v13) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let (v14, v15, v16) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, true, false, v13, 4295048017, arg10, arg1, arg11);
        let v17 = v16;
        let (v18, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v17);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > v18, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v17, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v18), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg1, arg11);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v3, 0x2::balance::zero<T0>(), v15, arg1, arg11);
        tb<0x2::sui::SUI>(v7, arg11);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v14);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1);
    }

    public fun s0mdhflr<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, false, false, arg8, 79226673515401279992447579055, arg9, arg1, arg10);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0x2::sui::SUI, T0>(arg4, arg5, arg6, arg7, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg10), arg9, arg10);
        let (v6, v7) = sbm_a_b<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v4, arg9, arg10)), arg9, arg10);
        let v8 = v7;
        let (_, v10) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v11 = 0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8);
        let (v12, v13) = if (v11 >= v10) {
            (0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v8, v10))
        } else {
            let (v14, v15) = sbm_a_b_bao<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, 0x2::coin::into_balance<0x2::sui::SUI>(v5), v10 - v11, arg9, arg10);
            let v16 = 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v8, v11);
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v16, v15);
            (v14, v16)
        };
        let v17 = v13;
        let v18 = v12;
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v17) == v10, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v3, 0x2::balance::zero<0x2::sui::SUI>(), v17, arg1, arg10);
        if (0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v8) > 0) {
            let (v19, v20) = sbm_b_a<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, v8, arg9, arg10);
            0x2::balance::join<0x2::sui::SUI>(&mut v18, v20);
            tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v19, arg10);
        } else {
            0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v8);
        };
        tb<T0>(v6, arg10);
        tb<0x2::sui::SUI>(v18, arg10);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1);
    }

    public fun s0mfl<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T0>(arg2, true, false, arg8, 4295048017, arg9, arg1, arg10);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(v1, arg10), arg9, arg10);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg4, v4, arg3, arg9, arg10));
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            let (v8, v9) = sbm_b_a<0x2::sui::SUI, T0>(arg1, arg2, 0x2::coin::into_balance<T0>(v6), arg9, arg10);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v9);
            tb<T0>(v8, arg10);
        };
        let (v10, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > v10, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T0>(arg2, v3, 0x2::balance::split<0x2::sui::SUI>(&mut v7, v10), 0x2::balance::zero<T0>(), arg1, arg10);
        tb<0x2::sui::SUI>(v7, arg10);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
    }

    public fun s0mfli<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, 0x2::sui::SUI>(arg2, false, false, arg8, 79226673515401279992447579055, arg9, arg1, arg10);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0x2::sui::SUI>(arg4, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(v0, arg10), arg9, arg10);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<0x2::sui::SUI>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise_SUI(arg4, v4, arg3, arg9, arg10));
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            let (v8, v9) = sbm_a_b<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<T0>(v6), arg9, arg10);
            0x2::balance::join<0x2::sui::SUI>(&mut v7, v9);
            tb<T0>(v8, arg10);
        };
        let (_, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v7) > v11, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v7, v11), arg1, arg10);
        tb<0x2::sui::SUI>(v7, arg10);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
    }

    public fun s0mflir<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, 0x2::sui::SUI>(arg2, true, false, arg7, 4295048016, arg8, arg1, arg9);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0x2::sui::SUI, T0>(arg3, arg4, arg5, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(v1, arg9), arg8, arg9);
        let v6 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v4, arg8, arg9));
        let (v7, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v9 = 0x2::balance::value<T0>(&v6);
        let (v10, v11) = if (v9 >= v7) {
            (0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::balance::split<T0>(&mut v6, v7))
        } else {
            let (v12, v13) = sbm_b_a_bao<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(v5), v7 - v9, arg8, arg9);
            let v14 = 0x2::balance::split<T0>(&mut v6, v9);
            0x2::balance::join<T0>(&mut v14, v13);
            (v12, v14)
        };
        let v15 = v11;
        let v16 = v10;
        assert!(0x2::balance::value<T0>(&v15) == v7, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, v3, v15, 0x2::balance::zero<0x2::sui::SUI>(), arg1, arg9);
        if (0x2::balance::value<T0>(&v6) > 0) {
            let (v17, v18) = sbm_a_b<T0, 0x2::sui::SUI>(arg1, arg2, v6, arg8, arg9);
            0x2::balance::join<0x2::sui::SUI>(&mut v16, v18);
            tb<T0>(v17, arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        tb<0x2::sui::SUI>(v16, arg9);
        0x2::balance::destroy_zero<T0>(v0);
    }

    public fun s0mflr<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, T0>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, T0>(arg2, false, false, arg7, 79226673515401279992447579055, arg8, arg1, arg9);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0x2::sui::SUI, T0>(arg3, arg4, arg5, arg6, 0x2::coin::from_balance<0x2::sui::SUI>(v0, arg9), arg8, arg9);
        let v6 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v4, arg8, arg9));
        let (_, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v9 = 0x2::balance::value<T0>(&v6);
        let (v10, v11) = if (v9 >= v8) {
            (0x2::coin::into_balance<0x2::sui::SUI>(v5), 0x2::balance::split<T0>(&mut v6, v8))
        } else {
            let (v12, v13) = sbm_a_b_bao<0x2::sui::SUI, T0>(arg1, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(v5), v8 - v9, arg8, arg9);
            let v14 = 0x2::balance::split<T0>(&mut v6, v9);
            0x2::balance::join<T0>(&mut v14, v13);
            (v12, v14)
        };
        let v15 = v11;
        let v16 = v10;
        assert!(0x2::balance::value<T0>(&v15) == v8, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, T0>(arg2, v3, 0x2::balance::zero<0x2::sui::SUI>(), v15, arg1, arg9);
        if (0x2::balance::value<T0>(&v6) > 0) {
            let (v17, v18) = sbm_b_a<0x2::sui::SUI, T0>(arg1, arg2, v6, arg8, arg9);
            0x2::balance::join<0x2::sui::SUI>(&mut v16, v18);
            tb<T0>(v17, arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        tb<0x2::sui::SUI>(v16, arg9);
        0x2::balance::destroy_zero<T0>(v1);
    }

    public fun s6mdhfl<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, 0x2::sui::SUI>(arg2, false, false, arg8, 79226673515401279992447579055, arg9, arg1, arg10);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, arg5, arg6, arg7, 0x2::coin::from_balance<T0>(v0, arg10), arg9, arg10);
        let v6 = v5;
        let (v7, v8) = sbm_b_a<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg4, v4, arg9, arg10)), arg9, arg10);
        let v9 = v8;
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            let (v10, v11) = sbm_a_b<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<T0>(v6), arg9, arg10);
            0x2::balance::join<0x2::sui::SUI>(&mut v9, v11);
            tb<T0>(v10, arg10);
        };
        let (_, v13) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v9) > v13, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, 0x2::sui::SUI>(arg2, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut v9, v13), arg1, arg10);
        tb<0x2::sui::SUI>(v9, arg10);
        tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v7, arg10);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
    }

    public fun s6mdhflr<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0x2::sui::SUI>, arg3: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg4: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, true, false, arg8, 4295048016, arg9, arg1, arg10);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg4, arg5, arg6, arg7, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1, arg10), arg9, arg10);
        let v6 = v5;
        let (v7, v8) = sbm_a_b<T0, 0x2::sui::SUI>(arg1, arg2, 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg4, v4, arg9, arg10)), arg9, arg10);
        let v9 = v8;
        if (0x2::coin::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v6) == 0) {
            0x2::coin::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v6);
        } else {
            let (v10, v11) = sbm_b_a<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg3, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v6), arg9, arg10);
            0x2::balance::join<0x2::sui::SUI>(&mut v9, v11);
            tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v10, arg10);
        };
        let (v12, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0x2::sui::SUI>(&v9) > v12, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<0x2::sui::SUI, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v3, 0x2::balance::split<0x2::sui::SUI>(&mut v9, v12), 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg1, arg10);
        tb<T0>(v7, arg10);
        tb<0x2::sui::SUI>(v9, arg10);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
    }

    public entry fun s6mfl<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, false, false, arg7, 79226673515401279992447579055, arg8, arg1, arg9);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, arg4, arg5, arg6, 0x2::coin::from_balance<T0>(v0, arg9), arg8, arg9);
        let v6 = v5;
        let v7 = 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg3, v4, arg8, arg9));
        if (0x2::coin::value<T0>(&v6) == 0) {
            0x2::coin::destroy_zero<T0>(v6);
        } else {
            let (v8, v9) = sbm_a_b<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, 0x2::coin::into_balance<T0>(v6), arg8, arg9);
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v7, v9);
            tb<T0>(v8, arg9);
        };
        let (_, v11) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&v7) > v11, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v7, v11), arg1, arg9);
        tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v7, arg9);
        0x2::balance::destroy_zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1);
    }

    public entry fun s6mflr<T0>(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg2: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>, arg3: &mut 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::LendingProtocol, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, true, false, arg7, 4295048016, arg8, arg1, arg9);
        let v3 = v2;
        let (v4, v5) = 0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::liquidate<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC, T0>(arg3, arg4, arg5, arg6, 0x2::coin::from_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v1, arg9), arg8, arg9);
        let v6 = 0x2::coin::into_balance<T0>(0xd631cd66138909636fc3f73ed75820d0c5b76332d1644608ed1c85ea2b8219b4::alpha_lending::fulfill_promise<T0>(arg3, v4, arg8, arg9));
        let (v7, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        let v9 = 0x2::balance::value<T0>(&v6);
        let (v10, v11) = if (v9 > v7) {
            (0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v5), 0x2::balance::split<T0>(&mut v6, v7))
        } else {
            let (v12, v13) = sbm_b_a_bao<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, 0x2::coin::into_balance<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v5), v7 - v9, arg8, arg9);
            let v14 = 0x2::balance::split<T0>(&mut v6, v9);
            0x2::balance::join<T0>(&mut v14, v13);
            (v12, v14)
        };
        let v15 = v11;
        let v16 = v10;
        assert!(0x2::balance::value<T0>(&v15) == v7, 20);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg2, v3, v15, 0x2::balance::zero<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(), arg1, arg9);
        if (0x2::balance::value<T0>(&v6) > 0) {
            let (v17, v18) = sbm_a_b<T0, 0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(arg1, arg2, v6, arg8, arg9);
            0x2::balance::join<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(&mut v16, v18);
            tb<T0>(v17, arg9);
        } else {
            0x2::balance::destroy_zero<T0>(v6);
        };
        tb<0xdba34672e30cb065b1f93e3ab55318768fd6fef66c15942c9f7cb846e2f900e7::usdc::USDC>(v16, arg9);
        0x2::balance::destroy_zero<T0>(v0);
    }

    fun sbm_a_b<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0) {
            return (arg2, 0x2::balance::zero<T1>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0x2::balance::value<T0>(&arg2), 4295048016, arg3, arg0, arg4);
        let v3 = v2;
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T0>(&arg2) >= v4, 30);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::zero<T1>(), arg0, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        (arg2, v1)
    }

    fun sbm_a_b_bao<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T0>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        if (0x2::balance::value<T0>(&arg2) == 0 || arg3 == 0) {
            return (arg2, 0x2::balance::zero<T1>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, false, arg3, 4295048016, arg4, arg0, arg5);
        let v3 = v2;
        let (v4, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T0>(&arg2) >= v4, 32);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::split<T0>(&mut arg2, v4), 0x2::balance::zero<T1>(), arg0, arg5);
        0x2::balance::destroy_zero<T0>(v0);
        (arg2, v1)
    }

    fun sbm_b_a<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T1>(&arg2) == 0) {
            return (arg2, 0x2::balance::zero<T0>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0x2::balance::value<T1>(&arg2), 79226673515401279992447579055, arg3, arg0, arg4);
        let v3 = v2;
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T1>(&arg2) >= v5, 31);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v5), arg0, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        (arg2, v0)
    }

    fun sbm_b_a_bao<T0, T1>(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: 0x2::balance::Balance<T1>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x2::balance::Balance<T0>) {
        if (0x2::balance::value<T1>(&arg2) == 0 || arg3 == 0) {
            return (arg2, 0x2::balance::zero<T0>())
        };
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, false, arg3, 79226673515401279992447579055, arg4, arg0, arg5);
        let v3 = v2;
        let (_, v5) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        assert!(0x2::balance::value<T1>(&arg2) >= v5, 33);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg2, v5), arg0, arg5);
        0x2::balance::destroy_zero<T1>(v1);
        (arg2, v0)
    }

    fun tb<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    public fun v(arg0: &0x7a6f2ff77134fc69698fae40532d7882a13a71577d243b916a83fb1c52be6128::admin::AdminCap) : u64 {
        6
    }

    // decompiled from Move bytecode v6
}

