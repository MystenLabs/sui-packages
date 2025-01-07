module 0x88476b2abcee385f2e742dc751be98e4149d4b13794e193e73b9a4950ba0f9e4::hrum {
    struct HRUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: HRUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HRUM>(arg0, 9, b"HRUM", b"Hrum-hrum", b"Delicious cookies", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a2f24d31-090c-46c4-8c04-e28e23be88fd.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HRUM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HRUM>>(v1);
    }

    // decompiled from Move bytecode v6
}

