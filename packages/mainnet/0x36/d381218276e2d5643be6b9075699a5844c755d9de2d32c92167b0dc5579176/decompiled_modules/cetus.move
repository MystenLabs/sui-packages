module 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::cetus {
    struct CetusSwapEvent has copy, drop, store {
        pool: 0x2::object::ID,
        amount_in: u64,
        amount_out: u64,
        a2b: bool,
        by_amount_in: bool,
        coin_a: 0x1::type_name::TypeName,
        coin_b: 0x1::type_name::TypeName,
    }

    fun flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: u64, arg4: u64, arg5: u128, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, T1>(arg0, arg1, arg2, true, arg3, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        let v7 = 0x2::balance::value<T1>(&v4);
        let v8 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&v3);
        let v9 = if (arg2) {
            assert!(v7 > arg4, 0);
            v7
        } else {
            assert!(v6 > arg4, 0);
            v6
        };
        let v10 = CetusSwapEvent{
            pool         : 0x2::object::id<0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>>(arg1),
            amount_in    : v8,
            amount_out   : v9,
            a2b          : arg2,
            by_amount_in : true,
            coin_a       : 0x1::type_name::get<T0>(),
            coin_b       : 0x1::type_name::get<T1>(),
        };
        0x2::event::emit<CetusSwapEvent>(v10);
        (0x2::coin::from_balance<T0>(v5, arg7), 0x2::coin::from_balance<T1>(v4, arg7), v3, v8)
    }

    fun repay_flash_swap<T0, T1>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg2: bool, arg3: 0x2::coin::Coin<T0>, arg4: 0x2::coin::Coin<T1>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, T1>, arg6: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0x2::coin::Coin<T1>) {
        let (v0, v1) = if (arg2) {
            (0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg3, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5), arg6)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, T1>(&arg5), arg6)))
        };
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, T1>(arg0, arg1, v0, v1, arg5);
        (arg3, arg4)
    }

    public fun cetus_swap_a_b_buy<T0, T1>(arg0: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::KongBot<T0>, arg1: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::Banana<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_bananas<T0>(arg0, arg1, arg5, arg7);
        let v2 = v1;
        let (v3, v4, v5, v6) = flash_swap<T0, T1>(arg2, arg3, true, v0, arg4, 4295048016, arg6, arg7);
        assert!(v6 == 0x2::coin::value<T0>(&v2), 0);
        let v7 = 0x2::coin::zero<T1>(arg7);
        let (v8, v9) = repay_flash_swap<T0, T1>(arg2, arg3, true, v2, v7, v5, arg7);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T0>(v8, arg7);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T1>(v9, arg7);
        0x2::coin::destroy_zero<T0>(v3);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T1>(v4, arg7);
    }

    public fun cetus_swap_a_b_sell<T0, T1>(arg0: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::KongBot<T1>, arg1: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::Banana<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T0>(&arg5);
        let (v1, v2, v3, v4) = flash_swap<T0, T1>(arg2, arg3, true, v0, arg4, 4295048016, arg6, arg7);
        assert!(v4 == v0, 0);
        let (_, v6) = 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_bananas<T1>(arg0, arg1, v2, arg7);
        let v7 = 0x2::coin::zero<T1>(arg7);
        let (v8, v9) = repay_flash_swap<T0, T1>(arg2, arg3, true, arg5, v7, v3, arg7);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T0>(v8, arg7);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T1>(v9, arg7);
        0x2::coin::destroy_zero<T0>(v1);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T1>(v6, arg7);
    }

    public fun cetus_swap_b_a_buy<T0, T1>(arg0: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::KongBot<T1>, arg1: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::Banana<T1>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_bananas<T1>(arg0, arg1, arg5, arg7);
        let v2 = v1;
        let (v3, v4, v5, v6) = flash_swap<T0, T1>(arg2, arg3, false, v0, arg4, 79226673515401279992447579055, arg6, arg7);
        assert!(v6 == 0x2::coin::value<T1>(&v2), 0);
        let v7 = 0x2::coin::zero<T0>(arg7);
        let (v8, v9) = repay_flash_swap<T0, T1>(arg2, arg3, false, v7, v2, v5, arg7);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T0>(v8, arg7);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T1>(v9, arg7);
        0x2::coin::destroy_zero<T1>(v4);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T0>(v3, arg7);
    }

    public fun cetus_swap_b_a_sell<T0, T1>(arg0: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::KongBot<T0>, arg1: &mut 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::Banana<T0>, arg2: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg3: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, T1>, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<T1>(&arg5);
        let (v1, v2, v3, v4) = flash_swap<T0, T1>(arg2, arg3, false, v0, arg4, 79226673515401279992447579055, arg6, arg7);
        assert!(v4 == v0, 0);
        let (_, v6) = 0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_bananas<T0>(arg0, arg1, v1, arg7);
        let v7 = 0x2::coin::zero<T0>(arg7);
        let (v8, v9) = repay_flash_swap<T0, T1>(arg2, arg3, false, v7, arg5, v3, arg7);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T0>(v8, arg7);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T1>(v9, arg7);
        0x2::coin::destroy_zero<T1>(v2);
        0x36d381218276e2d5643be6b9075699a5844c755d9de2d32c92167b0dc5579176::bot::transfer_or_destroy_coin<T0>(v6, arg7);
    }

    // decompiled from Move bytecode v6
}

