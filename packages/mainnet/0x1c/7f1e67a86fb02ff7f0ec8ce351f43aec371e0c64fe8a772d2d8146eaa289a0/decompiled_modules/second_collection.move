module 0x1c7f1e67a86fb02ff7f0ec8ce351f43aec371e0c64fe8a772d2d8146eaa289a0::second_collection {
    struct SECOND_COLLECTION has drop {
        dummy_field: bool,
    }

    struct SecondCollectionNFT has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: SECOND_COLLECTION, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<SECOND_COLLECTION>(arg0, arg1);
    }

    public fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = SecondCollectionNFT{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SecondCollectionNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

