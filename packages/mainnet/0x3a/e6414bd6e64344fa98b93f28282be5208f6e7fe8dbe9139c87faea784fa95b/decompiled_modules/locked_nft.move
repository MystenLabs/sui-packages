module 0x3ae6414bd6e64344fa98b93f28282be5208f6e7fe8dbe9139c87faea784fa95b::locked_nft {
    struct LOCKED_NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOCKED_NFT, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::package::Publisher>(0x2::package::claim<LOCKED_NFT>(arg0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

