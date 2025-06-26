module 0xc0bb95790faae42d0b443a00d628c0dfc7bd0d1468eaf7b97f96ce07d0b81374::humanrooms {
    struct HUMANROOMS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HUMANROOMS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/D3FSBSutRZvm8eiqynddSC93jfusf5dPPu2mxwxcpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HUMANROOMS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"humanrooms  ")))), trim_right(b"human backrooms                 "), trim_right(x"49206465706c6f796564207468697320746f20676f20616c6f6e6720776974682046617274636f696e0a0a57652077696c6c206372656174652061206e6963652065636f73797374656d2077697468207468697320626f74682070726f6a656374730a0a4920666f756e64206120636f6d6d756e69747920746861742077696c6c206265206c696e6b656420686572650a0a5768656e20746865206d6f6d656e7420636f6d657320492077696c6c20737570706f727420796f7520616c6c20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HUMANROOMS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HUMANROOMS>>(v4);
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

