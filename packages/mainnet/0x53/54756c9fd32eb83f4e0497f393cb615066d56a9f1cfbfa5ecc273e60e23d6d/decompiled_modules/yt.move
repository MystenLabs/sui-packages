module 0x5354756c9fd32eb83f4e0497f393cb615066d56a9f1cfbfa5ecc273e60e23d6d::yt {
    struct YT has drop {
        dummy_field: bool,
    }

    fun init(arg0: YT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<YT>(arg0, 9, b"YT", b"HG", b"XB", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/12ebcf7e-b0d7-4e32-890d-99d3f4a9cb86.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YT>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<YT>>(v1);
    }

    // decompiled from Move bytecode v6
}

