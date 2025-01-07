module 0x5791f611365b4d65b6efda5ce65c6686eddc8d981db3c5cfa27c808b6bb599ea::unchained_esports {
    struct UNCHAINED_ESPORTS has drop {
        dummy_field: bool,
    }

    struct UnchainedEsportsNFT has store, key {
        id: 0x2::object::UID,
    }

    fun init(arg0: UNCHAINED_ESPORTS, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<UNCHAINED_ESPORTS>(arg0, arg1);
    }

    public fun mint_nft(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = UnchainedEsportsNFT{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<UnchainedEsportsNFT>(v0, 0x2::tx_context::sender(arg0));
    }

    // decompiled from Move bytecode v6
}

