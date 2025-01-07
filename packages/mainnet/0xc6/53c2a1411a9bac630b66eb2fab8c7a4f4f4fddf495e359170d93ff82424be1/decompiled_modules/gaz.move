module 0xc653c2a1411a9bac630b66eb2fab8c7a4f4f4fddf495e359170d93ff82424be1::gaz {
    struct GAZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GAZ>(arg0, 9, b"GAZ", b"Gazprom", x"d0a2d0bed0bad0b5d0bd20d0bad0bed0bcd0bfd0b0d0bdd0b8d0b82047617a70726f6d", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/82819942-98ae-411e-9193-a4064b002c49.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAZ>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GAZ>>(v1);
    }

    // decompiled from Move bytecode v6
}

