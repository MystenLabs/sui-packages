module 0x82cfaf38f7a09405bcda88a80d8f5722fce0465a06c5c72e74403079b314d854::tn1p {
    struct TN1P has drop {
        dummy_field: bool,
    }

    fun init(arg0: TN1P, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9c2pSysY1pUUMq3jvRBeTEbtFbQLAvBpBTeUFoRpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TN1P>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TN1P        ")))), trim_right(b"The New 1%                      "), trim_right(b"Welcome to The New 1%   Where the Tables Turn Forget yachts, golf courses, and champagne towers built on your rent money  its time to rewrite the rules. The New 1% is more than just a meme coin; its a movement, a middle-finger to the old money elite who thought they'd keep all the spoils of the system. Spoiler alert: t"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TN1P>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TN1P>>(v4);
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

