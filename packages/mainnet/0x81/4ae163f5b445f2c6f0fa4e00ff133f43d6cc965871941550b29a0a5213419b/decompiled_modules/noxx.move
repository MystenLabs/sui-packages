module 0x814ae163f5b445f2c6f0fa4e00ff133f43d6cc965871941550b29a0a5213419b::noxx {
    struct NOXX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NOXX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4XDy2wo7qwLVWnB5npC4C1kxzq9CALt2PCmx398ipump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NOXX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Noxx        ")))), trim_right(b"Noxx surgery fund               "), trim_right(x"4e6f787820537572676572792046756e6420546f6b656e0a0a546865204e6f787820537572676572792046756e6420546f6b656e206973206d6f7265207468616e206a7573742061206d656d65636f696e6974732061206d6f76656d656e742e2043726561746564206f6e20536f6c616e61207669612070756d7066756e2c207468697320746f6b656e20776173206c61756e6368656420746f2068656c7020636f7665722074686520706564696174726963206e6575726f7375726765727920636f73747320666f72206d79206e6577626f726e20736f6e2c2077686f2077617320646961676e6f7365642077697468206174726574696320656e63657068616c6f63656c65612072617265206e657572616c20747562652064656665637420616666656374696e6720627261696e20646576656c6f706d656e742e0a0a57"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NOXX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NOXX>>(v4);
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

