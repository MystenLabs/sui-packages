module 0xb88be18477c151fd9759ff7c2509c7848f46b1db0793741c886db037d30be5f2::aest {
    struct AEST has drop {
        dummy_field: bool,
    }

    fun init(arg0: AEST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/9qHRzEMkjGfjpmwgqEzEPvOQWHRNKKjaYgsD9S8-TPg";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/9qHRzEMkjGfjpmwgqEzEPvOQWHRNKKjaYgsD9S8-TPg"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<AEST>(arg0, 9, trim_right(b"AEST"), trim_right(b"Aetheron Exchange Token"), trim_right(b"AEST is a blockchain based digital token deployed on public decentralized networks. It can be transferred between users, displayed in supported wallets, and priced through liquidity pools on decentralized exchanges. The token operates according to smart contract rules defined on-chain"), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (99999999000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<AEST>>(0x2::coin::mint<AEST>(&mut v5, 99999999000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AEST>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AEST>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AEST>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

