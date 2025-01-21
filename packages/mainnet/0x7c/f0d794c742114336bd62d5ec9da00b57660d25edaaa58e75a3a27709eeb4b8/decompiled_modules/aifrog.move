module 0x7cf0d794c742114336bd62d5ec9da00b57660d25edaaa58e75a3a27709eeb4b8::aifrog {
    struct AIFROG has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIFROG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIFROG>(arg0, 6, b"AIFROG", b"AI FROG by SuiAI", b"The importance of technology brings promotion and development in the future, caring and contributing to the community is a noble mission of Ai Frog .", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/08acce565c3447321428c02ba964ebff_1_e405c425f5.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIFROG>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIFROG>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

