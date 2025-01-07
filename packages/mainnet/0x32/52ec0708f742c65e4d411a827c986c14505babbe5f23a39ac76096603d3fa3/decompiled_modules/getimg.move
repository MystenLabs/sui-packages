module 0x3252ec0708f742c65e4d411a827c986c14505babbe5f23a39ac76096603d3fa3::getimg {
    struct GETIMG has drop {
        dummy_field: bool,
    }

    fun init(arg0: GETIMG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GETIMG>(arg0, 6, b"GETIMG", b"Getimg.ai", x"4561737920746f2075736520414920546f6f6c7320666f722067656e65726174696e6720696d616765732066726f6d20746578742c20657870616e64696e672070686f746f732c206372656174696e6720766964656f73206f7220747261696e696e6720637573746f6d204149206d6f64656c732e205479706520776f7264732067657420636f6e74656e7420e28094206974e280997320746861742073696d706c652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735067294826.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GETIMG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GETIMG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

