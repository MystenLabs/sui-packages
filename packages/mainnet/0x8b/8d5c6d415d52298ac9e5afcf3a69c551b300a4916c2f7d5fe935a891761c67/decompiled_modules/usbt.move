module 0x8b8d5c6d415d52298ac9e5afcf3a69c551b300a4916c2f7d5fe935a891761c67::usbt {
    struct USBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/TJzKtt2Wx3Ixj4KaxlLovUhhQ5mQ4eVvvkBzA-XCMQo";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/TJzKtt2Wx3Ixj4KaxlLovUhhQ5mQ4eVvvkBzA-XCMQo"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USBT>(arg0, 9, trim_right(b"USBT"), trim_right(b"USTB"), trim_right(b"It is commonly used for cryptocurrency transactions, value storage, and cross-border payments, and has high liquidity."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USBT>>(0x2::coin::mint<USBT>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USBT>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USBT>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USBT>>(v4);
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

