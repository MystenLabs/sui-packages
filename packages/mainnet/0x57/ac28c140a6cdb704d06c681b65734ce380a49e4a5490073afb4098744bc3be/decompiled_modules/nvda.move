module 0x57ac28c140a6cdb704d06c681b65734ce380a49e4a5490073afb4098744bc3be::nvda {
    struct NVDA has drop {
        dummy_field: bool,
    }

    fun init(arg0: NVDA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NVDA>(arg0, 8, b"NVDA", b"Wrapped token for NVIDIA Corp", b"Sudo Virtual Coin for NVIDIA Corp", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NVDA>>(v1);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NVDA>>(v0);
    }

    // decompiled from Move bytecode v6
}

