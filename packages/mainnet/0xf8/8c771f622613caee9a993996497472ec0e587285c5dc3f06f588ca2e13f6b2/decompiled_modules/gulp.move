module 0xf88c771f622613caee9a993996497472ec0e587285c5dc3f06f588ca2e13f6b2::gulp {
    struct GULP has drop {
        dummy_field: bool,
    }

    fun init(arg0: GULP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GULP>(arg0, 6, b"GULP", b"bigGULP", b"first ASMR memecoin on sui, hear anons take a big gulp and enjoy the water chain season", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Screenshot_2024_09_20_at_1_50_11_AM_bf270d11b9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GULP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GULP>>(v1);
    }

    // decompiled from Move bytecode v6
}

