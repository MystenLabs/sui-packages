module 0x8539812d660697760b2f8af3b36f2e0c9ea7deeabb2656746d7ac5c991f68625::admin_control {
    struct NFT_MINT_ADMIN has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT_MINT_ADMIN{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<NFT_MINT_ADMIN>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

