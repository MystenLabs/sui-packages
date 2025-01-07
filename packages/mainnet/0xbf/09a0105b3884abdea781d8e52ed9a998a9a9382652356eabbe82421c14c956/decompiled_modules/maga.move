module 0xbf09a0105b3884abdea781d8e52ed9a998a9a9382652356eabbe82421c14c956::maga {
    struct MAGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MAGA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MAGA>(arg0, 9, b"MAGA", b"TrumpMaGa", b"This is a cryptocurrency representing the presidential election of Donald J. Trump on the Sui ecosystem. MaGa will be a community coin, we are committed to this.", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5d4c5cec-3103-4b79-b2c9-91ac85aa8c78-IMG_0217.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MAGA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MAGA>>(v1);
    }

    // decompiled from Move bytecode v6
}

