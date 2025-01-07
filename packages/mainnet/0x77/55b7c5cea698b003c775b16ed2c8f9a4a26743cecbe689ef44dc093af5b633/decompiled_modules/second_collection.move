module 0x7755b7c5cea698b003c775b16ed2c8f9a4a26743cecbe689ef44dc093af5b633::second_collection {
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

