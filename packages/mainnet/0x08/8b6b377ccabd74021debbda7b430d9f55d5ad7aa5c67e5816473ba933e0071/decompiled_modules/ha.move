module 0x88b6b377ccabd74021debbda7b430d9f55d5ad7aa5c67e5816473ba933e0071::ha {
    struct HA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HA>(arg0, 9, b"HA", b"Hi", b"His", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/b883beea-189e-41bd-8942-c31f88266848.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HA>>(v1);
    }

    // decompiled from Move bytecode v6
}

