module 0xc8819a31de491aa9e325a0320757dd27601fe11aad10afe704580ca80b32eb32::peai {
    struct PEAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEAI>>(0x2::coin::mint<PEAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/-c7tvgsAHKCdQKRg?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEAI    ")))), trim_right(b"PEPE AI                         "), trim_right(b"Ai Pepe is the first pepe to completely sync himself with AI technology. The goals for our pepe is to out run most of the other pepe coins and prove that AI is superior to basic flesh and bone. Like all robots different versions of AI pepe will be made along the way. Lets moon into a new age of technology, together.   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEAI>>(0x2::coin::mint<PEAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

