module 0x5409cf4e51d7f9108d838aecd40d75e7cf427f6b7ec0e34cf04ed0b786302509::husk {
    struct HUSK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUSK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HUSK>(arg0, 9, b"HUSK", b"Husk", b"Husky", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/d2b96e62-570f-40d6-b97e-e56a3df3c3b7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUSK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HUSK>>(v1);
    }

    // decompiled from Move bytecode v6
}

