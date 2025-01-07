module 0x4ad4482e45fb57eedb4401d27a027d8002ebc772f92a288895e922e9f4def066::suideng {
    struct SUIDENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIDENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIDENG>(arg0, 6, b"Suideng", b"Sui deng", b"Unofficial moodeng of sui", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/IMG_2445_31b1fb5239.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIDENG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIDENG>>(v1);
    }

    // decompiled from Move bytecode v6
}

