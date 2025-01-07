module 0x8aaee4ee755688a5050c0623a514c50727b34a595f3fad6afb93c6d1be9fa61f::sdfsd {
    struct SDFSD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDFSD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SDFSD>(arg0, 6, b"SDFSD", b"123S", b"SDF", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/images_hero_heading_538868b379.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDFSD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SDFSD>>(v1);
    }

    // decompiled from Move bytecode v6
}

