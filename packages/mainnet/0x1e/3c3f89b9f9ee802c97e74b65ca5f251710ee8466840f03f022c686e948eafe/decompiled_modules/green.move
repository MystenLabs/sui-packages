module 0x1e3c3f89b9f9ee802c97e74b65ca5f251710ee8466840f03f022c686e948eafe::green {
    struct GREEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: GREEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GREEN>(arg0, 6, b"Green", b"The Future is Green", x"5468652046757475726520697320475245454e2e0a2d4164656e697969", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0570_4e911dbf2c.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GREEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GREEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

