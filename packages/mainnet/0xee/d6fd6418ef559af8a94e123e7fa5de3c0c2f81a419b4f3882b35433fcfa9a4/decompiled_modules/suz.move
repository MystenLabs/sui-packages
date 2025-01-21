module 0xeed6fd6418ef559af8a94e123e7fa5de3c0c2f81a419b4f3882b35433fcfa9a4::suz {
    struct SUZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUZ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUZ>(arg0, 6, b"SUZ", b"Suzume", x"e2809c53757a756d6520436f696e3a204120426f6c64205374657020696e746f207468652046757475726521e2809d0a53757a756d652c2074686520616476656e7475726f75732073706172726f772c206c6561647320612063727970746f2070726f6a65637420626c656e64696e672066756e2c20696e6e6f766174696f6e2c20616e6420636f6d6d756e6974792e20486f6c6465727320756e6c6f636b206578636c7573697665204e4654732c20726577617264732c20616e64206576656e7473207469656420746f2053757a756d65e2809973206578636974696e67206a6f75726e65792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1737459536369.PNG")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SUZ>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUZ>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

