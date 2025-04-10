module 0xeab546560ebd627cb417cfb4efa2c6cc9acc53c4d61d545b623e90063adff522::stl {
    struct STL has drop {
        dummy_field: bool,
    }

    fun init(arg0: STL, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<STL>(arg0, 9, b"STL", b"STL", b"", 0x1::option::none<0x2::url::Url>(), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STL>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<STL>>(v1, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

