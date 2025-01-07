module 0x4f8c16dd72f0f4aef66a74f2ea8d74628c9d1be8a2e561b282a5c404fa6aa4b3::strwrs {
    struct STRWRS has drop {
        dummy_field: bool,
    }

    fun init(arg0: STRWRS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<STRWRS>(arg0, 6, b"STRWRS", b"STIR WIRS by SuiAI", b"The best lightsabers we never got to see as kids", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Stir_Wirs_f9283b5faa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STRWRS>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STRWRS>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

