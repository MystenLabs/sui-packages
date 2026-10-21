module 0xcc4d04793bb61330e85bfa9c49c7f37a898d24c83735d7e20d4832d9436b0521::ahai {
    struct AHAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: AHAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://gateway.irys.xyz/4Hg8GK2bQBkjXMrXeyzBXjUauw4Qro7McLcV4mnruFfs                                                                                                                                                                                                                                                           ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<AHAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ahai    ")))), trim_right(b"ahai                            "), trim_right(b"China is an ancient civilization in East Asia with over 5,000 years of history. It is the world's second-largest economy and most populous country, comprising 56 ethnic groups. Today, it is a global leader in manufacturing, infrastructure, and technology.                                                                 "), v2, true, arg1);
        let v6 = v3;
        0x2::coin::mint_and_transfer<AHAI>(&mut v6, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AHAI>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AHAI>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AHAI>>(v5);
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

