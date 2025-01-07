module 0x3256688130a0cd6d890a77dfb824a1ac7f59e434a0d116a94fbb0f0215b48d91::monki {
    struct MONKI has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONKI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONKI>(arg0, 6, b"MONKI", b"LILBRO", b"we create we ape", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/0a0fff585b7738252d5c2492539ad42c_da0b5813b3.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONKI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONKI>>(v1);
    }

    // decompiled from Move bytecode v6
}

