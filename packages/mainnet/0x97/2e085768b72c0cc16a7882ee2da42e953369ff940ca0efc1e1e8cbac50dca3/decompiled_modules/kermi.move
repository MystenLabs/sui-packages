module 0x972e085768b72c0cc16a7882ee2da42e953369ff940ca0efc1e1e8cbac50dca3::kermi {
    struct KERMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: KERMI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<KERMI>(arg0, 6, b"KERMI", b"Kerminator", x"4b65726d6974206973206261636b2c2062757420696e2061206d756368206e6577657220616e64207374726f6e67657220666f726d2c20616e6420686520697320726561647920746f2074616b65206f766572205355492c20627574206669727374206865206e6565647320746f2067617468657220666f6c6c6f776572732077686f2077696c6c20666967687420776974682068696d20696e20686973207570636f6d696e6720626174746c6573210a436f6d65204a6f696e206869732074656c656772616d2c20616e64206c65742068696d206b6e6f772069662068652063616e20636f756e74206f6e20796f7521", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1735773605697.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<KERMI>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<KERMI>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

