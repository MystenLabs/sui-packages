module 0xb3be823582443f8d629ba76f8e625c8d5807a1dadfedf610a3fd75dfd508cbaf::mybot {
    struct MYBOT has drop {
        dummy_field: bool,
    }

    fun init(arg0: MYBOT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CHg6qLapQhtkJmUAR8k93PEB6ZUB1aD71NH9cMTTpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MYBOT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MYBOT       ")))), trim_right(b"MyBot                           "), trim_right(x"204d79426f7420697320612063757474696e672d6564676520706c6174666f726d2064657369676e656420746f20656d706f77657220757365727320746f2063726561746520706572736f6e616c697a65642041492d706f776572656420626f7473206566666f72746c6573736c792e20200a0a5768657468657220666f7220627573696e6573732c20706572736f6e616c207573652c206f722063727970746f206f7065726174696f6e732c204d79426f7420636f6d62696e657320616476616e636564206172746966696369616c20696e74656c6c6967656e63652077697468207468652073706565642c207363616c6162696c6974792c20616e64207365637572697479206f6620536f6c616e617320626c6f636b636861696e2e0a0a2d2043726561746520437573746f6d20426f74730a2d20496e74656772617465"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MYBOT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MYBOT>>(v4);
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

