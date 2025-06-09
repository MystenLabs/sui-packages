module 0x630c39163aa8cf260a1f6138ee4e67a32ce7d59c503bd87168cff74e03f8de3a::subr {
    struct SUBR has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUBR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111      ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmNvamCdp4LujzsGPgEzdErHW3AfBpaFHXx1vkPuomg4Kh                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUBR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUBR    ")))), trim_right(b"SuiBrowser                      "), trim_right(b"SuiBrowser is a decentralized web browser built on the Sui blockchain, offering a fast, private, and secure browsing experience. It connects with DeFi tools and decentralized storage, allowing users to explore dApps and manage digital assets easily. SuiBrowser brings Web3 browsing with enhanced privacy and control.    "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUBR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUBR>>(v4);
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

