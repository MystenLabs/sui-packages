module 0x67e110e5b8f0a225eb3ef99f3b88c2c0577398f54c54a58ceaf050dbd2a80ed7::jmong {
    struct JMONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMONG>(arg0, 6, b"Jmong", b"JAMONG", b"dogwifhood", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1728775409871_17b0f650cf.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JMONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

