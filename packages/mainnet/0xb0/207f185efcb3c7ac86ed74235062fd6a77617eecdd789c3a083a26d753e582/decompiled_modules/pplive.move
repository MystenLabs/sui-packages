module 0xb0207f185efcb3c7ac86ed74235062fd6a77617eecdd789c3a083a26d753e582::pplive {
    struct PPLIVE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PPLIVE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<PPLIVE>(arg0, 6, 0x1::string::utf8(b"PPLIVE"), 0x1::string::utf8(b"PPLIVE POP pair staging"), 0x1::string::utf8(b"Staging token of popular_pairs. Not for trading."), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PPLIVE>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<PPLIVE>>(0x2::coin_registry::finalize<PPLIVE>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

