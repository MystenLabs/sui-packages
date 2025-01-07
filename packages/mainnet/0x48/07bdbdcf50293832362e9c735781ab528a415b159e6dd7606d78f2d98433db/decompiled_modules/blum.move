module 0x4807bdbdcf50293832362e9c735781ab528a415b159e6dd7606d78f2d98433db::blum {
    struct BLUM has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUM, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUM>(arg0, 6, b"BLUM", b"Blue Monkey", x"424c5545204d4f4e4b45592c206275696c7420776974686f7574206d616a6f7220696e766573746f7273206f72207072652d6d696e696e672c206a7573742070757265206a6f7920616e6420636f6c6c65637469766520616d626974696f6e2e2057656c636f6d6520746f2074686520e2809c426c7565204d6f6e6b6579204d6f76656d656e742ce2809d20776865726520746865206f6e6c79206d616e74726120697320746f20656d627261636520746865206a6f75726e65792e20", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730963386884.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BLUM>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUM>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

