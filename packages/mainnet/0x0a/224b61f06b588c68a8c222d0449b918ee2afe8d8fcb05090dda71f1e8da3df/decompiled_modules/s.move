module 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::s {
    public fun assert_wl(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg0) == @0x894e1fe87cade97c9a1e47e5b04b011eb0f4319367888846ac107c99372dcc11, 101);
    }

    public fun cetus_0<T0, T1>(arg0: &0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::config::GlobalConfig, arg1: &mut 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::pool::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let (v0, v1, v2) = 0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::pool::flash_swap<T0, T1>(arg0, arg1, true, true, 0x2::coin::value<T0>(&arg3), 4295048016, arg2);
        0xa224b61f06b588c68a8c222d0449b918ee2afe8d8fcb05090dda71f1e8da3df::pool::repay_flash_swap<T0, T1>(arg0, arg1, 0x2::coin::into_balance<T0>(arg3), 0x2::balance::zero<T1>(), v2);
        0x2::balance::destroy_zero<T0>(v0);
        0x2::coin::from_balance<T1>(v1, arg4)
    }

    // decompiled from Move bytecode v6
}

