module 0xb0e56c5b3765dc44c1729099cb63054403b1c2587b9666509561db06a240da83::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WAGMI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WAGMI>>(0x2::coin::mint<WAGMI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/G2Hbv2Pu1xeVdkdAhqTc8mBN4TZ3hghdTGejM9zWgMi.png?size=lg&key=37591a                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WAGMI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WAGMI   ")))), trim_right(b"We're All Going To Make It!     "), trim_right(b"\"WAGMI\" means \"We're All Gonna Make It.\" It's a popular acronym in crypto and NFT communities. It expresses optimism and unity, suggesting everyone will succeed. Often used as a motivational phrase during tough times. Think: \"Markets down, but WAGMI!\"                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WAGMI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WAGMI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<WAGMI>>(0x2::coin::mint<WAGMI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

