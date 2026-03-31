module 0xe132918b43c18a351998d9033b07abb4f5c7cb249f07e47004cb8643a2b4357e::scallop_bridge {
    public fun deposit_to_scallop<T0>(arg0: &mut 0xc928e72571d9f0305f7efa4d9b88d833eca185321bd3818b9e47442b0a3f90ea::market::Market, arg1: &0xc928e72571d9f0305f7efa4d9b88d833eca185321bd3818b9e47442b0a3f90ea::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<T0>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0xc928e72571d9f0305f7efa4d9b88d833eca185321bd3818b9e47442b0a3f90ea::reserve::MarketCoin<T0>> {
        0xc928e72571d9f0305f7efa4d9b88d833eca185321bd3818b9e47442b0a3f90ea::mint::mint<T0>(arg1, arg0, arg3, arg2, arg4)
    }

    public fun withdraw_from_scallop<T0>(arg0: &mut 0xc928e72571d9f0305f7efa4d9b88d833eca185321bd3818b9e47442b0a3f90ea::market::Market, arg1: &0xc928e72571d9f0305f7efa4d9b88d833eca185321bd3818b9e47442b0a3f90ea::version::Version, arg2: &0x2::clock::Clock, arg3: 0x2::coin::Coin<0xc928e72571d9f0305f7efa4d9b88d833eca185321bd3818b9e47442b0a3f90ea::reserve::MarketCoin<T0>>, arg4: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<T0> {
        0xc928e72571d9f0305f7efa4d9b88d833eca185321bd3818b9e47442b0a3f90ea::redeem::redeem<T0>(arg1, arg0, arg3, arg2, arg4)
    }

    // decompiled from Move bytecode v6
}

