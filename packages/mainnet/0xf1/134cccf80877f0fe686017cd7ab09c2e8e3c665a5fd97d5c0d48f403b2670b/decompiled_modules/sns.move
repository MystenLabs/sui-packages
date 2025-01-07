module 0xf1134cccf80877f0fe686017cd7ab09c2e8e3c665a5fd97d5c0d48f403b2670b::sns {
    struct SNS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNS>(arg0, 9, b"SNS", b"sunset", x"457870657269656e63652074686520676f6c64656e20686f757220776974682053756e736574436f696e3a2054686520676c6f77696e672063727970746f63757272656e637920746861742773206261736b696e6720696e2072616469616e742070726f6669747320616e64207061696e74696e67207468652063727970746f20736b79207769746820736861646573206f6620737563636573732120f09f8c87", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/88091f67-6693-4525-9c17-acf327c7eda9.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNS>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNS>>(v1);
    }

    // decompiled from Move bytecode v6
}

