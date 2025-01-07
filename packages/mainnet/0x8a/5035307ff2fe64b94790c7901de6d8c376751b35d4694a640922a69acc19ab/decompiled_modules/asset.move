module 0x8a5035307ff2fe64b94790c7901de6d8c376751b35d4694a640922a69acc19ab::asset {
    public fun transfer_coin<T0>(arg0: &mut 0x2::coin::Coin<T0>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg0, arg1, arg3), arg2);
    }

    public fun transfer_sui_coin(arg0: &mut 0x2::coin::Coin<0x2::sui::SUI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::split<0x2::sui::SUI>(arg0, arg1, arg3), arg2);
    }

    // decompiled from Move bytecode v6
}

