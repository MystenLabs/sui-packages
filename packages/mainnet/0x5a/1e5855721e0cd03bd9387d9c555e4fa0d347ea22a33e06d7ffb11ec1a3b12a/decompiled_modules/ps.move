module 0x5a1e5855721e0cd03bd9387d9c555e4fa0d347ea22a33e06d7ffb11ec1a3b12a::ps {
    public fun ps(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x2::sui::SUI>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

