module 0xf5598f801918e7deaface53e5294129c0a477b93fc620f68b970e598d4c0e61a::coin_helpers {
    public fun combine_coins(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, arg1);
        arg0
    }

    public fun split_coin_equally(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, 0x2::coin::value<0x2::sui::SUI>(&arg0) / 2, arg1))
    }

    // decompiled from Move bytecode v6
}

