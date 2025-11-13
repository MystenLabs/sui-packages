module 0x3cf89172821878df18f23b7d299ec6ea78baf463f223b911b6c2e81cb203cb43::TIMUR {
    struct TIMUR has drop {
        dummy_field: bool,
    }

    fun init(arg0: TIMUR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<TIMUR>(arg0, 9, 0x1::string::utf8(b"TIMUR"), 0x1::string::utf8(b"TEMPLATE_NAME"), 0x1::string::utf8(b"Template currency for deployment"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<TIMUR>>(0x2::coin_registry::finalize<TIMUR>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TIMUR>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

