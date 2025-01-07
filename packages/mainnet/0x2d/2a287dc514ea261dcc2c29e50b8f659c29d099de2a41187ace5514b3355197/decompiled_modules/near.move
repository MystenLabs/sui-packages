module 0x2d2a287dc514ea261dcc2c29e50b8f659c29d099de2a41187ace5514b3355197::near {
    struct NEAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: NEAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NEAR>(arg0, 9, b"NEAR", b"Near", b"Near protocol", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7bff1bf4-3e4e-4871-98fc-d0c93069d0d9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NEAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NEAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

