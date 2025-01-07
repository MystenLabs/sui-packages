module 0xdf090c026b11c9db53d62a9023b531dfddeca06c07e88ec209a13858dc378ca3::finn {
    struct FINN has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FINN>(arg0, 6, b"FINN", b"finn the human", b"It's adventure time", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733006029352.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FINN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

