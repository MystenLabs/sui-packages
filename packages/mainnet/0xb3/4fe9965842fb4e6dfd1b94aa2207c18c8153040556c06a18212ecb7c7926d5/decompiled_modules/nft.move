module 0xb34fe9965842fb4e6dfd1b94aa2207c18c8153040556c06a18212ecb7c7926d5::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    struct TestNft has drop, store {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<NFT>(arg0, arg1);
    }

    // decompiled from Move bytecode v6
}

