module 0xf92cfd7073da5cc4542f15655c3e466290711f853615fef0fc5aef96a7dac3da::finagent {
    struct FINAGENT has drop {
        dummy_field: bool,
    }

    fun init(arg0: FINAGENT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/J8qK7YBXVAr17MiBEgUTZZvD8rrcdPuoSYSuR8R3pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FINAGENT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FINAGENT    ")))), trim_right(b"Fin Agent AI                    "), trim_right(x"4f7074696d697a6520796f75722066696e616e63657320776974682046696e4167656e742e0a0a457870657269656e63652074686520706f776572206f6620414920696e206d616e6167696e6720796f75722066696e616e6365732e2046696e4167656e742073696d706c69666965732066696e616e6369616c207461736b732c2070726f766964657320736d61727420736f6c7574696f6e732c20616e642068656c707320796f752074616b6520636f6e74726f6c206f6620796f7572206d6f6e6579206566666f72746c6573736c792e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FINAGENT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FINAGENT>>(v4);
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

