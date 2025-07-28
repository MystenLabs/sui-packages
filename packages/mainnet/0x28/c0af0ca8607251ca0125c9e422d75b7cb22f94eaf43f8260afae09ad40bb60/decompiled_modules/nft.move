module 0x28c0af0ca8607251ca0125c9e422d75b7cb22f94eaf43f8260afae09ad40bb60::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3UofsdJQyTe8PF3HMUR8KEB13wtwGkk4qyAhgLCgbonk.png?claimId=BVTuGa4uphoHQgaN                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NFT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"nft         ")))), trim_right(b"nice fucking tits               "), trim_right(x"225765726520736561726368696e6720666f7220677265656e2074697473206f6e20746865206d6f6f6e20206a6f696e207573206f72206372792066726f6d2045617274682e220a4e696365204675636b696e20546974732028244e4654292069732061206d656d652d6675656c65642c20636f6d6d756e6974792d64726976656e206578706572696d656e7420626f726e2066726f6d20696e7465726e6574206368616f732c20646567656e65726163792c20616e6420756e636865636b656420696d6167696e6174696f6e2e204f7572206d697373696f6e3f0a546f20756e6974652074686520776f726c6473206d6f737420756e68696e676564206d656d65727320616e642073656172636820666f7220746865206c6567656e6461727920677265656e2074697473206f6e20746865206d6f6f6e2e0a0a5468657265"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NFT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NFT>>(v4);
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

