module 0xbcdfc0dde46af0a1adbc2d34631435a024e0354a362712e36545a5a1aa594bc7::skibidi {
    struct SKIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDI>(arg0, 6, b"Skibidi", b"Skibidi Toilet", b"SKIBIDI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_9064_c64c123420.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

