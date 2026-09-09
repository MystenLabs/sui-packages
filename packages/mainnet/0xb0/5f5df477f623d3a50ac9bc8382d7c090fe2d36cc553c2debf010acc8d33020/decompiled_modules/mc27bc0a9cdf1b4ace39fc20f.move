module 0xb05f5df477f623d3a50ac9bc8382d7c090fe2d36cc553c2debf010acc8d33020::mc27bc0a9cdf1b4ace39fc20f {
    public fun f658e0894cc1ac35c1058e263<T0, T1>(arg0: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T0, T1>(arg0, arg1, arg2)
    }

    public fun fc7b36ab2926d234be434eb8a<T0, T1>(arg0: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>> {
        0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

