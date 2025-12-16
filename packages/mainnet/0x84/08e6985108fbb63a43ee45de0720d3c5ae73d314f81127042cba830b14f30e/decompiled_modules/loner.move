module 0x8408e6985108fbb63a43ee45de0720d3c5ae73d314f81127042cba830b14f30e::loner {
    struct LONER has drop {
        dummy_field: bool,
    }

    fun init(arg0: LONER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"2a317fc1f41a21317d7149d6e263c42cfc14be67f4f14655d96336af72992a73                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LONER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"loner       ")))), trim_right(b"loner                           "), trim_right(x"244c4f4e45523a20576865726520596f757220496e646976696475616c69747920697320596f757220506f7765720a0a244c4f4e45522069736e74206a757374206120746f6b656e6974732061206d6f76656d656e742e20412063756c7420666f722074686f73652077686f20656d627261636520746865697220696e646976696475616c6974792c2077616c6b207468656972206f776e20706174682c20616e64206c697665206279207468656972206f776e2072756c65732e2049747320666f7220746865206f6e65732077686f20646f6e742066697420696e746f20616e796f6e6573206d6f6c642e20416c6f6e652c2062757420746f676574686572746861747320746865206d61676963206f6620244c4f4e45522e0a0a4a6f696e206f75722072617069646c792067726f77696e6720636f6d6d756e6974792061"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LONER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LONER>>(v4);
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

