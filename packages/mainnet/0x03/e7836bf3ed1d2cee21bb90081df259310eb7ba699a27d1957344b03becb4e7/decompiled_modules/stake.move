module 0x3e7836bf3ed1d2cee21bb90081df259310eb7ba699a27d1957344b03becb4e7::stake {
    struct NaviRouterWrapper has store, key {
        id: 0x2::object::UID,
    }

    public fun authorize(arg0: &0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::AdminCap, arg1: &mut NaviRouterWrapper) {
        0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::authorize(arg0, &mut arg1.id);
    }

    public fun deauthorize(arg0: &0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::AdminCap, arg1: &mut NaviRouterWrapper) {
        0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::admin::deauthorize(arg0, &mut arg1.id);
    }

    public fun deposit<T0>(arg0: &mut NaviRouterWrapper, arg1: &mut 0x3006e6a6435e6ec339d4aaf603d3547097efc00c00ee06ea195deba1b9ba7a78::router::RouterSwapCap<T0>, arg2: &0x2::clock::Clock, arg3: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::storage::Storage, arg4: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::pool::Pool<T0>, arg5: u8, arg6: 0x2::coin::Coin<T0>, arg7: u64, arg8: &mut 0xd899cf7d2b5db716bd2cf55599fb0d5ee38a3061e7b6bb6eebf73fa5bc4c81ca::incentive::Incentive, arg9: &mut 0x2::tx_context::TxContext) {
        abort 0
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NaviRouterWrapper{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<NaviRouterWrapper>(v0);
    }

    // decompiled from Move bytecode v6
}

