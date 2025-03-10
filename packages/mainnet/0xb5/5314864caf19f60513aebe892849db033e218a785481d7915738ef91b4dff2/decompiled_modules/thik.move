module 0xb55314864caf19f60513aebe892849db033e218a785481d7915738ef91b4dff2::thik {
    struct THIK has drop {
        dummy_field: bool,
    }

    fun init(arg0: THIK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"HE3o_u-tVwA-GNV3                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<THIK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Thik        ")))), trim_right(b"Thik Nik                        "), trim_right(x"5468696b204e696b207761736e7420616c776179732074686520746974616e206f66206b696e646e65737320616e6420616d626974696f6e20746861742070656f706c65206b6e6f7720746f6461792e20496e20666163742c206261636b207768656e206865207761732061206b69642c20686973206e65636b2077617320746865206669727374207468696e672065766572796f6e65206e6f74696365642e205768696c65206f74686572206b69647320776572652067657474696e672074656173656420666f7220746865697220627261636573206f7220636c6f746865732c205468696b204e696b2077617320616c7761797320746865207375626a656374206f66206c617567687465722062656361757365206f662074686520736865657220746869636b6e657373206f6620686973206e65636b2e0d0a0d0a416e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THIK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THIK>>(v4);
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

