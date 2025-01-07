module 0x15d98fd544e3cac9f01e916bc03df1f7db0ad1b863432d6dd14530c6f4bd0f78::homlessguy {
    struct HOMLESSGUY has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOMLESSGUY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HOMLESSGUY>(arg0, 6, b"HOMLESSGUY", b"Homeless guy", b"chillguy turned homeless guy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735840067282.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HOMLESSGUY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOMLESSGUY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

