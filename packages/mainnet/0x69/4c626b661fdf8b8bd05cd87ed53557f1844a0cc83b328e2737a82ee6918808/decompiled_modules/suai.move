module 0x694c626b661fdf8b8bd05cd87ed53557f1844a0cc83b328e2737a82ee6918808::suai {
    struct SUAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUAI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUAI>(arg0, 9, b"SUAI", b"SuiAI", b"Launch and Co-Create Onchain AI Agents @SuiNetwork", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/suai_logo.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUAI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<SUAI>>(0x2::coin::mint<SUAI>(&mut v2, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<SUAI>>(v2);
    }

    // decompiled from Move bytecode v6
}

