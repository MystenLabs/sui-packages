module 0xc3ff5c60912c348c6537446d7fd6354f2e60461b91a02bf0d8290b51465f7ff9::puipui {
    struct PUIPUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUIPUI, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<PUIPUI>(arg0, 6, b"PUIPUI", b"PUIPUI on SUI", x"50756920507569206f6e205375690a0a50756920507569204d6f6c63617220284a6170616e6573653a2050554920505549202c204865706275726e3a2050756920507569204d6f72756b2c20225075692050756920436176792d436172222920", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/l1ogo_x_0fd71fbf0f.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUIPUI>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUIPUI>>(v1);
    }

    // decompiled from Move bytecode v6
}

