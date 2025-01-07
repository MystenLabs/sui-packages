module 0xec6f6d089ba16fdaf562428da903fe69cffb9e26ad50a069446616bd5cea2078::bober {
    struct BOBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOBER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BOBER>(arg0, 6, b"BOBER", b"Bober Trump", b"Time to make BOBER great again", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000040926_dcf7eccbaf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOBER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOBER>>(v1);
    }

    // decompiled from Move bytecode v6
}

