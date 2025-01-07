module 0x69614c4aa9497b9b245dcff26994ba4c098ab3d704420c49078e3a276dd02cf5::ozd {
    struct OZD has drop {
        dummy_field: bool,
    }

    fun init(arg0: OZD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<OZD>(arg0, 9, b"OZD", b"OZIDI", b"Not happy", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c485160e-0325-4c2c-b25e-c98ee9d0e8d4.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OZD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<OZD>>(v1);
    }

    // decompiled from Move bytecode v6
}

