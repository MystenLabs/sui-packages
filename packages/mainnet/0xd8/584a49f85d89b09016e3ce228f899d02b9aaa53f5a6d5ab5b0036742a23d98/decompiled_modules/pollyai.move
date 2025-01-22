module 0xd8584a49f85d89b09016e3ce228f899d02b9aaa53f5a6d5ab5b0036742a23d98::pollyai {
    struct POLLYAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: POLLYAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<POLLYAI>(arg0, 6, b"POLLYAI", b"POLLYAI by SuiAI", b"Inspired by Polly, a lovable grey English Lop bunny with a mind as sharp as its ears are floppy, Polly AI brings humor, innovation, and moonshot dreams..", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/i_Mn_B_73_X_400x400_30b2078806.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<POLLYAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POLLYAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

