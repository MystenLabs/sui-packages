module 0x9520c7f9e0bd16d289e28679b9d9c5e86c9aa545d76ab870a9e2f5882ce6736c::az {
    struct AZ has drop {
        dummy_field: bool,
    }

    fun init(arg0: AZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://gateway.irys.xyz/ArNehLvy3wr5NXDGBYE6bems2JekPX72YzeRugxGr6KK                                                                                                                                                                                                                                                           ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<AZ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AZ      ")))), trim_right(b"AZ                              "), trim_right(b"                                                                                                                                                                                                                                                                                                                                "), v2, true, arg1);
        let v6 = v3;
        0x2::coin::mint_and_transfer<AZ>(&mut v6, 1000000000000, 0x2::tx_context::sender(arg1), arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<AZ>>(v6, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<AZ>>(v4, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<AZ>>(v5);
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

