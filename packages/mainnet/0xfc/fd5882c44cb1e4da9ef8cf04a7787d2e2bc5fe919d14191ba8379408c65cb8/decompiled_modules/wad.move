module 0xfcfd5882c44cb1e4da9ef8cf04a7787d2e2bc5fe919d14191ba8379408c65cb8::wad {
    struct WAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<WAD>(arg0, 9, b"WAD", b"WADOG", x"5761766520446f6720f09f90b620", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/a4dc56c1-b462-4da5-ac73-d69646c9f864.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAD>>(v1);
    }

    // decompiled from Move bytecode v6
}

