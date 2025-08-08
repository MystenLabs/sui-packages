module 0xccb7be38cd0c8456cb31df11160adfaa2c63ec576d54df8bf6976cc941bcd20::yeti {
    struct YETI has drop {
        dummy_field: bool,
    }

    fun init(arg0: YETI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6b6b83730824ab82c825392a4dc39611ac528b6127dd98991b7f6478f7cacd78                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<YETI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"YETI        ")))), trim_right(b"YETI DYOR                       "), trim_right(x"59455449206973206865726520746f20686176652066756e2c206d616b65206e6f6973652c20616e64206272696e672070656f706c6520746f676574686572207468726f756768206d656d65732c2063756c747572652c20616e64206368616f732e0a4120706c61636520776865726520617274697374732c20646567656e732c20616e6420696e7465726e6574206d6973666974732063616e206275696c6420736f6d657468696e672077696c642d746f6765746865722e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YETI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YETI>>(v4);
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

