module 0x21225fb685f4d86607b216d4d8c68ca10ed041e8966e38b2f22973d213f6f28b::fartgoat {
    struct FARTGOAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTGOAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"aeb92a739fd2076752b794efacca341845efd323708e34c12f0e44d698446850                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTGOAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTGOAT    ")))), trim_right(b"FARTGOAT                        "), trim_right(x"2446415254474f4154202d43544f0a496e20612064697374616e742063727970746f2067616c617879206c69766564207468652067726561742024476f6174202d20776973652c20706f77657266756c2c20616e6420756e7368616b61626c652e20427574206f6e65206461792c2061206d697363686965766f7573206372656174696f6e206275727374206f7574206f66206974732077616c6c6574202d207468652046617274696e6720476f617473202e20546865736520676f6174732077657265207370656369616c3a20657665727920666172742067656e657261746564206120636f736d696320696d70756c7365202c2073656e64696e6720746f6b656e7320737472616967687420746f20746865204d6f6f6e202e0a0a5768696c65202446617274436f696e2066696c6c65642074686520756e697665727365"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTGOAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTGOAT>>(v4);
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

