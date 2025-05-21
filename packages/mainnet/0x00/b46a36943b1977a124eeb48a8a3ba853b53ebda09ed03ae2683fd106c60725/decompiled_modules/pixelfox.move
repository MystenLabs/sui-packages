module 0xb46a36943b1977a124eeb48a8a3ba853b53ebda09ed03ae2683fd106c60725::pixelfox {
    struct PIXELFOX has drop {
        dummy_field: bool,
    }

    fun init(arg0: PIXELFOX, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PIXELFOX>(arg0, 6, b"PIXELFOX", b"Pixel Fox", x"5374696c6c20776f6e646572696e6720776861742074686520666f7820736179732e2e0a0a504958454c464f58206973206865726520746f20616e737765722e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://ipfs.io/ipfs/bafkreibeuqsewqiwxqujlfjvgr54fjl7o4ohsgqpztzwtwgkc5sxfb5xt4")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PIXELFOX>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<PIXELFOX>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

