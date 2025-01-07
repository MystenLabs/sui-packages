module 0x6316456ff0a048154f81b89cc55291c89197ff6716dd6f0914cb73b335a15605::suigure {
    struct SUIGURE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGURE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGURE>(arg0, 6, b"SUIgure", b"Shigure", b"Shigure, known for her captivating presence and dynamic personality, leads a formidable gang in the crypto world with the ticker $SUIgure.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/ezgif_6_0b79c66c1e_4a1d8ca8b1.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGURE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIGURE>>(v1);
    }

    // decompiled from Move bytecode v6
}

