module 0xa3dc2857ba40798ba163dfd1e91c9b7da9dc221369b1ea2536232ab56990001e::gai {
    struct GAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<GAI>(arg0, 6, b"GAI", b"Goosebump agent by SuiAI", x"4d656d657320617265206c696b6520796f7572206e657720706574732e20f09f90be20427574206e6f772c20796f752063616e2061637475616c6c792074616c6b20746f207468656d2120f09fa4af205769746820476f6f736570756d707341492c20796f7572202453554149206d656d6520746f6b656e206265636f6d657320616e2041492d706f7765726564206167656e742e204973207468617420636f6f6c206f7220776861743f20f09f9a80", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/473022063_1314061356211422_8157054386095665326_n_1_02c6ed2904.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<GAI>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GAI>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

