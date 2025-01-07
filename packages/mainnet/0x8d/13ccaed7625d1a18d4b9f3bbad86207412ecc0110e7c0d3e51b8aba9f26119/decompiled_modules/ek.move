module 0x8d13ccaed7625d1a18d4b9f3bbad86207412ecc0110e7c0d3e51b8aba9f26119::ek {
    struct EK has drop {
        dummy_field: bool,
    }

    fun init(arg0: EK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<EK>(arg0, 9, b"EK", b"Width ", b"Am sure you will be ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/379d00a0-e53c-4814-a73e-bfc402e1d8d6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EK>>(v1);
    }

    // decompiled from Move bytecode v6
}

