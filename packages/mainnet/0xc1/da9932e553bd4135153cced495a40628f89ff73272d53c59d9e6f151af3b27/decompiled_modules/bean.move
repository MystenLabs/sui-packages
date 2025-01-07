module 0xc1da9932e553bd4135153cced495a40628f89ff73272d53c59d9e6f151af3b27::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 9, b"BEAN", b"MR. BEAN", x"4120746f6b656e2064656469636174656420746f20746865206775792077686f206d616465206d696c6c696f6e73206f66206368696c6472656e206c6175676820f09f9883", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/859da535-89ef-44a5-9bbf-708f9754381a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

