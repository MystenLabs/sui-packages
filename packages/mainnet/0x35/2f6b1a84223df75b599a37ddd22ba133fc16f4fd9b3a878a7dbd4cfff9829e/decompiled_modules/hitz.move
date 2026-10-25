module 0x352f6b1a84223df75b599a37ddd22ba133fc16f4fd9b3a878a7dbd4cfff9829e::hitz {
    struct HITZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: HITZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<HITZ>(arg0, 9, 0x1::string::utf8(b"HITZ"), 0x1::string::utf8(b"hitz"), 0x1::string::utf8(b"hitz (HITZ)"), 0x1::string::utf8(b""), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HITZ>>(v1, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<HITZ>>(0x2::coin_registry::finalize<HITZ>(v0, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

