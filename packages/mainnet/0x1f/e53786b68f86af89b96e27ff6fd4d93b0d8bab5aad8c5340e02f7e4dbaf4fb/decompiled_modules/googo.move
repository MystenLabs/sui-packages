module 0x1fe53786b68f86af89b96e27ff6fd4d93b0d8bab5aad8c5340e02f7e4dbaf4fb::googo {
    struct GOOGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: GOOGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GOOGO>(arg0, 9, b"GOOGO", b"GO", b"Gooooooooooogo", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6d2950b2-78f1-4b08-abcd-3abcf63d2a9e.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GOOGO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GOOGO>>(v1);
    }

    // decompiled from Move bytecode v6
}

