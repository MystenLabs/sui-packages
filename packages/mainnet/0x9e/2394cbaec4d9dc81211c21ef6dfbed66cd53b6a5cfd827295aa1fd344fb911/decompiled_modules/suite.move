module 0x9e2394cbaec4d9dc81211c21ef6dfbed66cd53b6a5cfd827295aa1fd344fb911::suite {
    struct SUITE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITE>(arg0, 6, b"Suite", b"SUITE", b"SUI SUITE", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Picsart_24_10_02_07_44_19_303_be19776304.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITE>>(v1);
    }

    // decompiled from Move bytecode v6
}

