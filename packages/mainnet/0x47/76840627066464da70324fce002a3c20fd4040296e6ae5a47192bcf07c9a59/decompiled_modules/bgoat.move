module 0x4776840627066464da70324fce002a3c20fd4040296e6ae5a47192bcf07c9a59::bgoat {
    struct BGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: BGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BGOAT>(arg0, 6, b"BGOAT", b"BLUE GOAT", b"GOAT IS GOOD NARRATIVE ON SUI, MAKE MILLION MC, REAL GOAT ON SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/DCE_80_BD_5_B634_403_A_B05_C_EB_2_D389875_DD_002a0fae51.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BGOAT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BGOAT>>(v1);
    }

    // decompiled from Move bytecode v6
}

