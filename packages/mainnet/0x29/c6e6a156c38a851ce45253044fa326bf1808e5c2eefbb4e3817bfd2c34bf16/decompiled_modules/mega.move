module 0x29c6e6a156c38a851ce45253044fa326bf1808e5c2eefbb4e3817bfd2c34bf16::mega {
    struct MEGA has drop {
        dummy_field: bool,
    }

    fun init(arg0: MEGA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/54DP5uoVyejXJzwrxT9W5TAfqQ1BDa88PVWnZudnsx9D.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MEGA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MEGA        ")))), trim_right(b"MemeAgeddon                     "), trim_right(x"244d454741206973206e6f74206a7573742061206d656d6520636f696e69747320612066756c6c2d626c6f776e206d656d65202a2a7265766f6c7574696f6e2a2a2e20412066696e616e6369616c206578706572696d656e74206675656c656420627920646567656e65726163792c20696e7465726e65742063756c747572652c20616e64206162736f6c757465206368616f732e204e6f2070726f6d697365732c204a75737420766962657320616e64206d6f6f6e20647265616d732e2045697468657220796f7520726964652077697468207573206f7220676574206c65667420626568696e6420696e206e6f726d6965206c616e642e200a0a57696c6c20697420313030783f2057696c6c2069742063726173683f2057686f206b6e6f77732e20427574206f6e65207468696e677320666f722073757265244d454741"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MEGA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MEGA>>(v4);
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

