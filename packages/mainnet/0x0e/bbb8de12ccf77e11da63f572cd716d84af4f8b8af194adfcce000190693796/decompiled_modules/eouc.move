module 0xebbb8de12ccf77e11da63f572cd716d84af4f8b8af194adfcce000190693796::eouc {
    struct EOUC has drop {
        dummy_field: bool,
    }

    fun init(arg0: EOUC, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/7PUPKmZPjfftzdeSL6qXWFLVznyoYVgSuCmyhe53T2qn";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/7PUPKmZPjfftzdeSL6qXWFLVznyoYVgSuCmyhe53T2qn"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<EOUC>(arg0, 9, trim_right(b"EOUC"), trim_right(b"EOUC  "), trim_right(b"EOUC "), v1, true, arg1);
        let v5 = v2;
        let v6 = 0x2::tx_context::sender(arg1);
        if (100000000000000000 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<EOUC>>(0x2::coin::mint<EOUC>(&mut v5, 100000000000000000, arg1), v6);
        };
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<EOUC>>(v5, v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<EOUC>>(v3, v6);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<EOUC>>(v4);
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

