module 0x34cef9bd7ee9b55607748a52ed4c839761977fed65ece3e85c6848d13cf02b3e::xxoo {
    struct XXOO has drop {
        dummy_field: bool,
    }

    fun init(arg0: XXOO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/8xKAc6-31Q0qzjaA_9H90ThKrXYcsZqTeXBYTk5VTbU";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/8xKAc6-31Q0qzjaA_9H90ThKrXYcsZqTeXBYTk5VTbU"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<XXOO>(arg0, 9, trim_right(b"xxoo"), trim_right(b"xx"), trim_right(b"okkbig"), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XXOO>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<XXOO>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XXOO>>(v4);
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

