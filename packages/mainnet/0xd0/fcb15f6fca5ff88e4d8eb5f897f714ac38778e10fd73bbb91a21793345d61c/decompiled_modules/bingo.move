module 0xd0fcb15f6fca5ff88e4d8eb5f897f714ac38778e10fd73bbb91a21793345d61c::bingo {
    struct BINGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: BINGO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BINGO>(arg0, 6, b"BINGO", b"BINGO on SUI", x"42696e676f2069732061206c6974746c652062616c6c206f6620656e657267792120536865e2809973206b696e642c20637572696f75732c2064657465726d696e656420616e64206c6f76657320746f206c617567682e204d6f7265207468616e20616e797468696e672c20736865206c6f76657320646976696e6720696e746f2070726574656e642067616d657320776974682068657220626967207369737465722c20426c7565792c20746865697220667269656e64732c20616e642066616d696c792e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1733457946875.png")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BINGO>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BINGO>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

