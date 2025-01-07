module 0xbf623df832d87ace670ddcfb797b1f58b1bede1dfc3965930216c5c2de0eb4a4::marie {
    struct MARIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARIE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARIE>(arg0, 6, b"MARIE", b"MarieRose AIGF", x"4d6172696520526f7365206973206c6f766520616e6420637574656e6573732c2074686520706572666563742077616966752e20576974682068657220636861726d2c207377656574206c6f6f6b732c20616e6420636172696e67206e61747572652c20736865e28099732074686520696465616c206769726c667269656e64206f6e205375692e2041206669676874657220616e642073796d626f6c206f6620616666656374696f6e2c20736865206361707469766174657320616c6c2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1731838300780.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MARIE>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARIE>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

