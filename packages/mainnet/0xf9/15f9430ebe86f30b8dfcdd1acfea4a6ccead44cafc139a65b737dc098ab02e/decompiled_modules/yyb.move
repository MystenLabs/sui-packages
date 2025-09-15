module 0xf915f9430ebe86f30b8dfcdd1acfea4a6ccead44cafc139a65b737dc098ab02e::yyb {
    struct YYB has drop {
        dummy_field: bool,
    }

    fun init(arg0: YYB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/HK0QlCvb9lHj-8l7ioBRkNzd180XDixbh0jBJfH_VQg";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/HK0QlCvb9lHj-8l7ioBRkNzd180XDixbh0jBJfH_VQg"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<YYB>(arg0, 6, trim_right(b"YYB"), trim_right(b"Oneyuancoin"), trim_right(b"Oneyuancoin (YYB) protocol is an on-chain transaction that supports cryptocurrencies while allowing users to provide liquidity for these markets."), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<YYB>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<YYB>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<YYB>>(v4);
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

