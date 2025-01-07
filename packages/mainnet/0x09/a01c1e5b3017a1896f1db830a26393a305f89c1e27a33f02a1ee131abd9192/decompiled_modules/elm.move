module 0x9a01c1e5b3017a1896f1db830a26393a305f89c1e27a33f02a1ee131abd9192::elm {
    struct ELM has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELM>(arg0, 9, b"ELM", b"Elon Musk ", b"Meme", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/2897948d-34e9-418b-9b3d-075326d19b59.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELM>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELM>>(v1);
    }

    // decompiled from Move bytecode v6
}

