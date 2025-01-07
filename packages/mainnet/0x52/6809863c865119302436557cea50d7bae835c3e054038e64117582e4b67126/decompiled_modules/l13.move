module 0x526809863c865119302436557cea50d7bae835c3e054038e64117582e4b67126::l13 {
    struct L13 has drop {
        dummy_field: bool,
    }

    fun init(arg0: L13, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<L13>(arg0, 9, b"L13", b"Gilzen", b"A leader is one who knows the way, goes the way and shows the way", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/effa6f1e-8e41-4d18-b8c3-7e09c4fa4fa1.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<L13>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L13>>(v1);
    }

    // decompiled from Move bytecode v6
}

