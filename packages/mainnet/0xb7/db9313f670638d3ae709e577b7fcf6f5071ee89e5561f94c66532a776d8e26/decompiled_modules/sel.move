module 0xb7db9313f670638d3ae709e577b7fcf6f5071ee89e5561f94c66532a776d8e26::sel {
    struct SEL has drop {
        dummy_field: bool,
    }

    fun init(arg0: SEL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SEL>(arg0, 9, b"SEL", b"SHELL", b"shells can be find in beaches or you can buy them here", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/01a1aacf-e37d-45da-a323-01c1417ff8ee.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SEL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SEL>>(v1);
    }

    // decompiled from Move bytecode v6
}

