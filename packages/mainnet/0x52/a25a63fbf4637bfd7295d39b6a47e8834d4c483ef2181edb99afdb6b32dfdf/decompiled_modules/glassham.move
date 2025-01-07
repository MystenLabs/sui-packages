module 0x52a25a63fbf4637bfd7295d39b6a47e8834d4c483ef2181edb99afdb6b32dfdf::glassham {
    struct GLASSHAM has drop {
        dummy_field: bool,
    }

    fun init(arg0: GLASSHAM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GLASSHAM>(arg0, 6, b"Glassham", b"Hamster in glas", b"Meet the cutest hamster on sui in glass", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2397_8aba2a5e5b.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GLASSHAM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GLASSHAM>>(v1);
    }

    // decompiled from Move bytecode v6
}

