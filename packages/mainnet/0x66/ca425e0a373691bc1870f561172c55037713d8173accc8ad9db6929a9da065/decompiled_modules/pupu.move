module 0x66ca425e0a373691bc1870f561172c55037713d8173accc8ad9db6929a9da065::pupu {
    struct PUPU has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUPU, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUPU>(arg0, 6, b"PUPU", x"537569205075507520f09f8c88", x"5373686820646f6ee28099742074656c6c20616e796f6e65206275742049207468696e6b202450555055206973202e2e2e200a4d6f737420736572696f75732070726f6a656374206f6e202453554920f09f8c8a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731945870133.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PUPU>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUPU>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

