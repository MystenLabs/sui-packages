module 0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::scallop_bridge {
    public fun deposit_to_scallop<T0>(arg0: &mut 0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::market::Market, arg1: &0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::reserve::MarketCoin<T0>> {
        0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::mint::mint<T0>(arg1, arg0, arg3, arg2, arg4)
    }

    public fun withdraw_from_scallop<T0>(arg0: &mut 0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::market::Market, arg1: &0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::reserve::MarketCoin<T0>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x11e37a2ed5e2210d33d1b75400bca353172d61f0dfb23036e6d932d5bbc8a6f9::redeem::redeem<T0>(arg1, arg0, arg3, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

