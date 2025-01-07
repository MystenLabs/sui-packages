module 0xfb9ea69c6c750ca91e631db2097c2d8dedac5031ac8e492a5ace718ecbe19611::matb {
    struct MATB has drop {
        dummy_field: bool,
    }

    fun init(arg0: MATB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MATB>(arg0, 6, b"MATB", b"Me and the Boys", b"Just me and the boys", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20241219_205906_791_ab3cc4381b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MATB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MATB>>(v1);
    }

    // decompiled from Move bytecode v6
}

