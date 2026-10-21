module 0x5e423c8e59d7854747069b676bed46276a2355f0b005d5333b74e441b696847b::flash {
    public(friend) fun borrow_ab<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, false, false, arg2, 79226673515401279992447579055, arg3);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v1);
        (v0, v2)
    }

    public(friend) fun borrow_ba<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: u64, arg3: &0x2::clock::Clock) : (0x2::balance::Balance<T0>, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<0x2::sui::SUI, T0>) {
        let (v0, v1, v2) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, true, false, arg2, 4295048016, arg3);
        0x2::balance::destroy_zero<0x2::sui::SUI>(v0);
        (v1, v2)
    }

    fun finish<T0>(arg0: 0x2::balance::Balance<0x2::sui::SUI>, arg1: 0x2::balance::Balance<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(arg0, arg2), 0x2::tx_context::sender(arg2));
        if (0x2::balance::value<T0>(&arg1) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(arg1, arg2), 0x2::tx_context::sender(arg2));
        } else {
            0x2::balance::destroy_zero<T0>(arg1);
        };
    }

    public(friend) fun settle_ab<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<T0, 0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<T0>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<T0, 0x2::sui::SUI>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        if (v0 >= 1000) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, true, true, v0, 4295048016, arg2);
            let v4 = v3;
            0x2::balance::destroy_zero<T0>(v1);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::split<T0>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&v4)), 0x2::balance::zero<0x2::sui::SUI>(), v4);
            0x2::balance::join<0x2::sui::SUI>(&mut arg3, v2);
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<T0, 0x2::sui::SUI>(&arg5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3) >= v5 + arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<T0, 0x2::sui::SUI>(arg0, arg1, 0x2::balance::zero<T0>(), 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v5), arg5);
        finish<T0>(arg3, arg4, arg7);
    }

    public(friend) fun settle_ba<T0>(arg0: &0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::config::GlobalConfig, arg1: &mut 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::Pool<0x2::sui::SUI, T0>, arg2: &0x2::clock::Clock, arg3: 0x2::balance::Balance<0x2::sui::SUI>, arg4: 0x2::balance::Balance<T0>, arg5: 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::FlashSwapReceipt<0x2::sui::SUI, T0>, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<T0>(&arg4);
        if (v0 >= 1000) {
            let (v1, v2, v3) = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::flash_swap<0x2::sui::SUI, T0>(arg0, arg1, false, true, v0, 79226673515401279992447579055, arg2);
            let v4 = v3;
            0x2::balance::destroy_zero<T0>(v2);
            0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::zero<0x2::sui::SUI>(), 0x2::balance::split<T0>(&mut arg4, 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&v4)), v4);
            0x2::balance::join<0x2::sui::SUI>(&mut arg3, v1);
        };
        let v5 = 0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::swap_pay_amount<0x2::sui::SUI, T0>(&arg5);
        assert!(0x2::balance::value<0x2::sui::SUI>(&arg3) >= v5 + arg6, 1);
        0x1eabed72c53feb3805120a081dc15963c204dc8d091542592abaf7a35689b2fb::pool::repay_flash_swap<0x2::sui::SUI, T0>(arg0, arg1, 0x2::balance::split<0x2::sui::SUI>(&mut arg3, v5), 0x2::balance::zero<T0>(), arg5);
        finish<T0>(arg3, arg4, arg7);
    }

    // decompiled from Move bytecode v7
}

