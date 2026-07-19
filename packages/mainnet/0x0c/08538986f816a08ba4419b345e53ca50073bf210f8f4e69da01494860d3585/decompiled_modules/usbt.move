module 0xc08538986f816a08ba4419b345e53ca50073bf210f8f4e69da01494860d3585::usbt {
    struct USBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: USBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://arweave.net/UaRmRSRWZTTMwbjtmKc51fjj_utKJcdFsmeIpPlHhJk";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://arweave.net/UaRmRSRWZTTMwbjtmKc51fjj_utKJcdFsmeIpPlHhJk"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<USBT>(arg0, 9, trim_right(b"USBT"), trim_right(b"USBT  "), trim_right(b"decentralized, over-collateralized stablecoin issued by TRON DAO in collaboration with major institutions in the blockchain industry, designed to maintain a 1:1 peg to the US dollar."), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (10000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<USBT>>(0x2::coin::mint<USBT>(&mut v5, 10000000000000000, arg1), v6);
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

