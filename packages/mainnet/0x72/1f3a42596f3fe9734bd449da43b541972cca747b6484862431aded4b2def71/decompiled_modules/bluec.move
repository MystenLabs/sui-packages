module 0x721f3a42596f3fe9734bd449da43b541972cca747b6484862431aded4b2def71::bluec {
    struct BLUEC has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEC>(arg0, 6, b"BLUEC", b"Cat Eyes Blue", b"A cat eyes blue", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_10_01_30_06_e3e59c0061.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEC>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEC>>(v1);
    }

    // decompiled from Move bytecode v6
}

