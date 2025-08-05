module 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::deepbook {
    struct DEEPBOOK has drop {
        dummy_field: bool,
    }

    struct SponsoredDeepAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct DeepPool has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>,
    }

    public fun swap_exact_quantity<T0, T1, T2, T3>(arg0: &mut 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::Payload<T2, T3>, arg1: &mut DeepPool, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        let v2 = 0x2::balance::zero<T0>();
        let v3 = 0x2::balance::zero<T1>();
        let v4 = if (arg3) {
            0x2::balance::join<T0>(&mut v0, 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::take_next<T2, T3, T0>(arg0));
            0x2::balance::value<T0>(&v0)
        } else {
            0x2::balance::join<T1>(&mut v1, 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::take_next<T2, T3, T1>(arg0));
            0x2::balance::value<T1>(&v1)
        };
        let (_, _, v7) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg2, 0x2::balance::value<T0>(&v0), 0x2::balance::value<T1>(&v1), arg4);
        let (v8, v9) = if (0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance) >= v7) {
            (0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v7), arg5), true)
        } else {
            (0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg5), false)
        };
        if (v9) {
            let (v10, _, _) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::pool_trade_params<T0, T1>(arg2);
            if (arg3) {
                0x2::balance::join<T0>(&mut v2, 0x2::balance::split<T0>(&mut v0, v4 * v10 / 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::constant::scalar() * 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::constant::deepbook_fee_penalty_rate() / 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::constant::deepbook_fee_penalty_rate_multiplier()));
            } else {
                0x2::balance::join<T1>(&mut v3, 0x2::balance::split<T1>(&mut v1, v4 * v10 / 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::constant::scalar() * 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::constant::deepbook_fee_penalty_rate() / 0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::constant::deepbook_fee_penalty_rate_multiplier()));
            };
        };
        let (v13, v14, v15) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg2, 0x2::coin::from_balance<T0>(v0, arg5), 0x2::coin::from_balance<T1>(v1, arg5), v8, 0, arg4, arg5);
        let v16 = v15;
        let v17 = v14;
        let v18 = v13;
        if (0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v16) > 0) {
            0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v16));
        } else {
            0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v16);
        };
        if (arg3) {
            0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::place_next<T2, T3, T1>(arg0, 0x2::coin::into_balance<T1>(v17));
            if (0x2::coin::value<T0>(&v18) == 0) {
                0x2::coin::destroy_zero<T0>(v18);
            } else {
                0x2::balance::join<T0>(&mut v2, 0x2::coin::into_balance<T0>(v18));
            };
        } else {
            0x9425470f697c81f30c1b30e83202172ffffc1fcaacb75a0abcbb5a35c1a036e9::checkpoint::place_next<T2, T3, T0>(arg0, 0x2::coin::into_balance<T0>(v18));
            if (0x2::coin::value<T1>(&v17) == 0) {
                0x2::coin::destroy_zero<T1>(v17);
            } else {
                0x2::balance::join<T1>(&mut v3, 0x2::coin::into_balance<T1>(v17));
            };
        };
        (v2, v3)
    }

    public fun deposit_deep(arg0: &mut DeepPool, arg1: &SponsoredDeepAdminCap, arg2: 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>) {
        0x2::balance::join<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, 0x2::coin::into_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg2));
    }

    fun init(arg0: DEEPBOOK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = DeepPool{
            id      : 0x2::object::new(arg1),
            balance : 0x2::balance::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(),
        };
        let v1 = SponsoredDeepAdminCap{id: 0x2::object::new(arg1)};
        0x2::transfer::share_object<DeepPool>(v0);
        0x2::transfer::public_transfer<SponsoredDeepAdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    public fun withdraw_deep(arg0: &mut DeepPool, arg1: &SponsoredDeepAdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP> {
        0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg0.balance, arg2), arg3)
    }

    // decompiled from Move bytecode v6
}

