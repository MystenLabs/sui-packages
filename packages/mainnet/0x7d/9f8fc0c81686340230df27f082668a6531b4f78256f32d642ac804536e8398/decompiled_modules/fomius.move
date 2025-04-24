module 0x7d9f8fc0c81686340230df27f082668a6531b4f78256f32d642ac804536e8398::fomius {
    struct FOMIUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOMIUS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOMIUS>(arg0, 6, b"FOMIUS", b"FOMIUS the God of Regret", b"Never too late for FOMIUS. Buy now", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2025_04_24_22_33_06_540232ebfd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOMIUS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FOMIUS>>(v1);
    }

    // decompiled from Move bytecode v6
}

