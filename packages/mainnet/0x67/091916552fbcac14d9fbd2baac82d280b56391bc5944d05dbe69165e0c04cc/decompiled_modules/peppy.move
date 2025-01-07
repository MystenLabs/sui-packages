module 0x67091916552fbcac14d9fbd2baac82d280b56391bc5944d05dbe69165e0c04cc::peppy {
    struct PEPPY has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPPY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PEPPY>(arg0, 6, b"PEPPY", b"Pepes Sister", b"Im just a girl", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_0053_4cbe0c2a5c.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPPY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPPY>>(v1);
    }

    // decompiled from Move bytecode v6
}

