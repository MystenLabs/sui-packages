module 0xbb6743b0b1852922613d3950e42eb95a0281736faeb15217beb6b0f9b75e69b2::scallop {
    public fun deposit<T0>(arg0: &mut 0xbb6743b0b1852922613d3950e42eb95a0281736faeb15217beb6b0f9b75e69b2::fund::Take_1_Liquidity_For_1_Liquidity_Request<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg1: 0x2::coin::Coin<T0>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::mint::mint<T0>(arg2, arg3, arg1, arg4, arg5);
        0xbb6743b0b1852922613d3950e42eb95a0281736faeb15217beb6b0f9b75e69b2::fund::supported_defi_confirm_1l_for_1l<T0, 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(arg0, 0x2::coin::value<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>(&v0));
        v0
    }

    public fun withdraw<T0>(arg0: &mut 0xbb6743b0b1852922613d3950e42eb95a0281736faeb15217beb6b0f9b75e69b2::fund::Take_1_Liquidity_For_1_Liquidity_Request<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>>, arg2: &0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::version::Version, arg3: &mut 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::market::Market, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        let v0 = 0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::redeem::redeem<T0>(arg2, arg3, arg1, arg4, arg5);
        0xbb6743b0b1852922613d3950e42eb95a0281736faeb15217beb6b0f9b75e69b2::fund::supported_defi_confirm_1l_for_1l<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T0>, T0>(arg0, 0x2::coin::value<T0>(&v0));
        v0
    }

    // decompiled from Move bytecode v6
}

