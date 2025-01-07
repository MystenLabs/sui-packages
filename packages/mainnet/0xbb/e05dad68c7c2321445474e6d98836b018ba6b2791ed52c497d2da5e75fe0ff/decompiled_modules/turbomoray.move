module 0xbbe05dad68c7c2321445474e6d98836b018ba6b2791ed52c497d2da5e75fe0ff::turbomoray {
    struct TURBOMORAY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOMORAY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOMORAY>(arg0, 6, b"TurboMoray", b"Sui Moray Turbos", x"7467203a2068747470733a2f2f742e6d652f7375696d6f726179747572626f730a776562203a20687474703a2f2f7375696d6f7261792e78797a2f0a74776974746572203a2068747470733a2f2f782e636f6d2f7375696d6f726179747572626f73", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731178301747.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOMORAY>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOMORAY>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

