module 0x61c8d47cb3944a735ae341341614ed51e28863e8fa89bab640e1ee5102466a8d::toby {
    struct TOBY has drop {
        dummy_field: bool,
    }

    fun init(arg0: TOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/Hxh5JQY45Aas92Ag3KTeZfcxQf1hnD1ZpoMk5cKBpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TOBY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TOBY        ")))), trim_right(b"toby the turtle                 "), trim_right(x"496e74726f647563696e6720546f62792074686520547572746c652c2061207374616e646f7574206368617261637465722062726f7567687420746f206c696665207468726f7567682074686520696e6e6f7661746976652070726f6d707473206f6620436861744750542d3464657369676e6564206e6f74206a75737420746f20726976616c20547572626f20546f61642062757420746f20666f7267652076616c7561626c6520667269656e64736869707320696e207468652063727970746f20636f6d6d756e6974792e20546f62792069732073657420746f206d616b65206578706c6f7369766520776176657320696e207468652063727970746f2073706163652c20656d626f6479696e672074686520737069726974206f6620636f6c6c61626f726174696f6e20616e64207065727365766572616e63652e0a0a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TOBY>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TOBY>>(v4);
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

