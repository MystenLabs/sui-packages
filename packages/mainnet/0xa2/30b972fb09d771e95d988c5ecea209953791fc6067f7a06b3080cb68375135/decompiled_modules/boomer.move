module 0xa230b972fb09d771e95d988c5ecea209953791fc6067f7a06b3080cb68375135::boomer {
    struct BOOMER has drop {
        dummy_field: bool,
    }

    fun init(arg0: BOOMER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"f16e8a60398efc576028f90e508152a862c30e264cac7053e886951a261e2f6f                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOOMER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOOMER      ")))), trim_right(b"Boomer                          "), trim_right(x"4f6e2074686520536f6c616e6120636861696e2c2061206e6577206c6567656e6420726973657320736c6f776c79206265636175736520686973206b6e65657320687572742e0a4d6565742024424f4f4d45522c20746865206d656d6520636f696e20706f77657265642062792070757265206e6f7374616c6769612c206f75746461746564206164766963652c20616e642074686520756e73746f707061626c652062656c69656620746861742063727970746f2077617320626574746572206261636b207768656e20426974636f696e206973207374696c6c2063686561702e0a24424f4f4d4552206973207468617420696e7465726e657420756e636c652077686f207374696c6c20747970657320696e20414c4c20434150532c2067697665732066696e616e6369616c20616476696365206e6f626f64792061736b"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BOOMER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BOOMER>>(v4);
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

