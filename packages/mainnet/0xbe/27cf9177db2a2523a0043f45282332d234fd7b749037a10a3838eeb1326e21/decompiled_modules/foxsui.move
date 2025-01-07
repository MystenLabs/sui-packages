module 0xbe27cf9177db2a2523a0043f45282332d234fd7b749037a10a3838eeb1326e21::foxsui {
    struct FOXSUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: FOXSUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<FOXSUI>(arg0, 6, b"FOXSUI", b"FoxSui", x"496e74726f647563696e6720466f7879436f696e206f6e2074686520537569206e6574776f726b2120f09fa68ae29ca820546869732061646f7261626c65206d656d6520636f696e20626c656e647320636861726d20616e6420636f6d6d756e6974792c207065726665637420666f722063727970746f20656e74687573696173747320616e64206d656d65206c6f7665727320616c696b652e204a6f696e20757320666f7220612066756e20657870657269656e636520616e6420612076696272616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730469279319.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<FOXSUI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FOXSUI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

