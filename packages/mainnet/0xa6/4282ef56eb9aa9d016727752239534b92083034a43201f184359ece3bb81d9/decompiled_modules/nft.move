module 0xa64282ef56eb9aa9d016727752239534b92083034a43201f184359ece3bb81d9::nft {
    struct NFT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NFT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NFT>>(0x2::coin::mint<NFT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NFT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/2iFnBisF4PRY2ahQQgA4xTqze51V88FCBM4h9c3M8HCg.png?size=lg&key=a7c18a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NFT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NFT     ")))), trim_right(b"National Fart Token             "), trim_right(b"$NFT is the official token for National Fart Day. A day where you can laugh about farts and celebrate them without shame. Its a day to embrace the natural and silly side of life because everyone does it!                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NFT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NFT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NFT>>(0x2::coin::mint<NFT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

