module 0x5da6e09c3a26fb07da2a37d310b926314aa45b9a807735dd543c0febe50ddeb1::leo {
    struct LEO has drop {
        dummy_field: bool,
    }

    fun init(arg0: LEO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<LEO>(arg0, 6, b"LEO", b"LEONARDO", x"4c454f4e4152444f20284c454f2920697320612073616665206d656d652070726f6a65637420696e737069726564206279204c656f6e6172646f2064612056696e63692e0a57697468204c50206275726e65642c20776520656e7375726520736563757269747920616e642073746162696c6974792e0a536f6f6e2c20616e204e4654206d61726b6574706c6163652077696c6c206c61756e63682c20616e64204c454f2077696c6c20626520757365642061732061207061796d656e74206d6574686f642c20626c656e64696e67206172742c20626c6f636b636861696e2c20616e6420696e6e6f766174696f6e21", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1739032582499.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LEO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LEO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

