module 0xd052032f910c12443d81c04533c78a036b2994739149f41e36230a8b7958d0d1::moonfun {
    struct MOONFUN has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOONFUN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<MOONFUN>(arg0, 6, b"MOONFUN", b"MOON FUN", x"576520617265206372656174696e67204d6f6f6e2e66756e2c206120706c6174666f726d20696e20646576656c6f706d656e7420776865726520796f752063616e2075706c6f616420616e642067697665207669736962696c69747920746f20796f75722070726f6a656374732c20696e20746865207374796c65206f6620747572626f732e66756e2c2070756d702e66756e206f72206d6f76652e70756d702c206275742077697468206f757220756e6971756520657373656e63652e0a536f6f6e20796f752077696c6c2062652061626c6520746f206a6f696e206120676c6f62616c20636f6d6d756e69747920746f2073686172652079", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1736622508705.webp")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOONFUN>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOONFUN>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

