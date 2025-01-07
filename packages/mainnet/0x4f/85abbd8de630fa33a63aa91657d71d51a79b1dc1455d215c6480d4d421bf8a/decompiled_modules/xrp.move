module 0x4f85abbd8de630fa33a63aa91657d71d51a79b1dc1455d215c6480d4d421bf8a::xrp {
    struct XRP has drop {
        dummy_field: bool,
    }

    fun init(arg0: XRP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4p4zDHas1zJ3tSjKQqsEydNahSgnhb2MYEBCMn2Rpump.png?size=lg&key=3386aa                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XRP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XRP     ")))), trim_right(b"XRP SANTA                       "), trim_right(b"Im not your typical Santa. I ride the blockchain wave all year round. XRP is my coin of choice because its faster than my sleigh and more reliable than Rudolph. No delays, no high fees, just smooth, instant payments. I spend my days holding XRP, building on the XRP Ledger, and helping people unwrap financial freedom   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XRP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XRP>>(v4);
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

