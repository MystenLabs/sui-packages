module 0x51ba6539b0af9149d8529da416f6ba02f5a9e871138c37aef32c585f1967885a::ttb {
    struct TTB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TTB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CQSnLjG2nETFF8ea37LBCsDUvyX6XrD6DS6FQHtiBAGS.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TTB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TTB         ")))), trim_right(b"Text To Banger                  "), trim_right(x"546865206f776e6572206f662042616773646f7466756e2c2066696e6e62616773202c68616420616e206f6c642070726f6a656374206865206d61646520322079656172732061676f20746861742067656e6572617465642066756e6e792074776565747320666f7220757365727320746f2074776565742e0a0a576576652062726f756768742046696e6e73206964656120746f206c69666520616e642066696e6973686564206869732070726f6a6563742e2031302520676f657320746f2070726f6475637420646576656c6f706d656e7420616e642039302520676f657320746f2046696e6e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TTB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TTB>>(v4);
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

