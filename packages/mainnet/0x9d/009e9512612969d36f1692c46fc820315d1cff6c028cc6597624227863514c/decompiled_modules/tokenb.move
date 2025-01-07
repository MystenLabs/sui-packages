module 0x9d009e9512612969d36f1692c46fc820315d1cff6c028cc6597624227863514c::tokenb {
    struct TOKENB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOKENB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<TOKENB>(arg0, 6, b"TOKENB", b"TOKEN B by SuiAI", b"TOKENB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/81bde544_b325_4693_9544_900f1a8fbd6a_8839e041c5.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<TOKENB>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOKENB>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

