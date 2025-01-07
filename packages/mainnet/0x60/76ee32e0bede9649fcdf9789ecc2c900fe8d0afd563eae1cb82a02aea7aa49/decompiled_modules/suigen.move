module 0x6076ee32e0bede9649fcdf9789ecc2c900fe8d0afd563eae1cb82a02aea7aa49::suigen {
    struct SUIGEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIGEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIGEN>(arg0, 6, b"SUIGEN", b"404 SUI GENIUS", b" welcome to the SuiGenius Hub ultimus terminal", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731224952386.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUIGEN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIGEN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

