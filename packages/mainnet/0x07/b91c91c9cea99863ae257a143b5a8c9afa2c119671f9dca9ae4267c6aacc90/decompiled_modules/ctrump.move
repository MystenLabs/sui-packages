module 0x7b91c91c9cea99863ae257a143b5a8c9afa2c119671f9dca9ae4267c6aacc90::ctrump {
    struct CTRUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: CTRUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CTRUMP>(arg0, 6, b"cTrump", b"chinaTrump", x"4368696e61205472756d70204b616d616c6120456c656374696f6e204d414741204c47425451204a6f652057696e6e6965546865506f6f68204c6f636b686561644d617274696e205445534c41204d53545220426c61636b526f636b200a0a42757920746865204469702c0a73686f727420746865205649582c0a4655434b20424954434f494e2121212121", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/test_35d2fb566a.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CTRUMP>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CTRUMP>>(v1);
    }

    // decompiled from Move bytecode v6
}

