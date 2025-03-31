module 0x731bdb1e5b43fb4978736e73d13fda093b8495e4a68ff9795e9c6f2645263fab::daa {
    struct DAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"1           ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmNwtc3mfBQi6vopPy6qMC6Kn3m5V17t9PHJ5NDeUYgUnZ                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"daa     ")))), trim_right(b"ddss                            "), trim_right(b"awdas                                                                                                                                                                                                                                                                                                                           "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DAA>>(v4);
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

