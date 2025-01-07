module 0xb0177593316608abb2db20d2c04ef405c12d24eaec93f1795b6043dc83dc8161::bonkman {
    struct BONKMAN has drop {
        dummy_field: bool,
    }

    fun init(arg0: BONKMAN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BONKMAN>(arg0, 6, b"BONKMAN", b"Bonkman on sui", x"4d656d6f726965732077696c6c206265206d6164652e2054656172732077696c6c20626520736865642e0a46756e2077696c6c2062652061636869657665642e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/305402316_157062140308403_7310732045322400710_n_b6cebafe26.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BONKMAN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BONKMAN>>(v1);
    }

    // decompiled from Move bytecode v6
}

