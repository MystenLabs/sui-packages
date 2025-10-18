module 0x7a548b1b091457a1d9d4270042f141538b586235fc54398d9afb27b8e053ed7c::usdark {
    struct USDARK has drop {
        dummy_field: bool,
    }

    fun init(arg0: USDARK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"125b5d42da25f4c928fb76a0c5ce4524d32a9c5e63e129648071aa402ce247fd                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<USDARK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"USDARK      ")))), trim_right(b"Unstable Dark Coin              "), trim_right(b" $USDARK is not a regular meme token, it is a meme token powered by many services  We have USDARK DEX for spot and perp markets also USDARK INDICATOR + Many tools and services are being integrated into USDARK.APP  the improvements never stop                                                                               "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<USDARK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<USDARK>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        let v1 = &v0;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != v1) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

