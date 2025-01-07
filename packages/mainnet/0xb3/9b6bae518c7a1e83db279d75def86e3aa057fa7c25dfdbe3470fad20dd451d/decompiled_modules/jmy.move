module 0xb39b6bae518c7a1e83db279d75def86e3aa057fa7c25dfdbe3470fad20dd451d::jmy {
    struct JMY has drop {
        dummy_field: bool,
    }

    fun init(arg0: JMY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JMY>(arg0, 9, b"JMY", b"Jimmy", b"Just jim", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://file-walletapp.waveonsui.com/images/wave-pumps/5a97a158-fa4e-41ca-9d2f-44c3faf4f00b.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JMY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JMY>>(v1);
    }

    // decompiled from Move bytecode v6
}

