module 0x5cf41870896769af2f502ab3734c8e1e60b932d990cfeb3d7be9ffa1810551a4::skibidi {
    struct SKIBIDI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SKIBIDI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SKIBIDI>(arg0, 6, b"SKIBIDI", b"Spinning Skibidi", b"Skibidi toilet ready for moon ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000031638_a56042f952.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SKIBIDI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SKIBIDI>>(v1);
    }

    // decompiled from Move bytecode v6
}

