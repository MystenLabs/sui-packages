module 0x806b135c522d20cd2702809a679ad110c8ab3ee90ed012195abd75b715e6f7fc::meow {
    struct MEOW has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOW, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<MEOW>(arg0, 6, b"MEOW", b"MeowDao by SuiAI", b"meow", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/meowdao_token_3a38293b33.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<MEOW>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOW>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

