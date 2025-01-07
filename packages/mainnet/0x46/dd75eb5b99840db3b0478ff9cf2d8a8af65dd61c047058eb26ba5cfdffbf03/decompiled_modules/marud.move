module 0x46dd75eb5b99840db3b0478ff9cf2d8a8af65dd61c047058eb26ba5cfdffbf03::marud {
    struct MARUD has drop {
        dummy_field: bool,
    }

    fun init(arg0: MARUD, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MARUD>(arg0, 6, b"MARUD", b"Marud SUI", x"496620796f7527726520676f696e6720746f207761746368204f4e4520766964656f20647572696e672074686973204d656d65636f696e2053757065726379636c652e2e2e20576174636820746869732e0a0a323032352077696c6c206265207468652059656172207768657265204d656d65636f696e7320676f2050617261626f6c69632e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/murad_31613d2dfa.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MARUD>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MARUD>>(v1);
    }

    // decompiled from Move bytecode v6
}

