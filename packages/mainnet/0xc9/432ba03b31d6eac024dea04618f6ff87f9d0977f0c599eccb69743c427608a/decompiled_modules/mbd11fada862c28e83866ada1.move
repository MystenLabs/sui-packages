module 0xc9432ba03b31d6eac024dea04618f6ff87f9d0977f0c599eccb69743c427608a::mbd11fada862c28e83866ada1 {
    public fun f16b2d9541ffe2263c6a35379<T0, T1>(arg0: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::mint_s_coin<T0, T1>(arg0, arg1, arg2)
    }

    public fun f7ce961a4f47714aa028d8dd0<T0, T1>(arg0: &mut 0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::SCoinTreasury<T0, T1>, arg1: 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xefe8b36d5b2e43728cc323298626b83177803521d195cfb11e15b910e892fddf::reserve::MarketCoin<T1>> {
        0x80ca577876dec91ae6d22090e56c39bc60dce9086ab0729930c6900bc4162b4c::s_coin_converter::burn_s_coin<T0, T1>(arg0, arg1, arg2)
    }

    // decompiled from Move bytecode v7
}

