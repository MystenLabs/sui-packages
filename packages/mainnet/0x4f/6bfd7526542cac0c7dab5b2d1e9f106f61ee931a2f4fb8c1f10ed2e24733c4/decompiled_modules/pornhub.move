module 0x4f6bfd7526542cac0c7dab5b2d1e9f106f61ee931a2f4fb8c1f10ed2e24733c4::pornhub {
    struct PORNHUB has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PORNHUB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PORNHUB>>(0x2::coin::mint<PORNHUB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PORNHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/6e09e3e745d36ca16c23fe00d9895e66ca1444e6b4bd5ccc8cba8df2bae46797?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PORNHUB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PORNHUB ")))), trim_right(b"PornHub Official                "), trim_right(b"$PORNHUB serves as the native cryptocurrency of a leading adult content platform renowned for its extensive library of both amateur and professionally produced media  including videos, live shows, and exclusive photos.                                                                                                      "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PORNHUB>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PORNHUB>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PORNHUB>>(0x2::coin::mint<PORNHUB>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

