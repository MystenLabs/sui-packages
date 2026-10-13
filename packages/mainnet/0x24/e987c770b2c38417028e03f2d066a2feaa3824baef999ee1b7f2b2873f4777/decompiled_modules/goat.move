module 0x24e987c770b2c38417028e03f2d066a2feaa3824baef999ee1b7f2b2873f4777::goat {
    struct GOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<GOAT>(arg0, 8, 0x1::string::utf8(b"GOAT"), 0x1::string::utf8(b"Goatcoin"), 0x1::string::utf8(b""), 0x1::string::utf8(b"https://goatcoin.meme/logo.png"), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<GOAT>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOAT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

