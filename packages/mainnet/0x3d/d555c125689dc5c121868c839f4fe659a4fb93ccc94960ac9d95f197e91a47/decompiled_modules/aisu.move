module 0x3dd555c125689dc5c121868c839f4fe659a4fb93ccc94960ac9d95f197e91a47::aisu {
    struct AISU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AISU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AISU>(arg0, 6, b"AISU", b"AiSU by SuiAI", b"NA", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/aiface_705f0da414.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AISU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AISU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

