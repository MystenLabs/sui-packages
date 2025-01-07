module 0x971d5367a1dd638431973461a1bbbec3c48b7543534c0832ef34fbfe60a0b48::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct TestNft3 has drop, store {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

