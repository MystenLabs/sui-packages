module 0xc5c82a1d4c2c8b08747a8ebe491931a89adca449e79ace13f4996cf3b768469a::rvai {
    struct RVAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RVAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RVAI>>(0x2::coin::mint<RVAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RVAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x8570b2804ae5b750a089c4b83149d68ace496205.png?size=lg&key=c7ccd3                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RVAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RVAI    ")))), trim_right(b"REVOX AI                        "), trim_right(b"REVOX AI is not just facilitating the technical groundwork for the next generation of AI-driven applications. We are also building a community and ecosystem by offering the tools and support necessary for everyone to contribute to and benefit from the vast potential of decentralized AI.                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RVAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RVAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RVAI>>(0x2::coin::mint<RVAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

