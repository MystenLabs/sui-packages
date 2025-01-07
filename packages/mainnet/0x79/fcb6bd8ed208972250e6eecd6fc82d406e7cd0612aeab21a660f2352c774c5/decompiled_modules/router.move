module 0x79fcb6bd8ed208972250e6eecd6fc82d406e7cd0612aeab21a660f2352c774c5::router {
    struct BlueMoveRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::AdminCap, arg1: &mut BlueMoveRouterWrapper) {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::AdminCap, arg1: &mut BlueMoveRouterWrapper) {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = BlueMoveRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<BlueMoveRouterWrapper>(v0);
    }

    public fun swap_exact_input<T0, T1, T2>(arg0: &mut BlueMoveRouterWrapper, arg1: &mut 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::swap::Dex_Info, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::assert_expected_coin_in<T0, T1>(arg1, &arg2);
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::router::swap_exact_input_<T1, T2>(0x2::coin::value<T1>(&arg2), arg2, 0, arg3, arg4);
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun swap_exact_input_stable<T0, T1, T2>(arg0: &mut BlueMoveRouterWrapper, arg1: &mut 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::RouterSwapCap<T0>, arg2: 0x2::coin::Coin<T1>, arg3: &mut 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_swap::Dex_Stable_Info, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::assert_expected_coin_in<T0, T1>(arg1, &arg2);
        let v0 = 0xb24b6789e088b876afabca733bed2299fbc9e2d6369be4d1acfa17d8145454d9::stable_router::swap_exact_input_<T1, T2>(arg2, 0x2::coin::value<T1>(&arg2), 0, arg3, arg4, arg5);
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

