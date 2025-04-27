module 0x54ce52abeef6478844cb54b80a45dafc5156ec95aebd8fa58a77ffd271e83cc6::admin_control {
    struct NFT_MINT_ADMIN has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = NFT_MINT_ADMIN{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<NFT_MINT_ADMIN>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

