module 0x92ccbd70faf28e51e3d49fcdcbc47ee372ef4115cf51bbb097fe057d5317599f::admin_control {
    struct NFT_MINT_ADMIN has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT_MINT_ADMIN{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<NFT_MINT_ADMIN>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

