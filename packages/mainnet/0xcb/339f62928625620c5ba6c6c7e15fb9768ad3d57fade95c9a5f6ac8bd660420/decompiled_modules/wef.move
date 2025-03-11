module 0xcb339f62928625620c5ba6c6c7e15fb9768ad3d57fade95c9a5f6ac8bd660420::wef {
    struct WEF has drop {
        dummy_field: bool,
    }

    fun init(arg0: WEF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/5JWUrdzz3b8j2KSQ8VJwvs28ZTzB5H4hevdE7hkYpump.png?claimId=fLzCwX5HtGMycPRv                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WEF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"wef         ")))), trim_right(b"wef6900                         "), trim_right(b"Welcome to WEF6900, a revolutionary blockchain cryptography token designed to challenge the corrupt media and the World Economic Forum. Imagine a decentralized future where the narrative is no longer controlled by elites but powered by the peopleall packed into little tiny crypto coins.                                 "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<WEF>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<WEF>>(v4);
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

