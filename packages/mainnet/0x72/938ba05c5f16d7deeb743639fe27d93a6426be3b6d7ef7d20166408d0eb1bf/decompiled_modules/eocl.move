module 0x72938ba05c5f16d7deeb743639fe27d93a6426be3b6d7ef7d20166408d0eb1bf::eocl {
    struct EOCL has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOCL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ETsoslNcXXRUZ0BB                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<EOCL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EOCL        ")))), trim_right(b"eOracle                         "), trim_right(x"23232057656c636f6d6520746f2074686520654f7261636c6520436f6d6d756e69747921200d0a654f7261636c652069732074686520666972737420457468657265756d2d6e6174697665206f7261636c652c2064657369676e65642061732061206d6f64756c617220616e642070726f6772616d6d61626c652064617461206c61796572207365637572656420627920457468657265756d20616e64206275696c74207769746820456967656e4c617965722e205468696e6b206f6620654f7261636c652061732061206d61726b6574706c61636520666f7220646174612c2073696d696c617220746f20686f7720556e6973776170206f7065726174657320666f7220746f6b656e732e20576520617265206e6f7720657870616e64696e6720746f20536f6c616e612c204c61756e63682077696c6c206265206f666669"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EOCL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EOCL>>(v4);
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

