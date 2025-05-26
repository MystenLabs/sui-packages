module 0xabef418e4631c0f36c583f806073d3ca9a5ed4d183e767287fafe733f675ef69::ducxuan {
    struct DUCXUAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: DUCXUAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let (v1, v2) = 0x2::coin::create_currency<DUCXUAN>(arg0, 6, b"DUCXUAN", x"4475635875616e20436f696e20f09f9297", x"5468697320636f696e2069732061206b65657073616b65206f66206f7572206c6f766520616e6420746865206d6f6d656e7473207765207370656e7420746f6765746865722e204576656e2074686f7567682077652063616ee280997420626520746f67657468657220666f72657665722c20746865206d656d6f7269657320e2809320776865746865722068617070792c206a6f7966756c206f7220616e67727920e280932061726520616c6c2070726563696f75732e204c6f766520796f7520666f72657665722c2056554f4e47205448492054414d205855414e20f09f9297", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.suiai.fun/uploads/1000001481_04905e89ec.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<DUCXUAN>>(v2, v0);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DUCXUAN>>(v1, v0);
    }

    // decompiled from Move bytecode v6
}

