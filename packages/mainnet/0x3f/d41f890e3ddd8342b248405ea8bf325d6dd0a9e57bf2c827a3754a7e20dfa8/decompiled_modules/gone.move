module 0x3fd41f890e3ddd8342b248405ea8bf325d6dd0a9e57bf2c827a3754a7e20dfa8::gone {
    struct GONE has drop {
        dummy_field: bool,
    }

    fun init(arg0: GONE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GONE>(arg0, 9, b"GONE", b"Gone", b"I Gone", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/7628ad0c-17e5-41cd-89e7-945d665a9a36.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GONE>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GONE>>(v1);
    }

    // decompiled from Move bytecode v6
}

