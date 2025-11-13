module 0x5594b0a0411310b1f6df797233e25e75f159a0db6173bbc5e7143eeebaa48d08::BREAD {
    struct BREAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BREAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BREAD>(arg0, 9, 0x1::string::utf8(b"BREAD"), 0x1::string::utf8(b"TEMPLATE_NAME"), 0x1::string::utf8(b"Template currency for deployment"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BREAD>>(0x2::coin_registry::finalize<BREAD>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BREAD>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

