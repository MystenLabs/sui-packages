module 0x4bee3fdb5abb68f25d1842c81c0f798297cf34eb49093fb1fac2edc85c25504d::grumpy {
    struct GRUMPY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<GRUMPY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<GRUMPY>>(0x2::coin::mint<GRUMPY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: GRUMPY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/hsVBN550pJWC6p_q?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRUMPY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRUMPY  ")))), trim_right(b"GRUMPY BEAR                     "), trim_right(b"I'm hearing whispers of a bear clan lurking in the crypto world. They're sniffing out those shit coins, the ones that promise the moon but deliver a rug pull. These bears are like crypto eliminators from scams! Gotta admire their dedication to cleaning up the dirt of digital finance.                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GRUMPY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<GRUMPY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<GRUMPY>>(0x2::coin::mint<GRUMPY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

