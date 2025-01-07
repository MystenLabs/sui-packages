module 0x4507f123e9152e8d3c50e3843a6deef1cd7b246d70733db24f1d6edb06a471e4::hipica {
    struct HIPICA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HIPICA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HIPICA>(arg0, 9, b"HIPICA", b"Hipili", b"Hipili is meme cat", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fc92f62b-6fd8-4cdb-b077-8dd689f42c61.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HIPICA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HIPICA>>(v1);
    }

    // decompiled from Move bytecode v6
}

