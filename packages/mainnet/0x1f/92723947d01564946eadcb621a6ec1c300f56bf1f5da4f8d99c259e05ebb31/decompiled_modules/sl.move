module 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::sl {
    public fun a<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_swap_borrow_a<T1, T2>(arg0, arg1, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg10);
        0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T2>(arg3, arg4, arg5, arg6, arg9, &mut v5, arg10)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T1, T2>(arg0, arg1, 0x2::coin::into_balance<T1>(v5), arg9);
            let v8 = v6;
            0x2::balance::join<T2>(&mut v4, v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg10), 0x2::tx_context::sender(arg10));
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let v9 = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_pay_amount<T1, T2>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v9, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_swap_pay_b<T1, T2>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, v9), v3);
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    public fun b<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_swap_borrow_b<T2, T1>(arg0, arg1, arg7, arg8, arg9);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg10);
        0x2::balance::join<T2>(&mut v4, 0x2::coin::into_balance<T2>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T2>(arg3, arg4, arg5, arg6, arg9, &mut v5, arg10)));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v6, v7) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(v5), arg9);
            let v8 = v6;
            0x2::balance::join<T2>(&mut v4, v7);
            if (0x2::balance::value<T1>(&v8) > 0) {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(0x2::coin::from_balance<T1>(v8, arg10), 0x2::tx_context::sender(arg10));
            } else {
                0x2::balance::destroy_zero<T1>(v8);
            };
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let v9 = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_pay_amount<T2, T1>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v9, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_swap_pay_b<T2, T1>(arg0, arg1, 0x2::balance::split<T2>(&mut v4, v9), 0x2::balance::zero<T1>(), v3);
        if (0x2::balance::value<T2>(&v4) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T2>>(0x2::coin::from_balance<T2>(v4, arg10), 0x2::tx_context::sender(arg10));
        } else {
            0x2::balance::destroy_zero<T2>(v4);
        };
    }

    public fun d<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_a<T1, T2>(arg0, arg1, arg7);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg1, 0x2::coin::into_balance<T2>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T2>(arg3, arg4, arg5, arg6, arg9, &mut v4, arg10)), arg9);
        0x2::balance::join<T1>(&mut v6, v8);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T1, T2>(arg0, arg1, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg10);
        transfer_or_destroy_balance<T2>(v7, arg10);
    }

    public fun d_sui<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, 0x2::sui::SUI>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_a<T1, 0x2::sui::SUI>(arg0, arg1, arg7);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg10);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem_sui<T0, T1>(arg3, arg4, arg5, arg6, arg9, &mut v4, arg2, arg10)), arg9);
        0x2::balance::join<T1>(&mut v6, v8);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T1, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg10);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg10);
    }

    public fun e<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_b<T2, T1>(arg0, arg1, arg7);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg10);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg1, 0x2::coin::into_balance<T2>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T2>(arg3, arg4, arg5, arg6, arg9, &mut v4, arg10)), arg9);
        0x2::balance::join<T1>(&mut v6, v8);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T2, T1>(arg0, arg1, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg10);
        transfer_or_destroy_balance<T2>(v7, arg10);
    }

    public fun e_sui<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T1>, arg2: &mut 0x3::sui_system::SuiSystemState, arg3: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: u64, arg8: u128, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_b<0x2::sui::SUI, T1>(arg0, arg1, arg7);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg10);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<0x2::sui::SUI, T1>(arg0, arg1, 0x2::coin::into_balance<0x2::sui::SUI>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem_sui<T0, T1>(arg3, arg4, arg5, arg6, arg9, &mut v4, arg2, arg10)), arg9);
        0x2::balance::join<T1>(&mut v6, v8);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<0x2::sui::SUI, T1>(arg0, arg1, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg10);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg10);
    }

    public fun f<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_swap_borrow_a<T1, T2>(arg0, arg1, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v6 = 0x2::coin::into_balance<T3>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T3>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T1, T2>(arg0, arg1, 0x2::coin::into_balance<T1>(v5), arg10);
            0x2::balance::join<T2>(&mut v4, v8);
            transfer_or_destroy_balance<T1>(v7, arg11);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, T3>(arg0, arg2, v6, arg10);
        0x2::balance::join<T2>(&mut v4, v10);
        let v11 = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_pay_amount<T1, T2>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v11, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_swap_pay_b<T1, T2>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, v11), v3);
        transfer_or_destroy_balance<T2>(v4, arg11);
        transfer_or_destroy_balance<T3>(v9, arg11);
    }

    public fun g<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_swap_borrow_a<T1, T2>(arg0, arg1, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v1;
        let v5 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v6 = 0x2::coin::into_balance<T3>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T3>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T1, T2>(arg0, arg1, 0x2::coin::into_balance<T1>(v5), arg10);
            0x2::balance::join<T2>(&mut v4, v8);
            transfer_or_destroy_balance<T1>(v7, arg11);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T3, T2>(arg0, arg2, v6, arg10);
        0x2::balance::join<T2>(&mut v4, v10);
        let v11 = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_pay_amount<T1, T2>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v11, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_swap_pay_b<T1, T2>(arg0, arg1, 0x2::balance::zero<T1>(), 0x2::balance::split<T2>(&mut v4, v11), v3);
        transfer_or_destroy_balance<T2>(v4, arg11);
        transfer_or_destroy_balance<T3>(v9, arg11);
    }

    public fun h<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_swap_borrow_b<T2, T1>(arg0, arg1, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v6 = 0x2::coin::into_balance<T3>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T3>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(v5), arg10);
            0x2::balance::join<T2>(&mut v4, v8);
            transfer_or_destroy_balance<T1>(v7, arg11);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, T3>(arg0, arg2, v6, arg10);
        0x2::balance::join<T2>(&mut v4, v10);
        let v11 = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_pay_amount<T2, T1>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v11, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_swap_pay_b<T2, T1>(arg0, arg1, 0x2::balance::split<T2>(&mut v4, v11), 0x2::balance::zero<T1>(), v3);
        transfer_or_destroy_balance<T2>(v4, arg11);
        transfer_or_destroy_balance<T3>(v9, arg11);
    }

    public fun i<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_swap_borrow_b<T2, T1>(arg0, arg1, arg8, arg9, arg10);
        let v3 = v2;
        let v4 = v0;
        let v5 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v6 = 0x2::coin::into_balance<T3>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T3>(arg4, arg5, arg6, arg7, arg10, &mut v5, arg11));
        if (0x2::coin::value<T1>(&v5) > 0) {
            let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, T1>(arg0, arg1, 0x2::coin::into_balance<T1>(v5), arg10);
            0x2::balance::join<T2>(&mut v4, v8);
            transfer_or_destroy_balance<T1>(v7, arg11);
        } else {
            0x2::coin::destroy_zero<T1>(v5);
        };
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T3, T2>(arg0, arg2, v6, arg10);
        0x2::balance::join<T2>(&mut v4, v10);
        let v11 = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_pay_amount<T2, T1>(&v3);
        assert!(0x2::balance::value<T2>(&v4) >= v11, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_swap_pay_b<T2, T1>(arg0, arg1, 0x2::balance::split<T2>(&mut v4, v11), 0x2::balance::zero<T1>(), v3);
        transfer_or_destroy_balance<T2>(v4, arg11);
        transfer_or_destroy_balance<T3>(v9, arg11);
    }

    public fun j<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_a<T1, T2>(arg0, arg1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, T3>(arg0, arg2, 0x2::coin::into_balance<T3>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T3>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg11)), arg10);
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg1, v8, arg10);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T1, T2>(arg0, arg1, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v9, arg11);
        transfer_or_destroy_balance<T3>(v7, arg11);
    }

    public fun j_sui<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_a<T1, T2>(arg0, arg1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, 0x2::sui::SUI>(arg0, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem_sui<T0, T1>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg3, arg11)), arg10);
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg1, v8, arg10);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T1, T2>(arg0, arg1, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v9, arg11);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg11);
    }

    public fun k<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_a<T1, T2>(arg0, arg1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T3, T2>(arg0, arg2, 0x2::coin::into_balance<T3>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T3>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg11)), arg10);
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg1, v8, arg10);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T1, T2>(arg0, arg1, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v9, arg11);
        transfer_or_destroy_balance<T3>(v7, arg11);
    }

    public fun k_sui<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T1, T2>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_a<T1, T2>(arg0, arg1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v0, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<0x2::sui::SUI, T2>(arg0, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem_sui<T0, T1>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg3, arg11)), arg10);
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T1, T2>(arg0, arg1, v8, arg10);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T1, T2>(arg0, arg1, 0x2::balance::split<T1>(&mut v6, v3), v1, v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v9, arg11);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg11);
    }

    public fun l<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T3>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_b<T2, T1>(arg0, arg1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, T3>(arg0, arg2, 0x2::coin::into_balance<T3>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T3>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg11)), arg10);
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg1, v8, arg10);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T2, T1>(arg0, arg1, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v9, arg11);
        transfer_or_destroy_balance<T3>(v7, arg11);
    }

    public fun l_sui<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, 0x2::sui::SUI>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_b<T2, T1>(arg0, arg1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_b_to_a<T2, 0x2::sui::SUI>(arg0, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem_sui<T0, T1>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg3, arg11)), arg10);
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg1, v8, arg10);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T2, T1>(arg0, arg1, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v9, arg11);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg11);
    }

    public fun m<T0, T1, T2, T3>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T3, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_b<T2, T1>(arg0, arg1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T3, T2>(arg0, arg2, 0x2::coin::into_balance<T3>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem<T0, T1, T3>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg11)), arg10);
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg1, v8, arg10);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T2, T1>(arg0, arg1, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v9, arg11);
        transfer_or_destroy_balance<T3>(v7, arg11);
    }

    public fun m_sui<T0, T1, T2>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T2, T1>, arg2: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T2>, arg3: &mut 0x3::sui_system::SuiSystemState, arg4: &mut 0xf95b06141ed4a174f239417323bde3f209b972f5930d8521ea38a52aff3a6ddf::lending_market::LendingMarket<T0>, arg5: 0x2::object::ID, arg6: u64, arg7: u64, arg8: u64, arg9: u128, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2, v3) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::flash_loan_borrow_b<T2, T1>(arg0, arg1, arg8);
        let v4 = 0x2::coin::from_balance<T1>(v1, arg11);
        let v5 = if (0x2::coin::value<T1>(&v4) > 0) {
            0x2::coin::into_balance<T1>(v4)
        } else {
            0x2::coin::destroy_zero<T1>(v4);
            0x2::balance::zero<T1>()
        };
        let v6 = v5;
        let (v7, v8) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<0x2::sui::SUI, T2>(arg0, arg2, 0x2::coin::into_balance<0x2::sui::SUI>(0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::executor::liquidate_and_redeem_sui<T0, T1>(arg4, arg5, arg6, arg7, arg10, &mut v4, arg3, arg11)), arg10);
        let (v9, v10) = 0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::swap_a_to_b<T2, T1>(arg0, arg1, v8, arg10);
        0x2::balance::join<T1>(&mut v6, v10);
        assert!(0x2::balance::value<T1>(&v6) >= v3, 1);
        0x1f92723947d01564946eadcb621a6ec1c300f56bf1f5da4f8d99c259e05ebb31::flash_adapters::repay_flash_loan<T2, T1>(arg0, arg1, v0, 0x2::balance::split<T1>(&mut v6, v3), v2);
        transfer_or_destroy_balance<T1>(v6, arg11);
        transfer_or_destroy_balance<T2>(v9, arg11);
        transfer_or_destroy_balance<0x2::sui::SUI>(v7, arg11);
    }

    fun transfer_or_destroy_balance<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &mut 0x2::tx_context::TxContext) {
        if (0x2::balance::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg0, arg1), 0x2::tx_context::sender(arg1));
        } else {
            0x2::balance::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v7
}

