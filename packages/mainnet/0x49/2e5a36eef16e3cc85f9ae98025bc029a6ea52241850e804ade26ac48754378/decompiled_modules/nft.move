module 0x492e5a36eef16e3cc85f9ae98025bc029a6ea52241850e804ade26ac48754378::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct TestNft has drop, store {
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

