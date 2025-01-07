module 0x1a78db63c2e3a6182d11c6cf88680f258582291e60053c4ff1c0995ccbc005d6::teidn {
    struct TEIDN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TEIDN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TEIDN>(arg0, 9, b"TEIDN", b"jsndnx", b"bxudj", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/84e0d6b0-bbc7-4db3-8359-d256a5f234d7.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TEIDN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TEIDN>>(v1);
    }

    // decompiled from Move bytecode v6
}

