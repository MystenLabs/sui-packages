module 0x89cbac62fe00d37208b441b6665d84dafb1c459b6fa042e9fd10a341cc50c918::x402 {
    struct X402 has drop {
        dummy_field: bool,
    }

    fun init(arg0: X402, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1721058fcd21e983cd11e5bb56d6a13bac7d6f45bb704ec6ef1611ad2e7acaa7                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<X402>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"x402        ")))), trim_right(b"this coin will do a             "), trim_right(b"imagine buying here and cooking a x402 pnl                                                                                                                                                                                                                                                                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<X402>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<X402>>(v4);
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

