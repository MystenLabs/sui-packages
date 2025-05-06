module 0xef5bab2d5d6c9471e7af11e2039a62a978f7941cf9f12b92d098b7f919b2e768::hork {
    struct HORK has drop {
        dummy_field: bool,
    }

    fun init(arg0: HORK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3vwRWLxspNLiSENj3AuAYetnL8QiMbnzo8q7VyTRpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HORK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HORK        ")))), trim_right(b"half horse half shark           "), trim_right(x"484f524b2069732074776f207665727920646966666572656e7420616e696d616c7320667573656420696e746f206f6e65202065616368207769746820697473206f776e20756e6971756520616e642064697374696e637469766520706572736f6e616c6974792e2057686174206d616b6573206974207370656369616c3f2049747320612066726573686c7920626f726e206d656d6520696e20746865207661737420736561206f66206d61646e6573732e0a0a42726f2069732068616c6620686f7273652c2068616c6620736861726b2e204974732077696c642c206974732066756e2020736d696c653a2057686174206d616b657320757320646966666572656e74206d616b657320616c6c2074686520646966666572656e636520696e2074686520776f726c642e0a0a5370696e2077697468207573207468726f75"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HORK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HORK>>(v4);
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

