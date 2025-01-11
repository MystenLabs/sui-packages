module 0xdafe9f95a73476892411f9a28cf6228aaaa5aa8ec368cd042a442dbf40a5fbeb::sgtp {
    struct SGTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGTP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SGTP>(arg0, 6, b"SGTP", b"Sui Gpt Tools by SuiAI", b"ow you can directly compare Revela Decompiler's output with SuiGPT Decompiler's at .SuiGPT_tools. ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/gpt_d22b9805ac.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SGTP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGTP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

