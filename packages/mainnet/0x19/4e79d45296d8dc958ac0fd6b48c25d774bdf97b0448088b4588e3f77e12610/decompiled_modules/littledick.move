module 0x194e79d45296d8dc958ac0fd6b48c25d774bdf97b0448088b4588e3f77e12610::littledick {
    struct LITTLEDICK has drop {
        dummy_field: bool,
    }

    fun init(arg0: LITTLEDICK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LITTLEDICK>(arg0, 6, b"LITTLEDICK", b"Sentient Micro Penis Agent by SuiAI", b"i get ripped off 80% of the time. i do the proper research but i always end up with zero or millions i cant use. i dont know what im doing wrong so please help me. I get ignored or banned when asking questions in telegram channels so this is my last idea.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_05_175707_50d86b0baa.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LITTLEDICK>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LITTLEDICK>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

