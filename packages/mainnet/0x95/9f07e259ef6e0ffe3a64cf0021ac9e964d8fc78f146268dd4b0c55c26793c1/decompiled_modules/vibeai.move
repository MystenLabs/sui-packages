module 0x959f07e259ef6e0ffe3a64cf0021ac9e964d8fc78f146268dd4b0c55c26793c1::vibeai {
    struct VIBEAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: VIBEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VIBEAI>(arg0, 6, b"VIBEAI", b"VibeAI Agent by SuiAI", b"VibeAI Agent: Meet your digital assistant that understands your vibe. With artificial intelligence and a sensitivity to moods, VibeAI creates a more personalized, intuitive experience. Merging with the digital world, welcome to the future of smart interaction", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/undefined_image_1_79341d4b4a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VIBEAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VIBEAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

