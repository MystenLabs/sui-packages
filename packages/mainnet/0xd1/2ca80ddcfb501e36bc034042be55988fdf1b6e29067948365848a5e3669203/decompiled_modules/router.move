module 0xd12ca80ddcfb501e36bc034042be55988fdf1b6e29067948365848a5e3669203::router {
    struct KriyaRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::AdminCap, arg1: &mut KriyaRouterWrapper) {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::AdminCap, arg1: &mut KriyaRouterWrapper) {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun swap_token_x<T0, T1, T2>(arg0: &mut KriyaRouterWrapper, arg1: &mut 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::RouterSwapCap<T0>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T1, T2>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::assert_expected_coin_in<T0, T1>(arg1, &arg3);
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_x<T1, T2>(arg2, arg3, 0x2::coin::value<T1>(&arg3), 0, arg4);
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    public fun swap_token_y<T0, T1, T2>(arg0: &mut KriyaRouterWrapper, arg1: &mut 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::RouterSwapCap<T0>, arg2: &mut 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::Pool<T2, T1>, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::assert_expected_coin_in<T0, T1>(arg1, &arg3);
        let v0 = 0xa0eba10b173538c8fecca1dff298e488402cc9ff374f8a12ca7758eebe830b66::spot_dex::swap_token_y<T2, T1>(arg2, arg3, 0x2::coin::value<T1>(&arg3), 0, arg4);
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KriyaRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<KriyaRouterWrapper>(v0);
    }

    // decompiled from Move bytecode v6
}

