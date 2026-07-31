module 0x1981bc709d8fbf31ec038ebfe1d9dfd96ad851170bca93e71dd388d49fd5c685::usdd {
    struct USDD has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/UaRmRSRWZTTMwbjtmKc51fjj_utKJcdFsmeIpPlHhJk";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/UaRmRSRWZTTMwbjtmKc51fjj_utKJcdFsmeIpPlHhJk"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USDD>(arg0, 9, trim_right(b"UsDD"), trim_right(b"USDD"), trim_right(b"USDD (Decentralized USD) is a decentralized, over-collateralized stablecoin designed to maintain a 1:1 peg to the US dollar. It is governed by the TRON DAO and operates natively on the TRON, Ethereum, and BNB Chain networks."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USDD>>(0x2::coin::mint<USDD>(&mut v5, 10000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDD>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<USDD>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDD>>(v4);
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

