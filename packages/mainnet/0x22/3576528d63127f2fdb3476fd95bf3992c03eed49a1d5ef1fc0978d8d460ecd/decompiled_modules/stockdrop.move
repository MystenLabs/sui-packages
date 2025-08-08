module 0x223576528d63127f2fdb3476fd95bf3992c03eed49a1d5ef1fc0978d8d460ecd::stockdrop {
    struct STOCKDROP has drop {
        dummy_field: bool,
    }

    fun init(arg0: STOCKDROP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4418114641296624ef6ea67c818d6c48301dbbc97d61db9ba68e7d854432dcdd                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<STOCKDROP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"STOCKDROP   ")))), trim_right(b"StockDrop                       "), trim_right(x"53746f636b44726f702069732061207265766f6c7574696f6e617279207265776172647320746f6b656e206f6e20536f6c616e612e20486f6c64206f757220636f696e20616e6420726563656976652061697264726f7073206f6620746f702041492050726553746f636b732065766572792035206d696e75746573200a0a382520746178206170706c696564206f6e206576657279206275792c2073656c6c2c20616e64207472616e73666572207472616e73616374696f6e2e0a0a3535252069732064697374726962757465642061732041492050726553746f636b20746f6b656e73206469726563746c7920746f20686f6c646572732e0a0a34302520746f206d61726b6574696e672c2064656469636174656420746f20657870616e64696e67206f757220726561636820616e6420636f6d6d756e6974792067726f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<STOCKDROP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<STOCKDROP>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

