module 0xd2dc1e500dc8801808f12597d25fa2028954c833e0f2f06cff1d4abf18b5c449::nuiro {
    struct NUIRO has drop {
        dummy_field: bool,
    }

    fun init(arg0: NUIRO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NUIRO>(arg0, 6, b"NUIRO", b"Nuiro", b"Nuiro aims to catch up to the fair value of the Neiro Brand... were in for a wild ride!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Whats_App_Image_2024_09_16_at_5_53_48_PM_1_284ceca159.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NUIRO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NUIRO>>(v1);
    }

    // decompiled from Move bytecode v6
}

