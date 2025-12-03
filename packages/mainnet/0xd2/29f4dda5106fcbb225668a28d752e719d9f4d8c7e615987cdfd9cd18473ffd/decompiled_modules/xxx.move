module 0xd229f4dda5106fcbb225668a28d752e719d9f4d8c7e615987cdfd9cd18473ffd::xxx {
    struct XXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"bd8c84d67bee37765faefd0f856a9c174f915c8d5f4c6cffeac19c153e7bc095                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XXX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XXX         ")))), trim_right(b"XXX                             "), trim_right(x"5858582053757065726865726f204d656d65636f696e2069732074686520666972737420576562332d706f77657265642073757065726865726f206672616e6368697365206275696c74206f6e20536f6c616e612e0a585858206973205468652050726f746563746f72206f6620446563656e7472616c697a6174696f6e2020636f6d62696e696e67206d656d652063756c747572652c2067616d696e672c204e4654732c20636f6d69632d6c6f726520616e6420636f6d6d756e6974792d64726976656e2073746f727974656c6c696e6720696e746f206f6e6520756e69666965642065636f73797374656d2e0a20436f72652046656174757265730a2053757065726865726f204e6172726174697665202b204d656d6520456e657267793a204120756e69717565206865726f2d64726976656e20495020706f77657269"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXX>>(v4);
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

