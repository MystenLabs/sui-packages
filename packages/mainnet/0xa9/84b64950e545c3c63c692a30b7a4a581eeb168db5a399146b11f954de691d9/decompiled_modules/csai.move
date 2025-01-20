module 0xa984b64950e545c3c63c692a30b7a4a581eeb168db5a399146b11f954de691d9::csai {
    struct CSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: CSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CSAI>(arg0, 6, b"CSAI", b"Cobra Strike AI", b"Always missing hype coin launches? Monitor X pages for CA announcements and instantly snipe them with Cobra Strike AI.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_20250121_002716_435_7ccf240599.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CSAI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CSAI>>(v1);
    }

    // decompiled from Move bytecode v6
}

