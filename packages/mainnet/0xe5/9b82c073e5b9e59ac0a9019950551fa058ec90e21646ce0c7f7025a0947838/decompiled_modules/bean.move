module 0xe59b82c073e5b9e59ac0a9019950551fa058ec90e21646ce0c7f7025a0947838::bean {
    struct BEAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BEAN>(arg0, 9, b"BEAN", b"MR. BEAN", x"5468697320746f6b656e2069732064656469636174656420746f20746865206775792077686f206d61646520746865206368696c64686f6f64206f66206d696c6c696f6e73206f66206368696c6472656e20617765736f6d6520e29da4efb88f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/6926e46f-385b-43b7-8b5e-032b2bd7462a.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

