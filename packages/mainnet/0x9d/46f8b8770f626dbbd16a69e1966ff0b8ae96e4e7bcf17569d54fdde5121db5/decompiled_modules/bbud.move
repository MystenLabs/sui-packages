module 0x9d46f8b8770f626dbbd16a69e1966ff0b8ae96e4e7bcf17569d54fdde5121db5::bbud {
    struct BBUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BBUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BBUD>(arg0, 9, b"BBUD", b"ByteBuddy", x"4120736f6369616c20746f6b656e20666f72206469676974616c20636f6d70616e696f6e736869702e2053656e6420424255447320746f2073686f7720617070726563696174696f6e2c207469702063726561746f72732c206f72206275696c642072657075746174696f6e206163726f737320706c6174666f726d732e2054686520667269656e646c6965737420746f6b656e206f6e2d636861696e20e28094207768657265206b696e646e6573732069732063757272656e63792e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://fun-be.7k.fun/api/file-upload/5941dca112fccecb6b036baee63cec01blob")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BBUD>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BBUD>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

