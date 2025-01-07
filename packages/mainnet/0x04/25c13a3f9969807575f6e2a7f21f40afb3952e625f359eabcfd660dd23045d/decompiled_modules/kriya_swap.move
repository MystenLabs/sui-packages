module 0x425c13a3f9969807575f6e2a7f21f40afb3952e625f359eabcfd660dd23045d::kriya_swap {
    public fun flash_swap_a2b<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T1>, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt, u64) {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, true, true, arg1, min_sqrt_price(), arg2, arg3, arg4);
        let v3 = 0x2::coin::from_balance<T1>(v1, arg4);
        transfer_or_destroy_coin<T0>(0x2::coin::from_balance<T0>(v0, arg4), arg4);
        (v3, v2, 0x2::balance::value<T1>(0x2::coin::balance<T1>(&v3)))
    }

    public fun flash_swap_b2a<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: u64, arg2: &0x2::clock::Clock, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<T0>, 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt, u64) {
        let (v0, v1, v2) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg0, false, true, arg1, max_sqrt_price(), arg2, arg3, arg4);
        let v3 = 0x2::coin::from_balance<T0>(v0, arg4);
        transfer_or_destroy_coin<T1>(0x2::coin::from_balance<T1>(v1, arg4), arg4);
        (v3, v2, 0x2::balance::value<T0>(0x2::coin::balance<T0>(&v3)))
    }

    public fun max_sqrt_price() : u128 {
        79226673515401279992447579055
    }

    public fun min_sqrt_price() : u128 {
        4295048016
    }

    public fun repay_flash_swap_a2b<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt, arg2: 0x2::coin::Coin<T0>, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, _) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&arg1);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::split<T0>(&mut arg2, v0, arg4)), 0x2::coin::into_balance<T1>(0x2::coin::zero<T1>(arg4)), arg3, arg4);
        arg2
    }

    public fun repay_flash_swap_b2a<T0, T1>(arg0: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg1: 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::FlashSwapReceipt, arg2: 0x2::coin::Coin<T1>, arg3: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (_, v1) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::swap_receipt_debts(&arg1);
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(0x2::coin::zero<T0>(arg4)), 0x2::coin::into_balance<T1>(0x2::coin::split<T1>(&mut arg2, v1, arg4)), arg3, arg4);
        arg2
    }

    public fun transfer_or_destroy_coin<T0>(arg0: 0x2::coin::Coin<T0>, arg1: &0x2::tx_context::TxContext) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, 0x2::tx_context::sender(arg1));
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

