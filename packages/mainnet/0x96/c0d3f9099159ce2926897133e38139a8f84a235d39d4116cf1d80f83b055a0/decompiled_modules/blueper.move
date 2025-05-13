module 0x96c0d3f9099159ce2926897133e38139a8f84a235d39d4116cf1d80f83b055a0::blueper {
    struct BLUEPER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BLUEPER, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<BLUEPER>(arg0, 6, b"BLUEPER", b"Blueper", x"546865204c6567656e64206f6620424c55455045520a496e2074686520737769726c696e67206368616f73206f66207468652063727970746f2d76657273652c206f6e6520666f72636520726f73652061626f766520616c6c2d2d424c55455045522d2d626f726e2066726f6d2074686520667573696f6e206f662077617465722c2073746172647573742c20616e64207075726520636861696e20656e657267792e0a0a436c69636b2062656c6f7720746f2076657269667920796f752772652068756d616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000069574_fce42c9f64.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BLUEPER>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BLUEPER>>(v1);
    }

    // decompiled from Move bytecode v6
}

