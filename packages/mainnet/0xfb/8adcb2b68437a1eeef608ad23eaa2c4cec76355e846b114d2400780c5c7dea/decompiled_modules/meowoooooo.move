module 0xfb8adcb2b68437a1eeef608ad23eaa2c4cec76355e846b114d2400780c5c7dea::meowoooooo {
    struct MEOWOOOOOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEOWOOOOOO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MEOWOOOOOO>(arg0, 6, b"Meowoooooo", b"Meowooooooo", x"f09f98bbf09f98bb", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732218557697.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MEOWOOOOOO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEOWOOOOOO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

