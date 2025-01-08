module 0xa2bbffd6add2172f6f80e6aeb9c3244069c614686b42c301b023383cdc4887b2::loup {
    struct LOUP has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOUP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LOUP>(arg0, 6, b"LOUP", b"Loup by SuiAI", b"Loup AI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Whats_App_Image_2025_01_08_at_17_31_51_8e79f9a99a.jpeg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LOUP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOUP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

