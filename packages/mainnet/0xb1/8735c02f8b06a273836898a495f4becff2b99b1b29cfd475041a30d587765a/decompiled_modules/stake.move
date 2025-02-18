module 0xb18735c02f8b06a273836898a495f4becff2b99b1b29cfd475041a30d587765a::stake {
    struct NaviRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::AdminCap, arg1: &mut NaviRouterWrapper) {
        0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::AdminCap, arg1: &mut NaviRouterWrapper) {
        0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun deposit<T0>(arg0: &mut NaviRouterWrapper, arg1: &mut 0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::router::RouterSwapCap<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::Incentive, arg10: &mut 0x2::tx_context::TxContext) {
        0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::router::update_path_metadata<T0>(b"navi-lending", arg1, &arg0.id, 0x2::coin::value<T0>(&arg6));
        0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive_v2::entry_deposit<T0>(arg2, arg3, arg4, arg5, arg6, arg7, arg8, arg9, arg10);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<NaviRouterWrapper>(v0);
    }

    // decompiled from Move bytecode v6
}

