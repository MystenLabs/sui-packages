module 0xeb12c6fe4bcc0f94fcab9c46dd8eb84eb710ca9360a90f0b74429818bfacc37f::hfdh {
    struct HFDH has drop {
        dummy_field: bool,
    }

    fun init(arg0: HFDH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<HFDH>(arg0, 9, b"HFDH", b"HSFH", b"SG", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2184e5eb-b5e6-4d17-b4ea-996287720208.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HFDH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HFDH>>(v1);
    }

    // decompiled from Move bytecode v6
}

