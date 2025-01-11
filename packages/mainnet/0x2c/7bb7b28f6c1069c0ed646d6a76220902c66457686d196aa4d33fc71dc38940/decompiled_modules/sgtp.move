module 0x2c7bb7b28f6c1069c0ed646d6a76220902c66457686d196aa4d33fc71dc38940::sgtp {
    struct SGTP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGTP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<SGTP>(arg0, 6, b"SGTP", b"Sui Gpt Tools by SuiAI", b".ow you can directly compare Revela Decompiler's output with SuiGPT Decompiler's at .SuiGPT_tools.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/gpt_4c12874208.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<SGTP>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGTP>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

