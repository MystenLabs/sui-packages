module 0xdcd10b8d8fd4cb6b5c720cf0a6401069a6bf62fc74519b73785ae3f4638410bf::life {
    struct LIFE has drop {
        dummy_field: bool,
    }

    fun init(arg0: LIFE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LIFE>(arg0, 6, b"LIFE", b"Suiit Life", b"Welcome to the Suiit Life. Fade the Juiit Life. CHOOSE $LIFE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/unnamed_ffe9663e61.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LIFE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LIFE>>(v1);
    }

    // decompiled from Move bytecode v6
}

