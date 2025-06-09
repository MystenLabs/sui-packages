module 0x371469494a2d299abf04d5b982cbbe70960f9ae9f1fb5f58a8acc7fe89fd229::coin_helpers {
    public fun combine_coins(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, arg1);
        arg0
    }

    public fun split_coin_equally(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, 0x2::coin::value<0x2::sui::SUI>(&arg0) / 2, arg1))
    }

    // decompiled from Move bytecode v6
}

