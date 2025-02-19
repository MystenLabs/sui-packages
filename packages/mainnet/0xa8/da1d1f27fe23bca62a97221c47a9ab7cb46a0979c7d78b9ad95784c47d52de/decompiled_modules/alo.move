module 0xa8da1d1f27fe23bca62a97221c47a9ab7cb46a0979c7d78b9ad95784c47d52de::alo {
    struct ALO has drop {
        dummy_field: bool,
    }

    fun init(arg0: ALO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ALO>(arg0, 9, b"ALO", b"Alone", b"just alone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/df7da94b-4e66-4150-a192-5d8be2194eb4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ALO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ALO>>(v1);
    }

    // decompiled from Move bytecode v6
}

