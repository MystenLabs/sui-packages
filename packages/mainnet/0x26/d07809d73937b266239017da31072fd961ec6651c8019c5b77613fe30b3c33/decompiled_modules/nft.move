module 0x26d07809d73937b266239017da31072fd961ec6651c8019c5b77613fe30b3c33::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct TestNft2 has drop, store {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

