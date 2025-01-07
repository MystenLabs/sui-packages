module 0xbcd47199385c26fae88ae48089a493403a664ad8a45f4614f8e4c797edf9e2e6::cnm {
    struct CNM has drop {
        dummy_field: bool,
    }

    fun init(arg0: CNM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CNM>(arg0, 9, b"CNM", b"Cinema", b"wach movie and buy tokens", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/cf696f7e-0294-45e8-9095-4c11acd5a52d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CNM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CNM>>(v1);
    }

    // decompiled from Move bytecode v6
}

