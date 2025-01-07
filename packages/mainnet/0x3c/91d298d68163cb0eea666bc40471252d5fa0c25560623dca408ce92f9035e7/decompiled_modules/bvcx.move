module 0x3c91d298d68163cb0eea666bc40471252d5fa0c25560623dca408ce92f9035e7::bvcx {
    struct BVCX has drop {
        dummy_field: bool,
    }

    fun init(arg0: BVCX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BVCX>(arg0, 9, b"BVCX", b"BCV", b"VXS", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/32e67071-f6f9-461c-a86c-0cb39528f94d.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BVCX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BVCX>>(v1);
    }

    // decompiled from Move bytecode v6
}

