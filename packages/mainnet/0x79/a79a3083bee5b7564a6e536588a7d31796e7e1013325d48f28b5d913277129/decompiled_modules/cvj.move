module 0x79a79a3083bee5b7564a6e536588a7d31796e7e1013325d48f28b5d913277129::cvj {
    struct CVJ has drop {
        dummy_field: bool,
    }

    fun init(arg0: CVJ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AzTY6pQpKfiDeRaT5HB5DiKRjMQGsvRRotZgvYSpZZtu.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CVJ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CVJ         ")))), trim_right(b"CHAD Vs JEET                    "), trim_right(x"2043686164205673204a65657420282443564a29202054686520556c74696d617465204d656d652057617220426567696e73206f6e20536f6c616e61210a0a537465702061736964652c206e6f726d69657320202443564a206973206865726520746f2063726f776e207468652074727565206b696e6773206f662063727970746f2e2043686164205673204a656574206973206d6f7265207468616e206a7573742061206d656d65636f696e202069742773206120626174746c65206f6620636f6e76696374696f6e2076732e2070616e69632c20737472656e6774682076732e207765616b6e6573732043484144207673204a4545542e0a0a496e2074686973207a65726f2d73756d2067616d65206f66206d656d657320616e64206d61726b6574732c204368616473206172652072657761726465642e204469616d6f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CVJ>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CVJ>>(v4);
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

