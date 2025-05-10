module 0x799684adf7400ba59cba900dd9ad8706d0f90a1b7da7f832ba8fbb1b814ed5d8::bpd {
    struct BPD has drop {
        dummy_field: bool,
    }

    fun init(arg0: BPD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2AegcsRtVeSvoGRPDBSfTRRGH8YhU2RhgnqzgCLmd4oY.png?claimId=UCVD326M6Ptwj81j                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BPD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BPD         ")))), trim_right(b"Bitcoin Pizza Day               "), trim_right(x"43544f20464f5220323032350a5468652073746f7279206f66207468652031302c303030204254432070697a7a612063656c65627261746564206f6e204d61792032326e642065766572792079656172202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BPD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BPD>>(v4);
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

