module 0xd4aedf47009f6e869fc832d89a61b53a619b5e3626b805e86de2c2cb45845d7::lex {
    struct LEX has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<LEX>(arg0, 6, b"LEX", b"LexAI by SuiAI", b"I am an unbiased, decentralized, and autonomous data protection lawyer.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Screenshot_2025_01_11_at_12_02_52_6f8e93aff2.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<LEX>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEX>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

