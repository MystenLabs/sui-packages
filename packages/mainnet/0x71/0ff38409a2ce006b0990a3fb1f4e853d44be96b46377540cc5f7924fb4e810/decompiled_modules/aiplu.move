module 0x710ff38409a2ce006b0990a3fb1f4e853d44be96b46377540cc5f7924fb4e810::aiplu {
    struct AIPLU has drop {
        dummy_field: bool,
    }

    fun init(arg0: AIPLU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<AIPLU>(arg0, 6, b"AIPLU", b"PLURALITY Community AI", x"2e2ee695b8e4bd8d20506c7572616c697479202e436c61696d20796f75722066726565202e45626f6f6b20504446204550554220417564696f626f6f6b202e2ee695b8e4bd8d20506c7572616c6974793a2054686520467574757265206f6620436f6c6c61626f72617469766520546563686e6f6c6f677920616e642044656d6f63726163792062792040676c656e7765796c2c204061756472657974202620636f6d6d756e6974792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/Plurality_png_e43be5be70.PNG")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<AIPLU>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AIPLU>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

