module 0x762110c06de6894d841713ad342d2d5b0032d2652e4ed9721e87efb9b7a13dac::feng {
    struct FENG has drop {
        dummy_field: bool,
    }

    fun init(arg0: FENG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FENG>(arg0, 6, b"FENG", b"FENGSUI", b"Where luck goes to those who believe.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737000264644.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FENG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FENG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

