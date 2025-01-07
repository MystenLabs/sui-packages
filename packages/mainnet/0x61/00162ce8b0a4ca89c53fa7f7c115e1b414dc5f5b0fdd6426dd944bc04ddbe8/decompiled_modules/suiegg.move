module 0x6100162ce8b0a4ca89c53fa7f7c115e1b414dc5f5b0fdd6426dd944bc04ddbe8::suiegg {
    struct SUIEGG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIEGG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIEGG>(arg0, 6, b"SUIEGG", b"Suiegg", x"74686520656767206f722074686520636869636b656e206669727374203f200a0a6f6e20535549206e6574776f726b2074686520454747204953204b494e472021", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/suiegg_216ebf4449.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIEGG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIEGG>>(v1);
    }

    // decompiled from Move bytecode v6
}

