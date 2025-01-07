module 0x36a29bbc90d23da6ee040984695e4f12fef6b1a9e74d627cefe7a9847838bf0f::cat5 {
    struct CAT5 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CAT5, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CAT5>(arg0, 9, b"CAT5", b"5CAT", b"5CAT meme on SUI", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/708aa291-27b1-411c-8c45-6891f53a3ae7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CAT5>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CAT5>>(v1);
    }

    // decompiled from Move bytecode v6
}

