module 0x2e7cf34d72279c56fa63f2addad0dbc903b9b4a3c7aa12fa790562b4366bab43::pptwo {
    struct PPTWO has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPTWO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PPTWO>(arg0, 6, 0x1::string::utf8(b"PPTWO"), 0x1::string::utf8(b"PPTWO POP pair staging"), 0x1::string::utf8(b"Staging token of popular_pairs. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPTWO>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PPTWO>>(0x2::coin_registry::finalize<PPTWO>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

