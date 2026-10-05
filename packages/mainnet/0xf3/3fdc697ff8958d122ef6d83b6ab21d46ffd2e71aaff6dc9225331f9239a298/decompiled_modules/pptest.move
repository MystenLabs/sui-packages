module 0xf33fdc697ff8958d122ef6d83b6ab21d46ffd2e71aaff6dc9225331f9239a298::pptest {
    struct PPTEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPTEST, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PPTEST>(arg0, 6, 0x1::string::utf8(b"PPTEST"), 0x1::string::utf8(b"PPTEST POP pair staging"), 0x1::string::utf8(b"Staging token of popular_pairs. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPTEST>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PPTEST>>(0x2::coin_registry::finalize<PPTEST>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

