module 0xd59e2c65205ed73a47222a7c0c411ae8ac6376b5baaa8cfd1a7cb998e7448557::apnut {
    struct APNUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: APNUT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<APNUT>(arg0, 6, b"APNUT", b"Aqua Peanut", x"57656c636f6d6520746f2041717561205065616e75742c2074686520717569726b69657374206d656d6520636f696e0a6d616b696e6720612073706c61736820696e207468652063727970746f206f6365616e21205468697320656363656e747269632c0a626c756520737175697272656c20776974682061207065616e7574206f6273657373696f6e20616e6420746f6e73206f660a6c61756768732c2062726f7567687420746f67657468657220616c6f6e672077697468206120636f6d6d756e6974790a77697468206d6f6f6e73686f7420706f74656e7469616c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732723889192.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<APNUT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<APNUT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

