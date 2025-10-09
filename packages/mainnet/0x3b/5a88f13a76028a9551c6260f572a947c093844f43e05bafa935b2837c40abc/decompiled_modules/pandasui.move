module 0x3b5a88f13a76028a9551c6260f572a947c093844f43e05bafa935b2837c40abc::pandasui {
    struct PANDASUI has drop {
        dummy_field: bool,
    }

    fun init(arg0: PANDASUI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/aEL4d4ZLL9yPkxcvqgUEaVzw4a0rDwHZyF1Fz79sprg";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/aEL4d4ZLL9yPkxcvqgUEaVzw4a0rDwHZyF1Fz79sprg"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<PANDASUI>(arg0, 6, trim_right(b"PandaSui"), trim_right(b"PandaSui  "), trim_right(b"PandaSui "), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PANDASUI>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<PANDASUI>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PANDASUI>>(v4);
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

