module 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::desuilabs {
    struct DESUILABS has drop {
        dummy_field: bool,
    }

    struct DeSuiLabsNFT has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: DESUILABS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<DESUILABS>(arg0, arg1);
    }

    public fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = DeSuiLabsNFT{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<DeSuiLabsNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

