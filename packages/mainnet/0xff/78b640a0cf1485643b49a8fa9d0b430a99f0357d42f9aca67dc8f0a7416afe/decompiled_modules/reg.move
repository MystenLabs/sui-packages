module 0xff78b640a0cf1485643b49a8fa9d0b430a99f0357d42f9aca67dc8f0a7416afe::reg {
    struct REG has drop {
        dummy_field: bool,
    }

    fun init(arg0: REG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<REG>(arg0, 6, b"REG", b"dbfdb", b"dbfdbd", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/2178374_w1400h1400c1cx700cy350cxt0cyt0cxb1400cyb700_e4a93593ea.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<REG>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<REG>>(v1);
    }

    // decompiled from Move bytecode v6
}

