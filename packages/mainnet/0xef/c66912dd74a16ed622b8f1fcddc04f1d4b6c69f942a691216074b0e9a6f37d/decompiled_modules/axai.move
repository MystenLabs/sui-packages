module 0xefc66912dd74a16ed622b8f1fcddc04f1d4b6c69f942a691216074b0e9a6f37d::axai {
    struct AXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AXAI>(arg0, 6, b"AXAI", b"AXAI Agent Reborn by SuiAI", b"Axai: The AI Ocean Master..With every new holder, Axai dives deeper, collecting rare AI data fragments that enhance its power, transforming it into the ultimate digital ocean guardian.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_13_07_26_30_441_edit_com_twitter_android_a5fb1df35b.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

