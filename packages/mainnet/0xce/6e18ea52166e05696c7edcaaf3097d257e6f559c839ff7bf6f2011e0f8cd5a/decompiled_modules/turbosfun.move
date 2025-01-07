module 0xce6e18ea52166e05696c7edcaaf3097d257e6f559c839ff7bf6f2011e0f8cd5a::turbosfun {
    struct TURBOSFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TURBOSFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TURBOSFUN>(arg0, 6, b"TurbosFun", b"Turbos Fun", b"https://app.turbos.finance/fun", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731033909013.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURBOSFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TURBOSFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

