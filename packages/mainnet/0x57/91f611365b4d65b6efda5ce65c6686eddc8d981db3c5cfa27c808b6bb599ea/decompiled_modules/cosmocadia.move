module 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::cosmocadia {
    struct COSMOCADIA has drop {
        dummy_field: bool,
    }

    struct CosmocadiaNFT has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: COSMOCADIA, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<COSMOCADIA>(arg0, arg1);
    }

    public fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CosmocadiaNFT{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CosmocadiaNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

