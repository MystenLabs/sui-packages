module 0x40f3edb961114370e211ad67932680d1e7938c346423d079cee268a54ce01054::deepbook_adapter {
    struct Deepbook has drop {
        dummy_field: bool,
    }

    fun resolve<T0, T1>(arg0: &mut 0x50d13ebf6d73ad69ef5c15990e5aa3442ccefa30cde9c48c9bffdba6029926b8::dca::Request<T1>, arg1: 0x2::coin::Coin<T0>, arg2: 0x2::coin::Coin<T1>) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(arg1, 0x50d13ebf6d73ad69ef5c15990e5aa3442ccefa30cde9c48c9bffdba6029926b8::dca::request_owner<T1>(arg0));
        let v0 = Deepbook{dummy_field: false};
        0x50d13ebf6d73ad69ef5c15990e5aa3442ccefa30cde9c48c9bffdba6029926b8::dca::add<Deepbook, T1>(arg0, v0, arg2);
    }

    public fun swap_base<T0, T1>(arg0: &mut 0x50d13ebf6d73ad69ef5c15990e5aa3442ccefa30cde9c48c9bffdba6029926b8::dca::Request<T1>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xdee9::custodian_v2::AccountCap, arg4: u64, arg5: 0x2::coin::Coin<T0>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, arg3, arg4, 0x2::coin::value<T0>(&arg5), false, arg5, 0x2::coin::zero<T1>(arg6), arg2, arg6);
        resolve<T0, T1>(arg0, v0, v1);
    }

    public fun swap_quote<T0, T1>(arg0: &mut 0x50d13ebf6d73ad69ef5c15990e5aa3442ccefa30cde9c48c9bffdba6029926b8::dca::Request<T0>, arg1: &mut 0xdee9::clob_v2::Pool<T0, T1>, arg2: &0x2::clock::Clock, arg3: &0xdee9::custodian_v2::AccountCap, arg4: u64, arg5: 0x2::coin::Coin<T1>, arg6: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0xdee9::clob_v2::place_market_order<T0, T1>(arg1, arg3, arg4, 0x2::coin::value<T1>(&arg5), true, 0x2::coin::zero<T0>(arg6), arg5, arg2, arg6);
        resolve<T1, T0>(arg0, v1, v0);
    }

    // decompiled from Move bytecode v6
}

