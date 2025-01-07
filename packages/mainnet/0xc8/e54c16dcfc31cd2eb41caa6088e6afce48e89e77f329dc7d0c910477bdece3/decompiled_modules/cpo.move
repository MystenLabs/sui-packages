module 0xc8e54c16dcfc31cd2eb41caa6088e6afce48e89e77f329dc7d0c910477bdece3::cpo {
    struct CPO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CPO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CPO>(arg0, 9, b"CPO", b"Capito", b"It's a community project created under the supervision of knowledgeable crypto minners", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/9350fe6f-bed1-4c7b-afa1-edb9b3a857e6.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CPO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CPO>>(v1);
    }

    // decompiled from Move bytecode v6
}

