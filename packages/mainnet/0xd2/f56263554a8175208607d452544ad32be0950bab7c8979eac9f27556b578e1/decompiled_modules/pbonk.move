module 0xd2f56263554a8175208607d452544ad32be0950bab7c8979eac9f27556b578e1::pbonk {
    struct PBONK has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PBONK>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PBONK>>(0x2::coin::mint<PBONK>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PBONK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3m1RYZy5S92fJ8buo3nFBkYfQNxBSECTWDE5gPWebonk.png?size=lg&key=8d3ca8                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PBONK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PBONK   ")))), trim_right(b"Purple Bonk                     "), trim_right(b"BONK metas running and community are talking about it. Purple Bonk represents Bonk for Solana and was created to make Solana Hype Again. We are for the Sui we are for the $PBONK                                                                                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PBONK>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PBONK>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PBONK>>(0x2::coin::mint<PBONK>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

