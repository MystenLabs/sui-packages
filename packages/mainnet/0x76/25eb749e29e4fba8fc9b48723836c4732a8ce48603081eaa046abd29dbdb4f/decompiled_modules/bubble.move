module 0x7625eb749e29e4fba8fc9b48723836c4732a8ce48603081eaa046abd29dbdb4f::bubble {
    struct BUBBLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: BUBBLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BUBBLE>(arg0, 6, b"BUBBLE", b"Bubble", b"Bubbles journey through the world of Sui is full of adventures. Follow along and discover each stop along the way!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_07_22_28_51_be8c7bd878.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BUBBLE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BUBBLE>>(v1);
    }

    // decompiled from Move bytecode v6
}

