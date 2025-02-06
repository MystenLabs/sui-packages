module 0xacfcd17963e056bb24e5f4a582bcda8757a7cd8acd9dc483ba687a63516f438::xbl {
    struct XBL has drop {
        dummy_field: bool,
    }

    fun init(arg0: XBL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/58trKv2EJwL5MUo34hLEKizQe9df3EUkaA1RUtBJpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XBL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XBL         ")))), trim_right(b"Official Xbox Live Coin         "), trim_right(x"2057656c636f6d6520746f20746865204f6666696369616c2058626f78204c69766520546f6b656e202858424c29200a0a4a6f696e206f75722067616d65206c6f76696e6720636f6d6d756e697479206174202458424c200a0a2032342f372056430a204c6976652d73747265616d696e672067616d652d706c6179206f6e20547769746368210a204a6f696e207468652074656c656772616d20746f206c6561726e206d6f72652061626f757420414c4c206f66206f757220474956454157415953210a0a204f55522057454253495445204953204e4f57204c4956452121202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XBL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XBL>>(v4);
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

