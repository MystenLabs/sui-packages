module 0xa29692a758e28785fe451f19f120580d7e224d651271e2e0440e1959d7106dad::fu {
    struct FU has drop {
        dummy_field: bool,
    }

    fun init(arg0: FU, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CDDybYjY6y7RBKXXaCKHRhUhb31y3rjGB7idTdeFpump.png?claimId=d2I4fwReFdrnsnti                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FU>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FU          ")))), trim_right(b"Farting Unicorn By Elon Musk    "), trim_right(b"Welcome to the realm of Farting Unicorn (FU), a project that began as a brainchild of none other than Elon Musk himself. Initially, it was just a tweeta picture that captured the imagination of the crypto world. But what started as a joke has evolved into something far more epic. The Farting Unicorn has now mutated int"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FU>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FU>>(v4);
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

