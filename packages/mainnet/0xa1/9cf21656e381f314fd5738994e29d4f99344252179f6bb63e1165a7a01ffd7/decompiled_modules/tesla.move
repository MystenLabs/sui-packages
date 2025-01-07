module 0xa19cf21656e381f314fd5738994e29d4f99344252179f6bb63e1165a7a01ffd7::tesla {
    struct TESLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TESLA>(arg0, 6, b"TESLA", b"TESLA6900", b"Made by elon $TESLA WITH $6900 ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_3578_e800df4a23.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESLA>>(v1);
    }

    // decompiled from Move bytecode v6
}

