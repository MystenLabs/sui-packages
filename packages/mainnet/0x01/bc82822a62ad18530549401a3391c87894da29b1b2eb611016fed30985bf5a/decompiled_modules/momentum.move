module 0x1bc82822a62ad18530549401a3391c87894da29b1b2eb611016fed30985bf5a::momentum {
    public fun flash_x2y<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T1>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, true, true, 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::principal(arg0), 4295048016, arg3, arg2, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        (v1, v2)
    }

    public fun flash_y2x<T0, T1>(arg0: &0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg1, false, true, 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::principal(arg0), 79226673515401279992447579055, arg3, arg2, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        (v0, v2)
    }

    public fun owed_x2y(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) : u64 {
        let (v0, _) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(arg0);
        v0
    }

    public fun owed_y2x(arg0: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt) : u64 {
        let (_, v1) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::swap_receipt_debts(arg0);
        v1
    }

    fun quote<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u8, arg3: bool, arg4: u128) {
        if (!0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::quoting(arg0)) {
            return
        };
        let v0 = 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::quote_input(arg0, arg2);
        let v1 = 0;
        if (v0 > 0) {
            let v2 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::compute_swap_result<T0, T1>(arg1, arg3, true, arg4, v0);
            v1 = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::get_state_amount_calculated(&v2);
        };
        0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::record_quote(arg0, v1);
    }

    public fun quote_x2y<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u8) {
        quote<T0, T1>(arg0, arg1, arg2, true, 4295048016);
    }

    public fun quote_y2x<T0, T1>(arg0: &mut 0xabb5100d490fd94c95c6e71e284a49c1de2fc3003702df216a8902a112b3bc7c::session::Session, arg1: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg2: u8) {
        quote<T0, T1>(arg0, arg1, arg2, false, 79226673515401279992447579055);
    }

    public fun repay_x2y<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, arg2, arg1, 0x2::balance::zero<T1>(), arg3, arg4);
    }

    public fun repay_y2x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::FlashSwapReceipt, arg3: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg4: &0x2::tx_context::TxContext) {
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, arg2, 0x2::balance::zero<T0>(), arg1, arg3, arg4);
    }

    public fun swap_x2y<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T0>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T1> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, true, true, 0x2::balance::value<T0>(&arg1), 4295048016, arg3, arg2, arg4);
        0x2::balance::destroy_zero<T0>(v0);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, arg1, 0x2::balance::zero<T1>(), arg2, arg4);
        v1
    }

    public fun swap_y2x<T0, T1>(arg0: &mut 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::pool::Pool<T0, T1>, arg1: 0x2::balance::Balance<T1>, arg2: &0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::version::Version, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) : 0x2::balance::Balance<T0> {
        let (v0, v1, v2) = 0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::flash_swap<T0, T1>(arg0, false, true, 0x2::balance::value<T1>(&arg1), 79226673515401279992447579055, arg3, arg2, arg4);
        0x2::balance::destroy_zero<T1>(v1);
        0x70285592c97965e811e0c6f98dccc3a9c2b4ad854b3594faab9597ada267b860::trade::repay_flash_swap<T0, T1>(arg0, v2, 0x2::balance::zero<T0>(), arg1, arg2, arg4);
        v0
    }

    // decompiled from Move bytecode v7
}

