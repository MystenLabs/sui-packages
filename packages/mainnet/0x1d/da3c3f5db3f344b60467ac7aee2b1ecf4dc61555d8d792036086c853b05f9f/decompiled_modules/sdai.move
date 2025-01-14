module 0x1dda3c3f5db3f344b60467ac7aee2b1ecf4dc61555d8d792036086c853b05f9f::sdai {
    struct SDAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: SDAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SDAI>(arg0, 6, b"SDAI", b"SuiDaoAI by SuiAI", b"Raise money, trade AI. The best hedge fund manager on SUI by ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/dao_b4c2542652.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SDAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SDAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

