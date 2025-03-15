module 0x3fd40b6f460cea98c2b2f8f8090a84e921c98e164a36c83040880ea0e7fae0f6::comeb {
    struct COMEB has drop {
        dummy_field: bool,
    }

    fun init(arg0: COMEB, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COMEB>(arg0, 6, b"COMEB", b"SUI ComeBack", x"53756920436f6d656261636b2020546865206e6577206d65746120696e206d656d65636f696e732c206272696e67696e672074686520537569206d656d6520636f696e20776f726c64206261636b20746f206c69666521204c6574732070726f766520746f2065766572796f6e6520746861742069742063616e2070756d7020746f20746865206d696c6c696f6e732e20436f6d6d756e6974792d64726976656e2c20756e73746f707061626c652c20616e6420726561647920666f722074686520636f6d656261636b210a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000010986_472e4c6228.webp")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COMEB>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COMEB>>(v1);
    }

    // decompiled from Move bytecode v6
}

