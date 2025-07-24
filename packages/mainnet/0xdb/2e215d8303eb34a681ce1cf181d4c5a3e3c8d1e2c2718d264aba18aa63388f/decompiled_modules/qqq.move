module 0xdb2e215d8303eb34a681ce1cf181d4c5a3e3c8d1e2c2718d264aba18aa63388f::qqq {
    struct QQQ has drop {
        dummy_field: bool,
    }

    fun init(arg0: QQQ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"74c1209fc9bb8b5c6dfc1d8bf623a2e987c0dd71ddebfdc762d7fd1227b303cf                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<QQQ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"QQQ         ")))), trim_right(b"NASCRAQ                         "), trim_right(x"4f6e65204d697373696f6e20202343726171746865446171200a0a4e415343524151206973206120636f6d6d756e6974792d706f7765726564206d656d6520746f6b656e20666f72206d61726b657420616476656e74757265727320616e6420696e7465726e657420646567656e732e204a6f696e2074686520435241512054484520444151206d6f76656d656e74202d207768657265206761696e732c206d656d65732c20616e6420676f6f64207669626573206d6565742e2044726f7020796f75722062657374206d656d657320616e642068656c702073656e6420697420746f20746865206d6f6f6e206174206e6173637261712e636f6d200a0a284e6f7420616666696c6961746564207769746820616e792073746f636b2065786368616e67652e2920202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<QQQ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<QQQ>>(v4);
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

