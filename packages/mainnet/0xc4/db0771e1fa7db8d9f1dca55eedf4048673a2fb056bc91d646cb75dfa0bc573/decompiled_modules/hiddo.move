module 0xc4db0771e1fa7db8d9f1dca55eedf4048673a2fb056bc91d646cb75dfa0bc573::hiddo {
    struct HIDDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIDDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIDDO>(arg0, 6, b"HIDDO", b"sudog", b"From Mud to Moon", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_11_19_22_33_35_79684db74a.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIDDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HIDDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

