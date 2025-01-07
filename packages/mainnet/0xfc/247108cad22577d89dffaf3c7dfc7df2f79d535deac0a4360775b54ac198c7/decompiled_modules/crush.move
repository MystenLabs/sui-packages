module 0xfc247108cad22577d89dffaf3c7dfc7df2f79d535deac0a4360775b54ac198c7::crush {
    struct CRUSH has drop {
        dummy_field: bool,
    }

    fun init(arg0: CRUSH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CRUSH>(arg0, 6, b"CRUSH", b"Crush", x"53757266732075702c20647564652120202443525553482063727569736573207468726f7567682074686520537569204e6574776f726b206c696b65206120747275652073656120747572746c6520626f73732c206272696e67696e6720746865206368696c6c20766962657320616e64206c616964206261636b207374796c65207374726169676874206f7574206f66207468652062696720626c75652e20546f74616c6c7920747562756c6172210a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/PP_dbf8ed815c.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CRUSH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CRUSH>>(v1);
    }

    // decompiled from Move bytecode v6
}

