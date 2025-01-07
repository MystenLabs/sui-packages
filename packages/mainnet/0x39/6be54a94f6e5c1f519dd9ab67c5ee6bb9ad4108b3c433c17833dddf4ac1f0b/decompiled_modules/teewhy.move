module 0x396be54a94f6e5c1f519dd9ab67c5ee6bb9ad4108b3c433c17833dddf4ac1f0b::teewhy {
    struct TEEWHY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEEWHY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEEWHY>(arg0, 9, b"TEEWHY", b"Michael", b"My token ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/65886676-cc6c-40b0-9390-4129772202f9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEEWHY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEEWHY>>(v1);
    }

    // decompiled from Move bytecode v6
}

