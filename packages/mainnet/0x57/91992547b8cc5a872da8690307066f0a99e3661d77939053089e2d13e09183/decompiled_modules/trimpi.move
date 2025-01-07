module 0x5791992547b8cc5a872da8690307066f0a99e3661d77939053089e2d13e09183::trimpi {
    struct TRIMPI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TRIMPI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TRIMPI>(arg0, 9, b"TRIMPI", b"Trump", b"President of America", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/346fc0cc-eec8-4600-a2bf-2410af0c800d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TRIMPI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRIMPI>>(v1);
    }

    // decompiled from Move bytecode v6
}

