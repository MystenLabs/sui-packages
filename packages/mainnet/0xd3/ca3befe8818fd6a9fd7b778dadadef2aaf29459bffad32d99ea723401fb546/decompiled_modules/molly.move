module 0xd3ca3befe8818fd6a9fd7b778dadadef2aaf29459bffad32d99ea723401fb546::molly {
    struct MOLLY has drop {
        dummy_field: bool,
    }

    fun init(arg0: MOLLY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HKk6dFGUJ68xrWUqwebqib4yQhDcHKppV29vmGvTbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<MOLLY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"MOLLY       ")))), trim_right(b"Sergeant Molly                  "), trim_right(x"4d65657420225365726765616e74204d6f6c6c79222c206120636f6d626174207261636f6f6e20696e20736572766963652077697468207468652036357468204d656368616e697a656420427269676164652e0a0a4d6f6c6c79206973206f6e6c79206120666577206d6f6e746873206f6c642c20627574207368652068617320616c7265616479206265636f6d65206120756e69742773206d6173636f742020636865657266756c20616e642061646f7261626c652e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<MOLLY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<MOLLY>>(v4);
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

