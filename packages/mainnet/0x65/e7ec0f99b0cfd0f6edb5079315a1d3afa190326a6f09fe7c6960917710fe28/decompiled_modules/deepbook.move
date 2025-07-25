module 0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::deepbook {
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

    public fun swap_exact_quantity<T0, T1, T2, T3>(arg0: &mut 0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::checkpoint::Payload<T2, T3>, arg1: &mut DeepPool, arg2: &mut 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::Pool<T0, T1>, arg3: bool, arg4: u64, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, 0x2::balance::Balance<T1>) {
        assert!(arg4 <= 0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::constant::deepbook_max_taker_fee(), 0);
        let v0 = 0x2::balance::zero<T0>();
        let v1 = 0x2::balance::zero<T1>();
        let v2 = if (arg3) {
            0x2::balance::join<T0>(&mut v0, 0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::checkpoint::take_next<T2, T3, T0>(arg0));
            0x2::balance::value<T0>(&v0)
        } else {
            0x2::balance::join<T1>(&mut v1, 0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::checkpoint::take_next<T2, T3, T1>(arg0));
            0x2::balance::value<T1>(&v1)
        };
        let (_, _, v5) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::get_quantity_out<T0, T1>(arg2, 0x2::balance::value<T0>(&v0), 0x2::balance::value<T1>(&v1), arg5);
        let (v6, v7) = if (0x2::balance::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&arg1.balance) >= v5) {
            (0x2::coin::from_balance<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(0x2::balance::split<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&mut arg1.balance, v5), arg6), true)
        } else {
            (0x2::coin::zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(arg6), false)
        };
        let v8 = 0x2::balance::zero<T0>();
        let v9 = 0x2::balance::zero<T1>();
        if (!v7) {
            if (arg3) {
                0x2::balance::join<T0>(&mut v8, 0x2::balance::split<T0>(&mut v0, v2 * arg4 * 0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::constant::deepbook_fee_penalty() / 1000000));
            } else {
                0x2::balance::join<T1>(&mut v9, 0x2::balance::split<T1>(&mut v1, v2 * arg4 * 0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::constant::deepbook_fee_penalty() / 1000000));
            };
        };
        let (v10, v11, v12) = 0x2c8d603bc51326b8c13cef9dd07031a408a48dddb541963357661df5d3204809::pool::swap_exact_quantity<T0, T1>(arg2, 0x2::coin::from_balance<T0>(v0, arg6), 0x2::coin::from_balance<T1>(v1, arg6), v6, 0, arg5, arg6);
        let v13 = v12;
        let v14 = v11;
        let v15 = v10;
        assert!(0x2::coin::value<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(&v13) == 0, 0);
        0x2::coin::destroy_zero<0xdeeb7a4662eec9f2f3def03fb937a663dddaa2e215b8078a284d026b7946c270::deep::DEEP>(v13);
        if (arg3) {
            0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::checkpoint::place_next<T2, T3, T1>(arg0, 0x2::coin::into_balance<T1>(v14));
            if (0x2::coin::value<T0>(&v15) == 0) {
                0x2::coin::destroy_zero<T0>(v15);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(v15, 0x2::tx_context::sender(arg6));
            };
        } else {
            0x65e7ec0f99b0cfd0f6edb5079315a1d3afa190326a6f09fe7c6960917710fe28::checkpoint::place_next<T2, T3, T0>(arg0, 0x2::coin::into_balance<T0>(v15));
            if (0x2::coin::value<T1>(&v14) == 0) {
                0x2::coin::destroy_zero<T1>(v14);
            } else {
                0x2::transfer::public_transfer<0x2::coin::Coin<T1>>(v14, 0x2::tx_context::sender(arg6));
            };
        };
        (v8, v9)
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

