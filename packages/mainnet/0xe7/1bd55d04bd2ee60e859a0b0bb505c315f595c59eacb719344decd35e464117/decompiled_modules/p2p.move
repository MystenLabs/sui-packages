module 0xe71bd55d04bd2ee60e859a0b0bb505c315f595c59eacb719344decd35e464117::p2p {
    struct P2P has drop {
        dummy_field: bool,
    }

    fun init(arg0: P2P, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<P2P>(arg0, 6, b"P2P", b"Project 2 Percent", x"57656c636f6d6520746f2050726f6a65637420322050657263656e742c20776865726520616d626974696f6e206d6565747320616374696f6e20616e642067726561746e657373206973207265646566696e65642e20546869732069736e2774206a7573742061206d656d65636f696ee28094697427732061206d6f76656d656e742c2061206261646765206f6620686f6e6f7220666f722074686f73652077686f206461726520746f20647265616d206269676765722c2070757368206861726465722c20616e6420616368696576652077686174206f746865727320776f6e27742e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736066553809.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P2P>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<P2P>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

