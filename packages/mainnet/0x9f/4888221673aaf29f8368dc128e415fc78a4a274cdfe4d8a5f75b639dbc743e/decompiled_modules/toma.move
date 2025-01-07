module 0x9f4888221673aaf29f8368dc128e415fc78a4a274cdfe4d8a5f75b639dbc743e::toma {
    struct TOMA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOMA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOMA>(arg0, 9, b"TOMA", b"TOMA", b"Atoma network coin", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOMA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOMA>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

