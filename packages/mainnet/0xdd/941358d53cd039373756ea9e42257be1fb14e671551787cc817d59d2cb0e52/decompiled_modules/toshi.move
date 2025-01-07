module 0xdd941358d53cd039373756ea9e42257be1fb14e671551787cc817d59d2cb0e52::toshi {
    struct TOSHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOSHI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TOSHI>(arg0, 6, b"TOSHI", b"Toshi Tools", x"436865636b206f757420546f7368697320746f6f6c626f7820746f2068656c7020677569646520796f75206f6e20796f7572206a6f75726e657920746f206275696c64696e67206f6e205355492e20416c6c20746f6f6c7320617265206f70656e2d736f7572636520616e64207065726d697373696f6e6c6573732e2047657420696e73706972656420616e64207374617274206275696c64696e672e0a0a", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Toshi_6014089863.gif")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOSHI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOSHI>>(v1);
    }

    // decompiled from Move bytecode v6
}

