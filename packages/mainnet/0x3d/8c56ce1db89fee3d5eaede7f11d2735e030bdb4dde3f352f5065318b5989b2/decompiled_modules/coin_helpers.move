module 0x3d8c56ce1db89fee3d5eaede7f11d2735e030bdb4dde3f352f5065318b5989b2::coin_helpers {
    public fun combine_coins(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, arg1);
        arg0
    }

    public fun split_coin_equally(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, 0x2::coin::value<0x2::sui::SUI>(&arg0) / 2, arg1))
    }

    // decompiled from Move bytecode v6
}

