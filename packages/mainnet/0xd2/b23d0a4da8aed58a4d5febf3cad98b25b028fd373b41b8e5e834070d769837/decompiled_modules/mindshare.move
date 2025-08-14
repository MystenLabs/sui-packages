module 0xd2b23d0a4da8aed58a4d5febf3cad98b25b028fd373b41b8e5e834070d769837::mindshare {
    struct MINDSHARE has drop {
        dummy_field: bool,
    }

    fun init(arg0: MINDSHARE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2eTJqpK4QqWofGLSoirWNdC3Goyxp81KC3JDMqcupump.png?claimId=yfk1j2pYiM7bHfNA                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MINDSHARE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"mindshare   ")))), trim_right(b"mindshare                       "), trim_right(x"2046726f6d2046617420746f204669742c2042726f6b6520746f20426f73733a2054686520244d494e447368617265205265766f6c7574696f6e206973204845524521200a204974206d6967687420736f756e642077696c642061742066697273746372617a7920696465617320616c7761797320646f20756e74696c2074686579206265636f6d652073747261696768742d75702047454e4955532e204d7920756c74696d617465206d697373696f6e3f20456d706f776572696e6720594f5520746f2063727573682074686f736520657874726120706f756e64732c206275696c6420756e627265616b61626c65206865616c74682c20616e6420737461636b207265616c207765616c74682e2046617432526963683f204e61682c20746f6f20636c756e6b792e20456e74657220244d494e4473686172657468652073"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MINDSHARE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MINDSHARE>>(v4);
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

