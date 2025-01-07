module 0xfece7eb0f4307bbcff60b62f3342cf00c6236e833070992ad44bc93f49e424a1::router {
    struct DeepBookRouterWrapper has store, key {
        id: 0x2::object::UID,
        account_cap: 0xdee9::custodian_v2::AccountCap,
    }

    public fun swap_exact_base_for_quote<T0, T1, T2>(arg0: &mut DeepBookRouterWrapper, arg1: &mut 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::RouterSwapCap<T0>, arg2: &mut 0xdee9::clob_v2::Pool<T1, T2>, arg3: 0x2::coin::Coin<T1>, arg4: &0x2::clock::Clock, arg5: u64, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::assert_expected_coin_in<T0, T1>(arg1, &arg3);
        let v0 = 0x2::tx_context::sender(arg6);
        transfer_if_nonzero<T1>(0x2::coin::split<T1>(&mut arg3, 0x2::coin::value<T1>(&arg3) % arg5, arg6), v0);
        let (v1, v2, _) = 0xdee9::clob_v2::swap_exact_base_for_quote<T1, T2>(arg2, 0, &arg0.account_cap, 0x2::coin::value<T1>(&arg3), arg3, 0x2::coin::zero<T2>(arg6), arg4, arg6);
        let v4 = v2;
        transfer_if_nonzero<T1>(v1, v0);
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v4));
        v4
    }

    public fun swap_exact_quote_for_base<T0, T1, T2>(arg0: &mut DeepBookRouterWrapper, arg1: &mut 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::RouterSwapCap<T0>, arg2: &mut 0xdee9::clob_v2::Pool<T1, T2>, arg3: 0x2::coin::Coin<T2>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::assert_expected_coin_in<T0, T2>(arg1, &arg3);
        let (v0, v1, _) = 0xdee9::clob_v2::swap_exact_quote_for_base<T1, T2>(arg2, 0, &arg0.account_cap, 0x2::coin::value<T2>(&arg3), arg4, arg3, arg5);
        let v3 = v0;
        transfer_if_nonzero<T2>(v1, 0x2::tx_context::sender(arg5));
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::update_path_metadata<T0, T1>(arg1, &arg0.id, 0x2::coin::value<T1>(&v3));
        v3
    }

    public fun authorize(arg0: &0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::AdminCap, arg1: &mut DeepBookRouterWrapper) {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::AdminCap, arg1: &mut DeepBookRouterWrapper) {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::deauthorize(arg0, &mut arg1.id);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepBookRouterWrapper{
            id          : 0x2::object::new(arg0),
            account_cap : 0xdee9::clob_v2::create_account(arg0),
        };
        0x2::transfer::share_object<DeepBookRouterWrapper>(v0);
    }

    fun transfer_if_nonzero<T0>(arg0: 0x2::coin::Coin<T0>, arg1: address) {
        if (0x2::coin::value<T0>(&arg0) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg0, arg1);
        } else {
            0x2::coin::destroy_zero<T0>(arg0);
        };
    }

    // decompiled from Move bytecode v6
}

