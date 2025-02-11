module 0xf75444adcfa71436d31ed578e630a620d771ce3157174d46cd55873902607459::f1rstdue {
    struct F1RSTDUE has drop {
        dummy_field: bool,
    }

    fun init(arg0: F1RSTDUE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"69Uj15SsqokSluQ3                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<F1RSTDUE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"F1RSTDUE    ")))), trim_right(b"1ST RESPONDER COIN              "), trim_right(x"20464952535420524553504f4e44455220434f494e21200d0a2041204d4f56454d454e5420544f2048454c502052414953452041574152454e45535320544f204f555220464952535420524553504f4e44455253205354525547474c494e472057495448204d454e54414c204845414c54482028204d6f7265207468616e2077656c6c2065766572206b6e6f7729200d0a20204c6574732073656e64207468697320746f20746865206d6f6f6e212044657673206e657665722073656c6c696e6720617320686520697320612031737420526573706f6e64657220616e642077616e747320746f206d616b65206120646966666572656e636521200d0a20203173742044756520746f20746865206d6f6f6e2e200d0a20205820616e6420544720636f6d696e6720736f6f6e2e200d0a0d0a0d0a202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F1RSTDUE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<F1RSTDUE>>(v4);
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

