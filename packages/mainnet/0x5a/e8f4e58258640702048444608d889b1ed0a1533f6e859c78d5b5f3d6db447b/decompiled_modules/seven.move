module 0x5ae8f4e58258640702048444608d889b1ed0a1533f6e859c78d5b5f3d6db447b::seven {
    struct SEVEN has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEVEN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEVEN>(arg0, 9, b"SEVEN", b"777", b"A selected number 777", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/749b56ae-0887-4b06-9001-948f36f37a4d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEVEN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEVEN>>(v1);
    }

    // decompiled from Move bytecode v6
}

