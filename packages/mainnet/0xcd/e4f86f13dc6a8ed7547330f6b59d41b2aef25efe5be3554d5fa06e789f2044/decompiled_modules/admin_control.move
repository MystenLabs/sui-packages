module 0xcde4f86f13dc6a8ed7547330f6b59d41b2aef25efe5be3554d5fa06e789f2044::admin_control {
    struct NFT_MINT_ADMIN has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT_MINT_ADMIN{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<NFT_MINT_ADMIN>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

