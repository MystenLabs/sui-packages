module 0x63f9bb5a7e127d3cd2e10490ae1c4da0074e7d41d2a2f7dd8da282df3fe5cf9::olps {
    struct OLPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OLPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/e101y_gn7y3u_YRt18hLV5o7u2tbjU4UhC_kgVq8PbI";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/e101y_gn7y3u_YRt18hLV5o7u2tbjU4UhC_kgVq8PbI"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<OLPS>(arg0, 9, trim_right(b"OLPS"), trim_right(b"OLPS  "), trim_right(b"OLPSFAN"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OLPS>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<OLPS>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OLPS>>(v4);
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

