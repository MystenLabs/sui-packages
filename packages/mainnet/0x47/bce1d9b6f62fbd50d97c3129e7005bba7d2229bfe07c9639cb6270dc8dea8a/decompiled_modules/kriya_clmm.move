module 0x47bce1d9b6f62fbd50d97c3129e7005bba7d2229bfe07c9639cb6270dc8dea8a::kriya_clmm {
    public fun swap<T0, T1>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        if (arg3) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg4, arg5, arg6);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::take_balance<T0>(arg0, arg3);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, true, true, arg3, 4295048016, arg4, arg2, arg5);
        let v4 = v2;
        let v5 = v1;
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T1>(arg0, v4);
        let v6 = 0x2::balance::value<T0>(&v5);
        if (arg3 == 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::max_amount_in()) {
            0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::transfer_balance<T0>(v5, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T0>(arg0, v5);
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v3, v0, 0x2::balance::zero<T1>(), arg2, arg5);
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::emit_swap_event<T0, T1>(arg0, b"KRIYA_CLMM", 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1), 0x2::balance::value<T0>(&v0) - v6, 0x2::balance::value<T1>(&v4), v6, true);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::SwapContext, arg1: &mut 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>, arg2: &0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::version::Version, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::take_balance<T1>(arg0, arg3);
        let (v1, v2, v3) = 0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::flash_swap<T0, T1>(arg1, false, true, arg3, 79226673515401279992447579055, arg4, arg2, arg5);
        let v4 = v2;
        let v5 = v1;
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T0>(arg0, v5);
        let v6 = 0x2::balance::value<T1>(&v4);
        if (arg3 == 0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::max_amount_in()) {
            0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::transfer_balance<T1>(v4, 0x2::tx_context::sender(arg5), arg5);
        } else {
            0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::merge_balance<T1>(arg0, v4);
        };
        0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::trade::repay_flash_swap<T0, T1>(arg1, v3, 0x2::balance::zero<T0>(), v0, arg2, arg5);
        0x55317429b88dccaeaba11c5c528d74ce07f3dadf6068727a2a315ac2c104edd2::router::emit_swap_event<T0, T1>(arg0, b"KRIYA_CLMM", 0x2::object::id<0xf6c05e2d9301e6e91dc6ab6c3ca918f7d55896e1f1edd64adc0e615cde27ebf1::pool::Pool<T0, T1>>(arg1), 0x2::balance::value<T1>(&v0) - v6, 0x2::balance::value<T0>(&v5), v6, false);
    }

    // decompiled from Move bytecode v6
}

