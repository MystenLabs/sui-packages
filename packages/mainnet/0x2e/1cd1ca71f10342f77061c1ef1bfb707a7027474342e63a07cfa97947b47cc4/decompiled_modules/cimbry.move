module 0x2e1cd1ca71f10342f77061c1ef1bfb707a7027474342e63a07cfa97947b47cc4::cimbry {
    struct CIMBRY has drop {
        dummy_field: bool,
    }

    fun init(arg0: CIMBRY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<CIMBRY>(arg0, 6, b"CIMBRY", b"CimbryDogSui", x"43494d42525920697320612074696e792c20637572696f75732063726561747572652077686f206c6f76657320746f20686f702061726f756e6420616e64206578706c6f7265206e657720706c616365732e20416c7761797320757020666f7220616e20616476656e747572652c2043494d42525920656e6a6f79732068616e67696e67206f757420696e207468652077696c642c206c656170696e672066726f6d206f6e652066756e2073706f7420746f20616e6f746865722e0a0a436c69636b2062656c6f7720746f2076657269667920796f752772652068756d616e", 0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://api.movepump.com/uploads/1000001203_04d2d101bf.png")), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CIMBRY>>(v0, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CIMBRY>>(v1);
    }

    // decompiled from Move bytecode v6
}

