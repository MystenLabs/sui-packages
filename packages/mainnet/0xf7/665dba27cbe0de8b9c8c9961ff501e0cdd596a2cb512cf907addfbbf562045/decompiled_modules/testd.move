module 0xf7665dba27cbe0de8b9c8c9961ff501e0cdd596a2cb512cf907addfbbf562045::testd {
    struct DeepBookRouterWrapper has store, key {
        id: 0x2::object::UID,
        account_cap: 0xdee9::custodian_v2::AccountCap,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepBookRouterWrapper{
            id          : 0x2::object::new(arg0),
            account_cap : 0xdee9::clob_v2::create_account(arg0),
        };
        0x2::transfer::share_object<DeepBookRouterWrapper>(v0);
    }

    public fun swap_exact_base_for_quote<T0, T1>(arg0: &mut DeepBookRouterWrapper, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T0>, arg3: &0x2::clock::Clock, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T1> {
        let v0 = 0x2::tx_context::sender(arg5);
        transfer_if_nonzero<T0>(0x2::coin::split<T0>(&mut arg2, 0x2::coin::value<T0>(&arg2) % arg4, arg5), v0);
        let (v1, v2) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, &arg0.account_cap, 0, 0x2::coin::value<T0>(&arg2), true, arg2, 0x2::coin::zero<T1>(arg5), arg3, arg5);
        transfer_if_nonzero<T0>(v1, v0);
        v2
    }

    public fun swap_exact_quote_for_base<T0, T1>(arg0: &mut DeepBookRouterWrapper, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: 0x2::coin::Coin<T1>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, &arg0.account_cap, 0, 0x2::coin::value<T1>(&arg2), false, 0x2::coin::zero<T0>(arg4), arg2, arg3, arg4);
        transfer_if_nonzero<T1>(v1, 0x2::tx_context::sender(arg4));
        v0
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

