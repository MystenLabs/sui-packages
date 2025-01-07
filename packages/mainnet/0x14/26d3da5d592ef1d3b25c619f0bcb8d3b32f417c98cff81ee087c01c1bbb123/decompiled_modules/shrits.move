module 0x1426d3da5d592ef1d3b25c619f0bcb8d3b32f417c98cff81ee087c01c1bbb123::shrits {
    struct SHRITS has drop {
        dummy_field: bool,
    }

    fun init(arg0: SHRITS, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<SHRITS>(arg0, 6, b"SHRITS", b"Shrimp spirits", x"4120636f6d626f206f66202453504952495420616e642024534852494d502c20746f67657468657220776520617265207374726f6e676572210a0a4254572c206d6179626520646f6e27742062757920746869732e2e2e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://r.turbos.finance/icon/1732193066698.jpg")), arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<SHRITS>>(v1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SHRITS>>(v0, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

