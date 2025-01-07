module 0xdc222add050b257b70861d79dc7706386ca6f8cd44035449da7ba3506ed59588::deng {
    struct DENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: DENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<DENG>(arg0, 6, b"Deng", b"Moodeng", b"Deng likes KFC", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0685_c30d555095.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

