module 0xacdbe8ab93176d2c964c70bfbceb524904e824ce3eddc886ec9edf91a891e8b6::china {
    struct CHINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHINA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CHINA>(arg0, 6, b"China", b"CHINA", x"436f6d706172656420746f206f74686572204368696e65736520636f6e63657074730a0a576861742063616e2062657474657220726570726573656e74204368696e61207468616e20746865206e6174696f6e616c20666c61673f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1_1c9ceef1a8.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHINA>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHINA>>(v1);
    }

    // decompiled from Move bytecode v6
}

