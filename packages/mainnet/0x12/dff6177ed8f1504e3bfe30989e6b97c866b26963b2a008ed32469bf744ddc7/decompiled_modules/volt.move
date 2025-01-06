module 0x12dff6177ed8f1504e3bfe30989e6b97c866b26963b2a008ed32469bf744ddc7::volt {
    struct VOLT has drop {
        dummy_field: bool,
    }

    fun init(arg0: VOLT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<VOLT>(arg0, 6, b"VOLT", b"VOLT AI by SuiAI", b"The world first Ai agent designed to trade using a fast closed loop.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000004534_18aa89859d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<VOLT>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<VOLT>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

