module 0x8bffd573cc9e623cc450365d21ecd5120ea659b1fad6291975d14862da73dce8::askai {
    struct ASKAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ASKAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ASKAI>>(0x2::coin::mint<ASKAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ASKAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DzAQ3JdDpJzxtvM43TtXEEzvGoCUnS1hAwUsKYr3gUbr.png?size=lg&key=4bcb35                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ASKAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AskAI   ")))), trim_right(b"Ask AI                          "), trim_right(b"Ask AI ($AskAI)  the token that unlocks the future of crypto with a dash of artificial intelligence! Inspired by the iconic \"Ask\" meme from the crypto world, $AskAI fuses humor with cutting-edge AI technology, creating a token thats as smart as it is fun.                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ASKAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ASKAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ASKAI>>(0x2::coin::mint<ASKAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

