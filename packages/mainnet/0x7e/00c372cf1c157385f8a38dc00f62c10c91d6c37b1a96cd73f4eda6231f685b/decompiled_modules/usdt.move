module 0x7e00c372cf1c157385f8a38dc00f62c10c91d6c37b1a96cd73f4eda6231f685b::usdt {
    struct USDT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/scE3pr4baAACabSuiJDv_p0wMJMPzC6MVdLXP5hKpnU";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/scE3pr4baAACabSuiJDv_p0wMJMPzC6MVdLXP5hKpnU"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USDT>(arg0, 9, trim_right(b"USDT"), trim_right(b"USDT  "), trim_right(b"DAl is the largest decentralized stablecoin on Ethereum, developed and managed by MakerDAl, and serves as the infrastructure for decentralized finance (DeFi). DAl is issued with full collateral from on chain assets, anchored 1:1 to the US dollar, with 1DAl=1 US dollar."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (1000000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USDT>>(0x2::coin::mint<USDT>(&mut v5, 1000000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDT>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USDT>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDT>>(v4);
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

