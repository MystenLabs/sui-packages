module 0xe59bba3b64f3f447bee434f4df5189ee6007a95c485e626dbb9e865c879fec90::wcar {
    struct WCAR has drop {
        dummy_field: bool,
    }

    fun init(arg0: WCAR, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WCAR>(arg0, 9, b"WCAR", b"WIZARD CAR", x"205741564520f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65fdfdbb-8dbd-4aa9-8fa7-8ae53b816ad9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WCAR>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WCAR>>(v1);
    }

    // decompiled from Move bytecode v6
}

