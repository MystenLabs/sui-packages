module 0xa1de4b295be47946c7c002f6f4238ab6ffa59efb8a8383d097df7850b49bb380::suix {
    struct SUIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SUIX>(arg0, 6, b"SUIX", b"SUi100 Agent by SuiAI", x"f09f94a52046697273742041492058206167656e74206f6e2073756920706f776572656420627920446565705365656b2d5231", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/g_Muo4_A0_X_400x400_1_696097ca83.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SUIX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

