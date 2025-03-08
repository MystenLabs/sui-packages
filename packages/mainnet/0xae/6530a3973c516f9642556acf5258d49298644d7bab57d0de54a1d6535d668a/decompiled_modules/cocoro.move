module 0xae6530a3973c516f9642556acf5258d49298644d7bab57d0de54a1d6535d668a::cocoro {
    struct COCORO has drop {
        dummy_field: bool,
    }

    fun init(arg0: COCORO, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<COCORO>(arg0, 6, b"COCORO", b"Cocoro", x"506c6561736520616c6c6f77206d6520746f20696e74726f64756365206f7572206e6577206e65776573742066616d696c79206d656d6265722c20436f636f726f2e0a546865206e616d6520636f6d65732066726f6d207468652020776f7264206b6f6b6f726f207768696368206d65616e7320686561727420696e204a6170616e6573652e20486f77657665722c20492077696c6c2062652063616c6c696e6720686572204b6f6b6f20666f722073686f727420616e6420492070726566657220746865207370656c6c696e6720436f636f2c20736f206865722066756c6c206e616d6520697320436f636f726f2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/Glh_Ig2_Ea_YAA_Drd_S_450d4b0a24.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<COCORO>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<COCORO>>(v1);
    }

    // decompiled from Move bytecode v6
}

