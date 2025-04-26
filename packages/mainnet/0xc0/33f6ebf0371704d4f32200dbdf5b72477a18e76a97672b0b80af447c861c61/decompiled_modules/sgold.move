module 0xc033f6ebf0371704d4f32200dbdf5b72477a18e76a97672b0b80af447c861c61::sgold {
    struct SGOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SGOLD>(arg0, 6, b"SGOLD", b"SGOLD Game", x"53474f4c442069732061206d696e696e672d626173656420576562332067616d65206275696c74206f6e2074686520537569204e6574776f726b2e20506c61796572732061637175697265206c616e642c206465706c6f79206d696e65727320616e6420746f6f6c732c20616e64206561726e2053474f4c4420746f6b656e73207468726f75676820626c6f636b2d62792d626c6f636b20656d697373696f6e732e205468652073797374656d20697320696e73706972656420627920426974636f696ee28099732068616c76696e67206d6f64656c20616e6420666f6c6c6f77732061206465666c6174696f6e61727920726577617264207374727563747572652e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://sgold.fun/assets/logo-icon.png")), arg1);
        let v2 = v0;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SGOLD>>(v1);
        0x2::coin::mint_and_transfer<SGOLD>(&mut v2, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGOLD>>(v2, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

