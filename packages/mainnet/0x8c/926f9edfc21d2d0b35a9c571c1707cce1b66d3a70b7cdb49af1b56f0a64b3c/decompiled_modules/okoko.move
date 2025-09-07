module 0x8c926f9edfc21d2d0b35a9c571c1707cce1b66d3a70b7cdb49af1b56f0a64b3c::okoko {
    struct OKOKO has drop {
        dummy_field: bool,
    }

    public entry fun mint(arg0: &mut 0x2::coin::TreasuryCap<OKOKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<OKOKO>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: OKOKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.pinata.cloud/ipfs/bafybeibijglzsvqvmxpdovd3k2rlehpubgssucovlfmwyvc7esdlplvxze";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.pinata.cloud/ipfs/bafybeibijglzsvqvmxpdovd3k2rlehpubgssucovlfmwyvc7esdlplvxze"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<OKOKO>(arg0, 9, b"OKOKO", b"OKOKO", b"OKOKO token on SUI blockchain", v1, true, arg1);
        let v5 = v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<OKOKO>>(0x2::coin::mint<OKOKO>(&mut v5, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OKOKO>>(v5, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<OKOKO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::CoinMetadata<OKOKO>>(v4, 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v6
}

