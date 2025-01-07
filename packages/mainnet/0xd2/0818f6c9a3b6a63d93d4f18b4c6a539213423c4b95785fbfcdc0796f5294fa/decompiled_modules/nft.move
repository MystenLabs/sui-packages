module 0xd20818f6c9a3b6a63d93d4f18b4c6a539213423c4b95785fbfcdc0796f5294fa::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct TestNft2 has drop, store {
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

