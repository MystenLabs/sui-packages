module 0xe6d70d8be8266f49f8c43b5e4ae0602cf2b2a8d17fcd8edf8e06e128bec2c3bb::suibee {
    struct SUIBEE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIBEE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIBEE>(arg0, 6, b"SuiBee", b"Sui Bee", b"Funny Fatty Bee ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731029842184.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIBEE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIBEE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

