module 0x89e344f63b7a2f7335637252a2011b7c3f295acbb3dffa4bd3d82914c31c9e07::wagmi {
    struct WAGMI has drop {
        dummy_field: bool,
    }

    fun init(arg0: WAGMI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BitUBQPCfhTD4P2EX3hbjoXNjWyKyujtkHmxvCmpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WAGMI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"WAGMI       ")))), trim_right(b"Wagmi AI                        "), trim_right(x"4f66666572696e6720706f77657266756c206175746f6d6174696f6e20746f6f6c7320746f207265766f6c7574696f6e697a6520796f75722074726164696e6720657870657269656e63650a0a42757920262053656c6c20546f6b656e73206174206c696768746e696e67207370656564732c20736574206175746f6d6174656420747261646520626f7473207468617420656e68616e636520796f75722070726f6669746162696c69747920726174696f2c20616e642073636f757473206f75742061626e6f726d616c20766f6c756d6520616e6420696e746572616374696f6e73206561726c696572207468616e20616c6c206f7468657220626f74732120202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WAGMI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WAGMI>>(v4);
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

