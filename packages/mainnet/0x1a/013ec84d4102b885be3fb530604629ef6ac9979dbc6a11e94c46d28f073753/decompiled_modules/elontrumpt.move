module 0x1a013ec84d4102b885be3fb530604629ef6ac9979dbc6a11e94c46d28f073753::elontrumpt {
    struct ELONTRUMPT has drop {
        dummy_field: bool,
    }

    fun init(arg0: ELONTRUMPT, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<ELONTRUMPT>(arg0, 6, b"ELONTRUMPT", b"ELON TRUMP MEME TABL", x"22456c6f6e5472756d70204d656d65205461626c65206d657267657320456c6f6e204d75736be280997320696e6e6f766174696f6e2c205472756d70e280997320626f6c646e6573732c20616e64206d656d652063756c7475726520696e746f20612068696c6172696f75732063727970746f20657870657269656e636521204120636f6d6d756e6974792d64726976656e206d656d65636f696e2077697468206578636c757369766520726577617264732c206c61756768732c20616e64206d656d65206d616769632e204a6f696e20746865207265766f6c7574696f6e20746f6461792120546f6b656e3a20454c4f4e5452554d505422", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732753115148.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ELONTRUMPT>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ELONTRUMPT>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

