module 0x220b11eb77eb1138aeb3ddcd4c179f632bacfbda0a941ce06ec10b73434b5d9c::spong {
    struct SPONG has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPONG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPONG>(arg0, 9, b"SPONG", b"Sponge", x"53706f6e676520666f7220636c65616e696e6720796f7572206d6f6e657920f09f9280", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/80f9cc7e-f998-4f0f-b64e-c0549c6cc088.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPONG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SPONG>>(v1);
    }

    // decompiled from Move bytecode v6
}

