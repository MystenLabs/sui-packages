module 0x69d537d038e5249f43c161277fcfef595e9145784256a2def9cd39fe6c0449f3::tuge {
    struct TUGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: TUGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TUGE>(arg0, 6, b"TUGE", b"TUGE SUI", b"TUGE BEST ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_05_09_20_00_10_5095f204bd.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TUGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TUGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

