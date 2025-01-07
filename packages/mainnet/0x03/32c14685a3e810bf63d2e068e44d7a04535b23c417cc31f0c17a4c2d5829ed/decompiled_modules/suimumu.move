module 0x332c14685a3e810bf63d2e068e44d7a04535b23c417cc31f0c17a4c2d5829ed::suimumu {
    struct SUIMUMU has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIMUMU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIMUMU>(arg0, 6, b"SUIMUMU", b"SuiMumu", b"Sui Mumu is a decentralized cryptocurrency powered by a strong community of bulls, represented by MUMU, the bull market`s mascot. Mumu has dominated and controlled market sentiments in the past and returned in the Spring of 2023.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/photo_2024_10_15_00_24_16_87f3d00f15.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIMUMU>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIMUMU>>(v1);
    }

    // decompiled from Move bytecode v6
}

