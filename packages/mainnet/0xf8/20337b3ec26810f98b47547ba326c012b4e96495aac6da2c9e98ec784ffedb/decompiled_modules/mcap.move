module 0xf820337b3ec26810f98b47547ba326c012b4e96495aac6da2c9e98ec784ffedb::mcap {
    struct MCAP has drop {
        dummy_field: bool,
    }

    fun init(arg0: MCAP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6umhVsHyJrrzuWcPQ2YVzEwohtBqJMBH4dtoc3Sqpump.png?claimId=Ee6McU95h1uqT52Q                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MCAP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"mcap        ")))), trim_right(b"market cap                      "), trim_right(x"244d4341502020546865204d61726b65742043617020497473656c660a0a5768696c65206576657279206f7468657220746f6b656e2069732063686173696e672061206d61726b6574206361702c2077652061726520746865206d61726b6574206361702e0a4e6f2067696d6d69636b732e204e6f20726f61646d6170732e204e6f2066616c73652070726f6d697365732e204a7573742070757265206d656d6520656e6572677920616e642072656c656e746c6573732067726f7774682e0a0a5765206c61756e636865642077697468206e6f2054656c656772616d2e204e6f20776562736974652e204a7573742076696265732e20416e6420697420776f726b65642e0a4e6f772074686520636170206973206c6976652c2074686520736974652069732075702c20616e6420746865207465616d206973206c6f636b65"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MCAP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MCAP>>(v4);
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

