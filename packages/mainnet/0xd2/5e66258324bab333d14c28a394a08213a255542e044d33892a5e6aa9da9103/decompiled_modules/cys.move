module 0xd25e66258324bab333d14c28a394a08213a255542e044d33892a5e6aa9da9103::cys {
    struct CYS has drop {
        dummy_field: bool,
    }

    fun init(arg0: CYS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/shuC8pI0ha21AUjk3mqaYqr_b_d6Lj8VtIYEhWHQIBo";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/shuC8pI0ha21AUjk3mqaYqr_b_d6Lj8VtIYEhWHQIBo"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<CYS>(arg0, 9, trim_right(b"CYS"), trim_right(b"CYS  "), trim_right(b"Cysic (Ticker: CYS) is the native utility token of Cysic Network, a pioneering ComputeFi and DePIN infrastructure focused on verifiable decentralized computation."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<CYS>>(0x2::coin::mint<CYS>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CYS>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<CYS>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CYS>>(v4);
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

