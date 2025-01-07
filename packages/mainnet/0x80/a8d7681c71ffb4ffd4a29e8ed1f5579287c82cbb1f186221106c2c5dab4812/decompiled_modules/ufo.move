module 0x80a8d7681c71ffb4ffd4a29e8ed1f5579287c82cbb1f186221106c2c5dab4812::ufo {
    struct UFO has drop {
        dummy_field: bool,
    }

    fun init(arg0: UFO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<UFO>(arg0, 6, b"UFO", b"Alien", b"Bull run vibes", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_8686_8de9cb98e1.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UFO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UFO>>(v1);
    }

    // decompiled from Move bytecode v6
}

