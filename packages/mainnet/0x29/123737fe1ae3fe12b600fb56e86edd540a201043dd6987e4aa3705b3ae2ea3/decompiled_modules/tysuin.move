module 0x29123737fe1ae3fe12b600fb56e86edd540a201043dd6987e4aa3705b3ae2ea3::tysuin {
    struct TYSUIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: TYSUIN, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<TYSUIN>(arg0, 6, b"TYSUIN", b"MIKE TYSON", x"426520612077696e6e6572206c696b65204d696b650a426520612077696e6e6572206c696b6520537569", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000034254_7b61591357.jpg")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TYSUIN>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TYSUIN>>(v1);
    }

    // decompiled from Move bytecode v6
}

