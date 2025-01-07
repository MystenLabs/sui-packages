module 0x53fd073ab1469329c5d83c126f7029cb51b2fc56608167d7c0a7fda770f8ae6e::spark {
    struct SPARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: SPARK, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SPARK>(arg0, 6, b"Spark", b"Spark The Mascot", x"4044657075747953656353746174650a20686f737465642061207072657373206272696566696e6720746f6765746865722077697468204a6170616e65736520416d6261737361646f7220746f2074686520552e532e2c2053686967656f2059616d6164612c20746f20686967686c6967687420746865200a405553415f506176696c696f6e5f0a20617420234558504f3230323520696e636c7564696e6720746865207075626c69632072657665616c206f66207468652055534120506176696c696f6e206d6173636f742c20537061726b2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/QRISTAL_d2e9bca62e.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SPARK>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SPARK>>(v1);
    }

    // decompiled from Move bytecode v6
}

