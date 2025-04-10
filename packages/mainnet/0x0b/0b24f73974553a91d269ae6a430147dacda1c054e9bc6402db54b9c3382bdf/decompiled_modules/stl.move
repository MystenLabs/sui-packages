module 0xb0b24f73974553a91d269ae6a430147dacda1c054e9bc6402db54b9c3382bdf::stl {
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

