module 0xef06249fec65c63db8a9a74e772914a1630cbbaa00b8f8daa69cacacca2b492d::tpm {
    struct TPM has drop {
        dummy_field: bool,
    }

    fun init(arg0: TPM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TPM>(arg0, 9, b"TPM", b"Trumpmars", b"Trump is ready to take everyone to mars -hope your are not gonna miss out", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c3b7df53-d643-427d-8f88-137ce0a32f9a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TPM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TPM>>(v1);
    }

    // decompiled from Move bytecode v6
}

