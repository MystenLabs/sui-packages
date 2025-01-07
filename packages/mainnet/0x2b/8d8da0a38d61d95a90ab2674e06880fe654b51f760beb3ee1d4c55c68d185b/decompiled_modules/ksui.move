module 0x2b8d8da0a38d61d95a90ab2674e06880fe654b51f760beb3ee1d4c55c68d185b::ksui {
    struct KSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KSUI>(arg0, 6, b"Ksui", b"Ksui Movtyan", x"d0ac79206461756768746572206d656d652e2049206c6f766520796f75206461756768746572", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733347154873.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

