module 0xb1a614828b52f9fc9aff0302b9785d37c73a1a7fd023bc1e41d172d74ac95e52::pna {
    struct PNA has drop {
        dummy_field: bool,
    }

    fun init(arg0: PNA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PNA>(arg0, 9, b"PNA", b"Pirana", b"This is the cutest pirana you have ever seen hope you like it", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7f64bec9-8fe7-4027-bc55-7ae9038341c0.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PNA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PNA>>(v1);
    }

    // decompiled from Move bytecode v6
}

