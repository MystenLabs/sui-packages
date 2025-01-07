module 0x397ad525d052e228f8ae86a69d1633d1db1ffb7116cea1c65da64714473e089c::jjc {
    struct JJC has drop {
        dummy_field: bool,
    }

    fun init(arg0: JJC, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<JJC>(arg0, 6, b"JJC", b"Joke Jingle Coin", x"4a6f6b654a696e676c65436f696e3a20576865726520636f6d656479206d656574732063727970746f21204c61756e6368696e672020746f206272696e67206c6175676874657220262070726f666974732e204a6f696e20746865207265766f6c7574696f6e2120f09f9a80f09f988420234a6f6b654a696e676c65436f696e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732432394567.jpeg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JJC>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JJC>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

