module 0x62362a043a85805e9dcb607fe4de51972b1e636b9c76eee30dd468f8684d9b8e::dtc {
    struct DTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: DTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"58ef11d945341d0668a334e88047ab549ea4201894d54da6a9a01a502edca80d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DTC         ")))), trim_right(b"DATcoin                         "), trim_right(x"546865204d656d65636f696e20666f7220426974636f696e20547265617375726965732e200a4465666c6174696f6e617279206279206275726e696e67206261736564206f6e207472656173757279206163717569736974696f6e732e200a546865792062757920426974636f696e2c207765206275726e20444154636f696e2121210a4a6f696e2074686520445443206d6f76656d656e7420616e6420776174636820746865206275726e206675656c207468652066756e212121202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DTC>>(v4);
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

