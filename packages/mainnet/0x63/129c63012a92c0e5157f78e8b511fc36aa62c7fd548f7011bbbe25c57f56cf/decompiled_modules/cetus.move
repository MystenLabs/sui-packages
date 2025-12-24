module 0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::cetus {
    public fun confirm_swap<T0>(arg0: &mut 0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::Config, arg1: 0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::SwapRequest, arg2: 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::checked_package_version(arg0);
        0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::checked_pause(arg0);
        let (v0, v1, v2, v3, v4, v5) = 0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::destroy_swap_request(arg1);
        assert!(v2 == 0x1::type_name::get<T0>(), 3);
        let (v6, v7) = 0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::deduct_fee<T0>(arg0, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::confirm_swap<T0>(arg2, arg3), arg3);
        let v8 = v6;
        assert!(0x2::coin::value<T0>(&v8) >= v4, 2);
        0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::emit_confirm_swap_event(v0, v1, v2, v3, 0x2::coin::value<T0>(&v8), v4, v7, v5);
        v8
    }

    public fun start_swap<T0, T1>(arg0: &0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::Config, arg1: 0x1::string::String, arg2: u64, arg3: u64, arg4: 0x2::coin::Coin<T0>, arg5: &mut 0x2::tx_context::TxContext) : (0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::SwapRequest, 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::SwapContext) {
        0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::checked_package_version(arg0);
        0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::checked_pause(arg0);
        let v0 = 0x2::coin::value<T0>(&arg4);
        assert!(v0 > 0, 1);
        (0x63129c63012a92c0e5157f78e8b511fc36aa62c7fd548f7011bbbe25c57f56cf::config::new_wrap_context(0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), v0, arg2, b"CETUS", arg5), 0x33ec64e9bb369bf045ddc198c81adbf2acab424da37465d95296ee02045d2b17::router::new_swap_context<T0, T1>(arg1, arg2, arg3, arg4, 0, @0x0, arg5))
    }

    // decompiled from Move bytecode v6
}

