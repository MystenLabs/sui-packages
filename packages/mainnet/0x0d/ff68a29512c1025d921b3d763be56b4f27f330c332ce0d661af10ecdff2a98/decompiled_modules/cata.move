module 0xdff68a29512c1025d921b3d763be56b4f27f330c332ce0d661af10ecdff2a98::cata {
    struct CATA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CATA>(arg0, 9, b"CATA", b"CatAi", b"0xc51ec44bd909c291dea18c6a5d3c3a2cbc1a04f0174c36be274439226e8c2175", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/1fa2c0bd-a9de-44b9-8cf0-61a00f44286c.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CATA>>(v1);
    }

    // decompiled from Move bytecode v6
}

