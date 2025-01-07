module 0xb22c60c534944c8a31a34159d84ae28b9f5c139d4d9c977b3a8aac6a607df4c9::suimas {
    struct SUIMAS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMAS>(arg0, 6, b"SUIMAS", b"ORIGINAL SUI CHRISTMAS", x"4d65727279205375696d6173210a7375696d61732e66756e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/SUIMAS_6aaed2f215.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMAS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMAS>>(v1);
    }

    // decompiled from Move bytecode v6
}

