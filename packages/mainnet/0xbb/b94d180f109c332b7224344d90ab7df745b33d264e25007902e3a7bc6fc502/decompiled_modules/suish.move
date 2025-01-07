module 0xbbb94d180f109c332b7224344d90ab7df745b33d264e25007902e3a7bc6fc502::suish {
    struct SUISH has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUISH, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SUISH>(arg0, 6, b"SUISH", b"SUISHI", x"57656c636f6d6520746f205355495348492121204f6e6c792063686164732063616e20656174206d652c20746865726520617265206e6f20736561747320666f72206a65657473206174207468697320627566666574210a0a68747470733a2f2f742e6d652f2b2d636a3470645239383642694e6a646b0a68747470733a2f2f7375697368692e756e697665722e73652f", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Suishi_1781f34888.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUISH>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUISH>>(v1);
    }

    // decompiled from Move bytecode v6
}

