module 0x764ad82bc5c45462e9336ff7cac580698dd6fadf3337a8839088a1f26e64ee68::daddya {
    struct DADDYA has drop {
        dummy_field: bool,
    }

    fun init(arg0: DADDYA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FLzAXpHrm3Cmh5SdxC8LNm7KLgrpyFt3uhx45hqc4biR.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DADDYA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DADDY       ")))), trim_right(b"DogeDaddy                       "), trim_right(x"202444414444592068617320617272697665642e0a4e6f74206a75737420616e6f74686572206d656d65636f696e202074686973206f6e652072616973657320444f47452e0a0a426f726e206f6e20536f6c616e612e204275696c7420666f72206368616f732e0a2048657320676f742062696c6c7320746f207061792c206469707320746f206275792c20616e64206b69647320746f20666565642e0a4e6f2070726f6d697365732c206a757374207075726520646567656e2066756e206261636b65642062792074686520776973646f6d206f662061206d656d65204f472e0a0a204c61756e636865643a204a756c792031300a205574696c6974793f20436f6d6d756e6974792e2056696265732e204d656d652063756c7475726520646f6d696e6174696f6e2e0a0a5768656e206f7468657273206261726b2e2e2e20"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DADDYA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DADDYA>>(v4);
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

