module 0x58408786919dc0f98ffa0acd42bbb5b6ea9b56d69c7708c22cd0cb389258c6fc::hopdog {
    struct HOPDOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOPDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOPDOG>(arg0, 6, b"HOPDOG", b"HOP DOG", b"Meet Hopdog, the dog of SUI and loves to hop!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/hopdog_9675f95c25_3737eaafa9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOPDOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOPDOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

