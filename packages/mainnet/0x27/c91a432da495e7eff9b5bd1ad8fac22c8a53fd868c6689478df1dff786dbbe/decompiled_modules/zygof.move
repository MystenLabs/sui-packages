module 0x27c91a432da495e7eff9b5bd1ad8fac22c8a53fd868c6689478df1dff786dbbe::zygof {
    struct ZYGOF has drop {
        dummy_field: bool,
    }

    fun init(arg0: ZYGOF, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ZYGOF>(arg0, 6, b"ZYGOF", b"Zygo The Frog", x"0a5a79676f2061696d7320746f206272696e672068756d6f7220616e642066756e20746f2074686520776f726c64206f662063727970746f63757272656e6369657320776974682069747320756e6971756520636f6e636570742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/froggy_6a5090fe85.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ZYGOF>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ZYGOF>>(v1);
    }

    // decompiled from Move bytecode v6
}

