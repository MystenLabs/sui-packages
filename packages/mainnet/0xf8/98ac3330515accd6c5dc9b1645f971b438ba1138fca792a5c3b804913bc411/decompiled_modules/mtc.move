module 0xf898ac3330515accd6c5dc9b1645f971b438ba1138fca792a5c3b804913bc411::mtc {
    struct MTC has drop {
        dummy_field: bool,
    }

    fun init(arg0: MTC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/FSpfzKUFnhwUkaP9iSnuA7ZQCQUHMVbXbbtzL1vGpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MTC>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MTC         ")))), trim_right(b"Monkey Toshi Coin               "), trim_right(x"244d5443203a205377696e672066726f6d2050697879204d6f6e6b6579277320636172746f6f6e206368616f7320737472616967687420696e746f204e465420676f6c642e204372656174656420627920746865206c6567656e64617279204d6f6e6b657920546f7368692c2061206368617261637465722066726f6d20746865207361726361737469632c2063757272656e742d6576656e74732d64726976656e2050697879204d6f6e6b657920616e696d61746564207365726965732e202046726f6d206d6f6e6b65797320746f206d6f6e6b6579732c2063686173696e67206d656d6520647265616d732c20206c65742773206d616b65204d54432062756c6c69736820616761696e20616e642068656172207468652063726f776427732073637265616d7321200a427920534b53545544494f444556202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MTC>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MTC>>(v4);
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

