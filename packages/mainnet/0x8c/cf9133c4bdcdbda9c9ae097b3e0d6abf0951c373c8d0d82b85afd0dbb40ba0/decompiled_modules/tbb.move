module 0x8ccf9133c4bdcdbda9c9ae097b3e0d6abf0951c373c8d0d82b85afd0dbb40ba0::tbb {
    struct TBB has drop {
        dummy_field: bool,
    }

    fun init(arg0: TBB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BcL2J1w1E4Az6UXNDWfjYeRyMhp7QcNBDz9kHvqepump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TBB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TBB         ")))), trim_right(b"Top Blasters Babes              "), trim_right(x"546f7020426c6173746572732042616265732028544242290a2043656c6562726174696e67207468652066696572636520616e6420666162756c6f75732120207c20546f7020426c6173746572732042696720546974747920416e696d65204769726c7320776974682047756e7320207c2042696720447265616d732026204269676765722054697473207c204a6f696e2074686520616476656e74757265206f662067756e7320616e6420676c6f72792020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TBB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TBB>>(v4);
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

