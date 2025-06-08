module 0x7b95ea2c40846b614f9ddc4f27d26a4410efc9c2d048a7b8acd6cf885bb0708c::coin_helpers {
    public fun combine_coins(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>) : 0x2::coin::Coin<0x2::sui::SUI> {
        0x2::coin::join<0x2::sui::SUI>(&mut arg0, arg1);
        arg0
    }

    public fun split_coin_equally(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<0x2::sui::SUI>, 0x2::coin::Coin<0x2::sui::SUI>) {
        (arg0, 0x2::coin::split<0x2::sui::SUI>(&mut arg0, 0x2::coin::value<0x2::sui::SUI>(&arg0) / 2, arg1))
    }

    // decompiled from Move bytecode v6
}

