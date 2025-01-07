module 0x45c29296c5b087c5296122d8fc1f4fa3e8c720a6894e1b14865e527db855f3ca::aze {
    struct AZE has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<AZE>(arg0, 6, b"AZE", b"AZERBAIJAN", x"546f6b656e20726570726573656e74696e6720417a65726261696a616e206f6e636861696e210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730532291405.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AZE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

