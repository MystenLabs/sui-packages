module 0x16a8a515dc1a6a7f3492d1cb5bfa0a5e46c00cc288fbe787aacb364cd8250753::xxa {
    struct XXA has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/16gSha0NYIPaDeqHtbUV_oK2xBLHFcxkd5S1rTugER4";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/16gSha0NYIPaDeqHtbUV_oK2xBLHFcxkd5S1rTugER4"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XXA>(arg0, 9, trim_right(b"xxa"), trim_right(b"xxa  "), trim_right(b"526"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXA>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XXA>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXA>>(v4);
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

