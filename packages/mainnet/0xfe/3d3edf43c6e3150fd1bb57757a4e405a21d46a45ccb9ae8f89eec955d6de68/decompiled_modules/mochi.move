module 0xfe3d3edf43c6e3150fd1bb57757a4e405a21d46a45ccb9ae8f89eec955d6de68::mochi {
    struct MOCHI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<MOCHI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCHI>>(0x2::coin::mint<MOCHI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: MOCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x92072f045d0904e9a0cdfd48519f54c83bf41e82.png?size=lg&key=406f0d                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOCHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOCHI   ")))), trim_right(b"Mochi DeFi                      "), trim_right(x"54686520244d4f43484920546f6b656e2069736e2774206a75737420616e6f74686572206d656d65636f696e2c20697427732074686520686561727462656174206f6620746865204d6f63686920446546692065636f73797374656d2c20636f6d62696e696e67206d656d6520706f776572202b207574696c6974792e204d6f636869204e465473206172652064657369676e656420746f2073796e657267697a6520776974682074686520244d4f43484920546f6b656e2c20756e6c6f636b696e67206578636c7573697665207065726b732c20656e68616e636564207969656c6420706f74656e7469616c732c20616e64207370656369616c2066656174757265732e0020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<MOCHI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<MOCHI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<MOCHI>>(0x2::coin::mint<MOCHI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

