module 0xca270595e71dde98eb4820953040c3745d8eb9bda47f2667a4b8906bfc122d0b::tg {
    struct TG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TG>(arg0, 6, b"TG", b"TurboGary", x"547572626f20476172792069732068657265212045766572796f6e652773206661766f7269746520736e61696c2066726f6d2053706f6e6765426f62206973206261636b2c2062757420746869732074696d652077697468206120747769737420e28094206865e280997320676f74206120747572626f20656e67696e6520696e7374656164206f662061207368656c6c21204e6f206d6f726520736c6f7720706163652e20547572626f2047617279206973207a6f6f6d696e6720737472616967687420746f20746865206d6f6f6e2120", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1730951694297.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TG>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TG>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

