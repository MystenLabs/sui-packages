module 0x911caea89b418a85da7c8d7f26ae8d14171b47db5c4bc6a34ff02c5c77ec34af::ozd {
    struct OZD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZD>(arg0, 9, b"OZD", b"OZIDI", b"Not happy ", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8e1e20d0-cf89-432e-9194-ff2c59b1fcbf.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OZD>>(v1);
    }

    // decompiled from Move bytecode v6
}

