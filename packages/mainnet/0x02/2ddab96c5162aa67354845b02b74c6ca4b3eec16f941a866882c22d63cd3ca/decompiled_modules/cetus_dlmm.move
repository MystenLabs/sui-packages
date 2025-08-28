module 0x22ddab96c5162aa67354845b02b74c6ca4b3eec16f941a866882c22d63cd3ca::cetus_dlmm {
    public fun swap<T0, T1>(arg0: &mut 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::SwapContext, arg1: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg2: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg3: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg4: bool, arg5: u64, arg6: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &mut 0x2::tx_context::TxContext) {
        if (arg4) {
            swap_a2b<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        } else {
            swap_b2a<T0, T1>(arg0, arg1, arg2, arg3, arg5, arg6, arg7, arg8);
        };
    }

    fun flash_swap<T0, T1>(arg0: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg1: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg2: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg3: u64, arg4: bool, arg5: bool, arg6: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg7: &0x2::clock::Clock, arg8: &0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2) = if (0x2::object::id_address<0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner>(arg2) == @0x639b5e433da31739e800cd085f356e64cae222966d0f1b11bd9dc76b322ff58b) {
            0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::flash_swap<T0, T1>(arg1, arg4, arg5, arg3, arg0, arg6, arg7, arg8)
        } else {
            0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::flash_swap_with_partner<T0, T1>(arg1, arg2, arg4, arg5, arg3, arg0, arg6, arg7, arg8)
        };
        let v3 = v2;
        (v0, v1, v3, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::pay_amount<T0, T1>(&v3))
    }

    public fun flash_swap_fixed_output<T0, T1>(arg0: &mut 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::SwapContext, arg1: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg2: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg3: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg4: u64, arg5: bool, arg6: bool, arg7: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg8: &0x2::clock::Clock, arg9: &0x2::tx_context::TxContext) : (0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::FlashSwapReceipt<T0, T1>, u64) {
        let (v0, v1, v2, v3) = flash_swap<T0, T1>(arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9);
        let v4 = v1;
        let v5 = v0;
        if (0x2::balance::value<T0>(&v5) > 0) {
            0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T0>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T1>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::emit_swap_event<T0, T1>(arg0, b"CETUSDLMM", 0x2::object::id<0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>>(arg2), v3, arg4, 0, arg5);
        (v2, v3)
    }

    fun repay_flash_swap<T0, T1>(arg0: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg1: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg2: bool, arg3: 0x2::balance::Balance<T0>, arg4: 0x2::balance::Balance<T1>, arg5: 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::FlashSwapReceipt<T0, T1>, arg6: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let (v0, v1) = if (arg2) {
            (0x2::balance::split<T0>(&mut arg3, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::pay_amount<T0, T1>(&arg5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0x2::balance::split<T1>(&mut arg4, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::pay_amount<T0, T1>(&arg5)))
        };
        if (0x2::object::id_address<0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner>(arg1) == @0x639b5e433da31739e800cd085f356e64cae222966d0f1b11bd9dc76b322ff58b) {
            0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::repay_flash_swap<T0, T1>(arg0, v0, v1, arg5, arg6);
        } else {
            0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::repay_flash_swap_with_partner<T0, T1>(arg0, arg1, v0, v1, arg5, arg6);
        };
        (arg3, arg4)
    }

    public fun repay_flash_swap_fixed_output<T0, T1>(arg0: &mut 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::SwapContext, arg1: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg2: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg3: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg4: bool, arg5: 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::FlashSwapReceipt<T0, T1>, arg6: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned) {
        let (v0, v1) = if (arg4) {
            (0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::take_balance<T0>(arg0, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::pay_amount<T0, T1>(&arg5)), 0x2::balance::zero<T1>())
        } else {
            (0x2::balance::zero<T0>(), 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::take_balance<T1>(arg0, 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::pay_amount<T0, T1>(&arg5)))
        };
        let (v2, v3) = repay_flash_swap<T0, T1>(arg2, arg3, arg4, v0, v1, arg5, arg6);
        let v4 = v3;
        let v5 = v2;
        if (0x2::balance::value<T0>(&v5) > 0) {
            0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T0>(arg0, v5);
        } else {
            0x2::balance::destroy_zero<T0>(v5);
        };
        if (0x2::balance::value<T1>(&v4) > 0) {
            0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T1>(arg0, v4);
        } else {
            0x2::balance::destroy_zero<T1>(v4);
        };
    }

    fun swap_a2b<T0, T1>(arg0: &mut 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::SwapContext, arg1: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg2: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg3: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg4: u64, arg5: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::take_balance<T0>(arg0, arg4);
        let v1 = 0x2::balance::value<T0>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T0>(v0);
            return
        };
        let (v2, v3, v4, _) = flash_swap<T0, T1>(arg1, arg2, arg3, v1, true, true, arg5, arg6, arg7);
        let v6 = v3;
        let (v7, v8) = repay_flash_swap<T0, T1>(arg2, arg3, true, v0, 0x2::balance::zero<T1>(), v4, arg5);
        let v9 = v7;
        0x2::balance::destroy_zero<T0>(v2);
        0x2::balance::destroy_zero<T1>(v8);
        let v10 = 0x2::balance::value<T0>(&v9);
        if (arg4 == 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::max_amount_in()) {
            0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::transfer_balance<T0>(v9, 0x2::tx_context::sender(arg7), arg7);
        } else {
            0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T0>(arg0, v9);
        };
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T1>(arg0, v6);
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::emit_swap_event<T0, T1>(arg0, b"CETUSDLMM", 0x2::object::id<0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>>(arg2), v1 - v10, 0x2::balance::value<T1>(&v6), v10, true);
    }

    fun swap_b2a<T0, T1>(arg0: &mut 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::SwapContext, arg1: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::config::GlobalConfig, arg2: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>, arg3: &mut 0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::partner::Partner, arg4: u64, arg5: &0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::versioned::Versioned, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::take_balance<T1>(arg0, arg4);
        let v1 = 0x2::balance::value<T1>(&v0);
        if (v1 == 0) {
            0x2::balance::destroy_zero<T1>(v0);
            return
        };
        let (v2, v3, v4, _) = flash_swap<T0, T1>(arg1, arg2, arg3, v1, false, true, arg5, arg6, arg7);
        let v6 = v2;
        let (v7, v8) = repay_flash_swap<T0, T1>(arg2, arg3, false, 0x2::balance::zero<T0>(), v0, v4, arg5);
        let v9 = v8;
        0x2::balance::destroy_zero<T1>(v3);
        0x2::balance::destroy_zero<T0>(v7);
        let v10 = 0x2::balance::value<T1>(&v9);
        if (arg4 == 0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::max_amount_in()) {
            0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::transfer_balance<T1>(v9, 0x2::tx_context::sender(arg7), arg7);
        } else {
            0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T1>(arg0, v9);
        };
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::merge_balance<T0>(arg0, v6);
        0xae41fcff4fda4039af043b8b73f5cb092d12f6c065fd3d3a29496a3c8b6e02cb::router::emit_swap_event<T0, T1>(arg0, b"CETUSDLMM", 0x2::object::id<0x82f60caeceab94d35f00a4de11ef0941577e9e62558d7ce236ef8a62a145e494::pool::Pool<T0, T1>>(arg2), v1 - v10, 0x2::balance::value<T0>(&v6), v10, false);
    }

    // decompiled from Move bytecode v6
}

