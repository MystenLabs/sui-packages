module 0x50052aca3d7b971bd9824e1bb151748d03870adfe3ba06dce384d2a77297c719::interest_stable_swap {
    struct INTEREST_STABLE_SWAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: INTEREST_STABLE_SWAP, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<INTEREST_STABLE_SWAP>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

