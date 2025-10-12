module 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::momentum {
    struct FlashSwapLog has copy, drop, store {
        amt_specified: u64,
        rem_value: u64,
        out_value: u64,
        amount_x_debt: u64,
        amount_y_debt: u64,
    }

    public(friend) fun log_flash(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = FlashSwapLog{
            amt_specified : arg0,
            rem_value     : arg1,
            out_value     : arg2,
            amount_x_debt : arg3,
            amount_y_debt : arg4,
        };
        0x2::event::emit<FlashSwapLog>(v0);
    }

    public(friend) fun ma<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun mb<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: u64, arg2: u128, arg3: &0x2::clock::Clock, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg1, arg2, arg3, arg4, arg5)
    }

    public(friend) fun repay_f_s<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg2: 0x2::balance::Balance<T0>, arg3: 0x2::balance::Balance<T1>, arg4: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg5: &0x2::tx_context::TxContext) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, arg1, arg2, arg3, arg4, arg5);
    }

    public fun test_ma<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T0>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, arg2, arg3, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T0>(&v5);
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::send_coin<T1>(0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::coin_from_balance<T1>(v4, arg6), 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::admin::get_address());
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        log_flash(arg2, v6, 0x2::balance::value<T1>(&v4), v7, v8);
        repay_f_s<T0, T1>(arg0, v3, 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::coin_to_balance<T0>(0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::join<T0>(0x2::coin::split<T0>(arg1, arg2 - v6, arg6), 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::coin_from_balance<T0>(v5, arg6))), 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::zero_balance<T1>(), arg5, arg6);
    }

    public fun test_mb<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: &mut 0x2::coin::Coin<T1>, arg2: u64, arg3: u128, arg4: &0x2::clock::Clock, arg5: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, arg2, arg3, arg4, arg5, arg6);
        let v3 = v2;
        let v4 = v1;
        let v5 = v0;
        let v6 = 0x2::balance::value<T1>(&v4);
        0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::send_coin<T0>(0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::coin_from_balance<T0>(v5, arg6), 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::admin::get_address());
        let (v7, v8) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(&v3);
        log_flash(arg2, v6, 0x2::balance::value<T0>(&v5), v7, v8);
        repay_f_s<T0, T1>(arg0, v3, 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::zero_balance<T0>(), 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::coin_to_balance<T1>(0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::join<T1>(0x2::coin::split<T1>(arg1, arg2 - v6, arg6), 0xef432faf1624617ac313e5c64c21ce8eb964126bf05fac3e68e8ac4ce0f9325b::tools::coin_from_balance<T1>(v4, arg6))), arg5, arg6);
    }

    // decompiled from Move bytecode v6
}

