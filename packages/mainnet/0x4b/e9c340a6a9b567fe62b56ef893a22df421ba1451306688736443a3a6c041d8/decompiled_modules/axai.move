module 0x4be9c340a6a9b567fe62b56ef893a22df421ba1451306688736443a3a6c041d8::axai {
    struct AXAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AXAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AXAI>(arg0, 6, b"AXAI", b"AXAI Agent by SuiAI", b"Axai: The AI Ocean Master..With every new holder, Axai dives deeper, collecting rare AI data fragments that enhance its power, transforming it into the ultimate digital ocean guardian.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/AXAI_5f20de9cb9.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AXAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AXAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

