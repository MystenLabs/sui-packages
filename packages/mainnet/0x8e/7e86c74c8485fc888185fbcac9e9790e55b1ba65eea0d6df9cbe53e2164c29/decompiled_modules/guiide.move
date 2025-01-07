module 0x8e7e86c74c8485fc888185fbcac9e9790e55b1ba65eea0d6df9cbe53e2164c29::guiide {
    struct GUIIDE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUIIDE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUIIDE>(arg0, 6, b"GUIIDE", b"GUIIDE DOG", b"You are my proud partner, a warm family, I need you and love you.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730644420878.gif")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUIIDE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUIIDE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

