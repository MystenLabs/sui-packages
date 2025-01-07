module 0x3de6c35f30cfa685b761a855ea6b8f55a40b2e3cd667385210e1fdeb810308b6::suirex {
    struct SUIREX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIREX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIREX>(arg0, 6, b"SUIREX", b"SUIREX COIN", b"SUIREX OFFICIAL MOVEPUMP", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3644_4b71372fde.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIREX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIREX>>(v1);
    }

    // decompiled from Move bytecode v6
}

