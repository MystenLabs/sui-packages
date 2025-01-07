module 0xa6ceef9cdbd2e03bfcee6f3c9a86d1960d8aeec85afb16d63dd22ed332be36b8::nn {
    struct NN has drop {
        dummy_field: bool,
    }

    fun init(arg0: NN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<NN>(arg0, 9, b"NN", b"Nga Nguyen", b"nha mat pho bo lam to", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/95b60344-3a4c-4cd8-9ba7-4265b597d151.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NN>>(v1);
    }

    // decompiled from Move bytecode v6
}

