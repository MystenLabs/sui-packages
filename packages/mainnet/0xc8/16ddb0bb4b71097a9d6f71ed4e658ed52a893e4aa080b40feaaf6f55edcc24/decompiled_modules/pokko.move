module 0xc816ddb0bb4b71097a9d6f71ed4e658ed52a893e4aa080b40feaaf6f55edcc24::pokko {
    struct POKKO has drop {
        dummy_field: bool,
    }

    fun init(arg0: POKKO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<POKKO>(arg0, 9, b"POKKO", b"MamyPokko", b"The best Brand diapers in the world.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/f681e06a-6956-4d15-90b1-97c20d39f283.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POKKO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POKKO>>(v1);
    }

    // decompiled from Move bytecode v6
}

