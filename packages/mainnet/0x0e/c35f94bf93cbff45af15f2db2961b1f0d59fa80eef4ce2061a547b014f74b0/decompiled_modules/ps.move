module 0xec35f94bf93cbff45af15f2db2961b1f0d59fa80eef4ce2061a547b014f74b0::ps {
    public fun ps(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut 0x2::tx_context::TxContext) {
        0x2::coin::join<0x2::sui::SUI>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

