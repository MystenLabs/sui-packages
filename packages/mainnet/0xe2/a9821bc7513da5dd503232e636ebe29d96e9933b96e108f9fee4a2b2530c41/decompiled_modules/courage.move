module 0xe2a9821bc7513da5dd503232e636ebe29d96e9933b96e108f9fee4a2b2530c41::courage {
    struct COURAGE has drop {
        dummy_field: bool,
    }

    fun init(arg0: COURAGE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COURAGE>(arg0, 6, b"COURAGE", b"Courage", b"Courage the paranoid sui dog", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_09_26_22_12_07_a38a929294.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COURAGE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COURAGE>>(v1);
    }

    // decompiled from Move bytecode v6
}

