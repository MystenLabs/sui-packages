module 0x84656db9d5813e3a0f87efd5f0a0b50cc3cdd2633082c4674f4375fddfd11bb2::index_share {
    struct INDEX_SHARE has drop {
        dummy_field: bool,
    }

    fun do_init(arg0: INDEX_SHARE, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::TreasuryCap<INDEX_SHARE> {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<INDEX_SHARE>(arg0, 6, 0x1::string::utf8(b"S50C"), 0x1::string::utf8(b"Seven Ripples (legacy)"), 0x1::string::utf8(b"Legacy share token for the original testnet vault. Production vaults use $S10C and $S20C."), 0x1::string::utf8(b"https://pbs.twimg.com/profile_images/2054281997011275776/ag5KQZtW_400x400.jpg"), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<INDEX_SHARE>(v0, arg1);
        v1
    }

    fun init(arg0: INDEX_SHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = do_init(arg0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<INDEX_SHARE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

