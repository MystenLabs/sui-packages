module 0x3f86bb20965892c1829c0f927544d3f5dd9d239ff5e417ba35728eed216ad03c::batnana {
    struct BATNANA has drop {
        dummy_field: bool,
    }

    fun init(arg0: BATNANA, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BATNANA>(arg0, 6, b"BATNANA", b"BananaBat", x"486920746865726521203a290a42616e616e61426174206973206120766572792072617265206b696e64206f6620626174207768696368206f6e6c79206170706561727320696e20657665727920312f313030303030206261742066616d696c6965732c20736865206973206865726520746f20676f2062616e616e6173202870756e20696e74656e64656429203a440a4c65747320676f20746f2044455820746f67657468657220776974682068657221", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735926145583.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BATNANA>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BATNANA>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

