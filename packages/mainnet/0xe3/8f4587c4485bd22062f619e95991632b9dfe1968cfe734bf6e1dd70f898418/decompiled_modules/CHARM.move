module 0xe38f4587c4485bd22062f619e95991632b9dfe1968cfe734bf6e1dd70f898418::CHARM {
    struct CHARM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHARM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<CHARM>(arg0, 9, 0x1::string::utf8(b"CHARM"), 0x1::string::utf8(b"TEMPLATE_NAME"), 0x1::string::utf8(b"Template currency for deployment"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<CHARM>>(0x2::coin_registry::finalize<CHARM>(v0, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHARM>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

