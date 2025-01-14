module 0x1c160812049f8595f2a376a00e8e2f5b3d78704c5e79bd9ee6868c2d7c3ea377::suitopia {
    struct SUITOPIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITOPIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUITOPIA>(arg0, 6, b"SUITOPIA", b"SuiTopia by SuiAI", b"Get your own SUI NFT powered by AI !", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/DALL_E_2025_01_14_22_22_removebg_preview_1f0319884d.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUITOPIA>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITOPIA>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

