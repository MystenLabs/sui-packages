module 0x51e1abc7dfe02e348a3778a642ef658dd5c016116ee2e8813c4e3a12f975d88e::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct UC has drop, store {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

