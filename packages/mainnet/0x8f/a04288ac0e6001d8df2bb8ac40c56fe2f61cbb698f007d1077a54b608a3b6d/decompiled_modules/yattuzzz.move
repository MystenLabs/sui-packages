module 0x8fa04288ac0e6001d8df2bb8ac40c56fe2f61cbb698f007d1077a54b608a3b6d::yattuzzz {
    struct YATTUZZZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: YATTUZZZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<YATTUZZZ>(arg0, 6, b"YATTUZZZ", b"SUILOVE by SuiAI", b"SUILOVE!!", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/62676350_eps_a876238506.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<YATTUZZZ>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YATTUZZZ>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

