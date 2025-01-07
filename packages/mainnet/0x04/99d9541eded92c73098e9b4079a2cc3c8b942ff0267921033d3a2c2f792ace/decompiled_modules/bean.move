module 0x499d9541eded92c73098e9b4079a2cc3c8b942ff0267921033d3a2c2f792ace::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 9, b"BEAN", b"MR. BEAN", x"4120746f6b656e2064656469636174656420746f20746865206775792077686f206d616465206d696c6c696f6e73206f66206368696c6472656e206c6175676820f09f9883", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/c6c7e469-6235-4fc6-b0c1-c5721b701257.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

