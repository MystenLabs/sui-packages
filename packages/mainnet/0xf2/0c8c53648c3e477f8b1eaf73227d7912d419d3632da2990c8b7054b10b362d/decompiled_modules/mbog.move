module 0xf20c8c53648c3e477f8b1eaf73227d7912d419d3632da2990c8b7054b10b362d::mbog {
    struct MBOG has drop {
        dummy_field: bool,
    }

    fun init(arg0: MBOG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MBOG>(arg0, 6, b"MBOG", b"Monkey OG", x"244d424f4720546865204f726967696e616c204d6f6e6b6579204d656d65206f6e205375692e0a204c657427732073686f772074686520776f726c6420776879206d6f6e6b6579732061726520746865207265616c204f4773206f6620746865204d656d65204b696e67646f6d2c2062792063656c6562726174696e67207468652074727565206f726967696e206f66204d656d65732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_11_14_at_11_57_49_PM_7c71f92bb2.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MBOG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MBOG>>(v1);
    }

    // decompiled from Move bytecode v6
}

