module 0xfde7c112b324fd46e22c1ba04a5519eb59d200b846107e1ad63a021a07228a36::ldrgn {
    struct LDRGN has drop {
        dummy_field: bool,
    }

    fun init(arg0: LDRGN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LDRGN>(arg0, 6, b"LDRGN", b"LITCH DRAGON", b"LDRGN is a tiny blue dragon who has magical powers since birth, his natural habitat may be in the sky but he also has abilities in the ocean.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/20250506_002735_0180c7c6ce.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LDRGN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LDRGN>>(v1);
    }

    // decompiled from Move bytecode v6
}

