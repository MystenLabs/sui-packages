module 0x447db001d6a01885134aff40310aa3c1abd2acee9970ce0c6fce0db565986139::tilly {
    struct TILLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TILLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TILLY>(arg0, 6, b"Tilly", b"a16z AI Dog", b"a16z AI Dog a16z AI Dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1729097094399_8b866a3b4f.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TILLY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TILLY>>(v1);
    }

    // decompiled from Move bytecode v6
}

