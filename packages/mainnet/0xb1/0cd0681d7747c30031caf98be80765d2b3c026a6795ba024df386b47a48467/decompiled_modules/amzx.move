module 0xb10cd0681d7747c30031caf98be80765d2b3c026a6795ba024df386b47a48467::amzx {
    struct AMZX has drop {
        dummy_field: bool,
    }

    fun init(arg0: AMZX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"https://gateway.pinata.cloud/ipfs/bafybeiakyk5nr2zrufz5cpjufsyfcfhuao7lccbr6yktvd4elcshv3u4ey                                                                                                                                                                                                                                   ");
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v0))
        };
        let (v2, v3) = 0x2::coin::create_currency<AMZX>(arg0, 9, 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AMZX    ")))), trim_right(b"AmaZixAI Token                  "), trim_right(x"416d615a6978414920546f6b656e206675656c73206f757220636f6d6d756e697479207769746820656d706f7765726d656e7420616e642073686172656420737563636573730a4265796f6e64206265696e6720612063757272656e63792069742072657761726473206163746976652070617274696369706174696f6e20666f737465727320636f6c6c656374697665206f776e65727368697020616e6420676976657320657665727920686f6c6465722064697265637420696e666c75656e6365206f76657220706c6174666f726d206465636973696f6e7320696e20612076696272616e7420646563656e7472616c697a65642065636f73797374656d20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v1, arg1);
        let v4 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<AMZX>>(0x2::coin::mint<AMZX>(&mut v4, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AMZX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AMZX>>(v3);
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

