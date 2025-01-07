module 0x426dc66841519d55b767fc9813f6677b6adc4bafc3eecfd4848d67bb794c4f81::suitty {
    struct SUITTY has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUITTY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUITTY>(arg0, 6, b"SUITTY", b"SUI TTY", x"4974277320746865206461776e206f662061206e6577206572612e2e2e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Annotation_2024_10_14_232338_d555afbc75.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUITTY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUITTY>>(v1);
    }

    // decompiled from Move bytecode v6
}

