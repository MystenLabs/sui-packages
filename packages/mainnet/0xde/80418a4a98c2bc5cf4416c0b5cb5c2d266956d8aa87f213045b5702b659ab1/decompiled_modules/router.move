module 0xde80418a4a98c2bc5cf4416c0b5cb5c2d266956d8aa87f213045b5702b659ab1::router {
    struct FlowXFinanceRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::AdminCap, arg1: &mut FlowXFinanceRouterWrapper) {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::AdminCap, arg1: &mut FlowXFinanceRouterWrapper) {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun swap_exact_input_direct<T0, T1, T2>(arg0: &mut FlowXFinanceRouterWrapper, arg1: &mut 0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::RouterSwapCap<T0>, arg2: &mut 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::factory::Container, arg3: 0x2::coin::Coin<T1>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T2> {
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::assert_expected_coin_in<T0, T1>(arg1, &arg3);
        let v0 = 0xba153169476e8c3114962261d1edc70de5ad9781b83cc617ecc8c1923191cae0::router::swap_exact_input_direct<T1, T2>(arg2, arg3, arg4);
        0x4db1f2d02629942e3686fa809cccbf75f5593a6f670ecc54720e22220b701e3c::router::update_path_metadata<T0, T2>(arg1, &arg0.id, 0x2::coin::value<T2>(&v0));
        v0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = FlowXFinanceRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<FlowXFinanceRouterWrapper>(v0);
    }

    // decompiled from Move bytecode v6
}

