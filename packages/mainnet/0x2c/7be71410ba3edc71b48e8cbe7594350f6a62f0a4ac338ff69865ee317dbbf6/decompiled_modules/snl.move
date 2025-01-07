module 0x2c7be71410ba3edc71b48e8cbe7594350f6a62f0a4ac338ff69865ee317dbbf6::snl {
    struct SNL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SNL>(arg0, 9, b"SNL", b"Snail", b"slowly but steady", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/fb1142a3-febf-4306-beda-fa661fc45183.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SNL>>(v1);
    }

    // decompiled from Move bytecode v6
}

