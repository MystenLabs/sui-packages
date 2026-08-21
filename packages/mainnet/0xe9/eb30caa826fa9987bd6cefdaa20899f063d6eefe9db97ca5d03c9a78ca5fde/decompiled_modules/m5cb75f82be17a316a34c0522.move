module 0xe9eb30caa826fa9987bd6cefdaa20899f063d6eefe9db97ca5d03c9a78ca5fde::m5cb75f82be17a316a34c0522 {
    public fun f44a8049c4bdf521838681355<T0, T1>(arg0: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>> {
        0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

