module 0x470409f1f6d843025a1f14eec745c0802dec6921556265d3d2f7649a791a584::lending {
    public(friend) fun deposit_scallop_basic<T0>(arg0: 0x2::balance::Balance<T0>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, vector<u64>) {
        let v0 = 0x2::balance::value<T0>(&arg0);
        if (v0 == 0) {
            0x2::balance::destroy_zero<T0>(arg0);
            return (0x2::coin::zero<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg4), vector[0, 0])
        };
        let v1 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg1, arg2, 0x2::coin::from_balance<T0>(arg0, arg4), arg3, arg4);
        let v2 = 0x1::vector::empty<u64>();
        let v3 = &mut v2;
        0x1::vector::push_back<u64>(v3, v0);
        0x1::vector::push_back<u64>(v3, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v1));
        (v1, v2)
    }

    public fun withdraw_scallop_basic<T0>(arg0: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg2: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<T0>, vector<u64>) {
        let v0 = 0x2::coin::into_balance<T0>(0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg1, arg2, arg0, arg3, arg4));
        let v1 = 0x1::vector::empty<u64>();
        let v2 = &mut v1;
        0x1::vector::push_back<u64>(v2, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&arg0));
        0x1::vector::push_back<u64>(v2, 0x2::balance::value<T0>(&v0));
        (v0, v1)
    }

    // decompiled from Move bytecode v6
}

