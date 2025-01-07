module 0x73dec627b7c0110d329533d6d791e155463d65a15c2dbc90a1f14ad362650ea1::ci8 {
    struct CI8 has drop {
        dummy_field: bool,
    }

    fun init(arg0: CI8, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CI8>(arg0, 9, b"CI8", b"coin88", b"Nft88", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/092f9102-13e2-4194-88bb-ac512079a11b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CI8>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CI8>>(v1);
    }

    // decompiled from Move bytecode v6
}

