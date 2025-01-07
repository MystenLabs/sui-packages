module 0x8db81cabb42334c78c2c0912aaa5de0b4eed7008887a1be69f3a6af192561f46::suirihno {
    struct SUIRIHNO has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUIRIHNO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUIRIHNO>(arg0, 6, b"SuiRihno", b"Sui Rihno", x"5375695269686e6f2069732061206d656d6520636f696e206275696c740a6f6e20746865206661737420616e6420656666696369656e74205375690a626c6f636b636861696e2e20496e737069726564206279207468650a737472656e67746820616e6420726573696c69656e6365206f66207468650a7268696e6f2c205375695269686e6f206272696e67730a746f67657468657220612066756e20636f6d6d756e69747920776974680a736572696f757320706f74656e7469616c2e204a6f696e2075732061730a77652063686172676520616865616420696e746f207468650a776f726c64206f662063727970746f21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000003065_031cb131a9.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUIRIHNO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUIRIHNO>>(v1);
    }

    // decompiled from Move bytecode v6
}

