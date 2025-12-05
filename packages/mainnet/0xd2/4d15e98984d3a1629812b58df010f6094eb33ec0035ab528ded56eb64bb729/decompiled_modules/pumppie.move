module 0xd24d15e98984d3a1629812b58df010f6094eb33ec0035ab528ded56eb64bb729::pumppie {
    struct PUMPPIE has drop {
        dummy_field: bool,
    }

    fun init(arg0: PUMPPIE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"961c02e7636847f4303071dbd1ec5ee8ccced4a5d7e56a94177a0950f555e5f8                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PUMPPIE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PumpPie     ")))), trim_right(b"PumpPie                         "), trim_right(x"496e207468652077616b65206f662074776f206d616a6f7220686f6c69646179732077686572652066616d696c69657320676174686572202c20736f6d65686f772066696e64696e6720612077617920746f20414c574159532068617465206f6e2063727970746f202c20492070726573656e7420612077617920746f207265702074686520636f6c6f7273206f6620746865207472656e63686573206c696b65206e65766572206265666f726520200a0a2450756d705069652069732074686520554c54494d4154452043756c74206465737365727420746861742077696c6c206368616e67652046616d696c7920486f6c696461797320464f524556455220212121204f6e636520556e6320616e64204b6172656e2074616b652061206269746520746865726573206e6f20676f696e67206261636b2021212120546865"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PUMPPIE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PUMPPIE>>(v4);
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

