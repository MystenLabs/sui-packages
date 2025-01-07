module 0x4f0de7b4f0337374f0073b6445310ff29a17397f46e3f3add34cd190b12657b7::sapy {
    struct SAPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SAPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SAPY>(arg0, 6, b"SAPY", b"Sui Ape Party", b"This is Party Time. Let's trade and have fun with $SAPY ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/sticker_738b9de4d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SAPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SAPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

