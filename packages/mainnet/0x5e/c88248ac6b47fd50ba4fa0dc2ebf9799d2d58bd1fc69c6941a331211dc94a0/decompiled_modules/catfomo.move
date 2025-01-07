module 0x5ec88248ac6b47fd50ba4fa0dc2ebf9799d2d58bd1fc69c6941a331211dc94a0::catfomo {
    struct CATFOMO has drop {
        dummy_field: bool,
    }

    fun init(arg0: CATFOMO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"11111111    ");
        let v1 = trim_right(b"https://gateway.irys.xyz/g912zi1mDf2QrEC5uDofdG8FO1kU7fkr_uR_-LEbHh8                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CATFOMO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CatFOMO ")))), trim_right(b"CatFOMO                         "), trim_right(b"CATFOMO is an innovative project merging MeMe culture with RWA (Real World Assets), born from the intersection of Web3, meme energy, and NFT collaborations. More than just a brand, CATFOMO empowers and connects communities through creative products, digital collectibles, and unique expressions                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CATFOMO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CATFOMO>>(v4);
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

