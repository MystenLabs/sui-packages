module 0xf01dbfb3517bf10e7bc724f413dadc4f40a7539b825f54b20963b79b9b2261fa::guguk {
    struct GUGUK has drop {
        dummy_field: bool,
    }

    fun init(arg0: GUGUK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GUGUK>(arg0, 9, b"GUGUK", b"Cuckoo", x"4375636b6f6f206269726420746f6b656e2e20546865206375636b6f6f2066616d696c7920696e636c7564657320746865c2a0636f6d6d6f6e206f72204575726f7065616e206375636b6f6f2cc2a020726f616472756e6e6572732cc2a06b6f656c732cc2a06d616c6b6f6861732cc2a0636f7561732cc2a0636f7563616c732c20616e64c2a0616e69732e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/8a991f5f-7e2c-4292-8903-5dcfae694270.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GUGUK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GUGUK>>(v1);
    }

    // decompiled from Move bytecode v6
}

