module 0xc2f9264ba72e0033216394ac49c05e7622d0900f13d9edcb6917155d7e50a71d::dex_deepbook {
    public fun module_loaded() : bool {
        true
    }

    public entry fun simple_sui_transfer(arg0: 0x2::coin::Coin<0x2::sui::SUI>, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

