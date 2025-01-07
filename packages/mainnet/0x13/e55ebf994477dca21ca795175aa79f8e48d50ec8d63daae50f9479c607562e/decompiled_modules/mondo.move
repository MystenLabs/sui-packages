module 0x13e55ebf994477dca21ca795175aa79f8e48d50ec8d63daae50f9479c607562e::mondo {
    struct MONDO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MONDO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MONDO>(arg0, 6, b"MONDO", b"Mondo on Sui", b"Mondo is fueled by creativity, innovation, and a strong community spirit", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/head_7599f85411.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MONDO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MONDO>>(v1);
    }

    // decompiled from Move bytecode v6
}

