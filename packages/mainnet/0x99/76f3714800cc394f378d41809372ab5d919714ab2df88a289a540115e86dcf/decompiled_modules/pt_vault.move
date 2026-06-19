module 0x9976f3714800cc394f378d41809372ab5d919714ab2df88a289a540115e86dcf::pt_vault {
    struct PT_VAULT has drop {
        dummy_field: bool,
    }

    fun init(arg0: PT_VAULT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PT_VAULT>(arg0, 9, 0x1::string::utf8(b"PT-sSUI-20260917"), 0x1::string::utf8(b"Nemo PT sSUI 2026-09-17"), 0x1::string::utf8(b"Nemo sSUI principal token for the market maturing on 2026-09-17 UTC."), 0x1::string::utf8(b"https://nemo.xyz/icon-pt.png"), arg1);
        0x2::coin_registry::finalize_and_delete_metadata_cap<PT_VAULT>(v0, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PT_VAULT>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

