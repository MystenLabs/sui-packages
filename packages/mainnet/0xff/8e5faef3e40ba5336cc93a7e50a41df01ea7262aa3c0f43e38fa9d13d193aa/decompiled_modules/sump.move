module 0xff8e5faef3e40ba5336cc93a7e50a41df01ea7262aa3c0f43e38fa9d13d193aa::sump {
    struct SUMP has drop {
        dummy_field: bool,
    }

    fun init(arg0: SUMP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"1111        ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmQ4oLuMH3tqsqLnKYjcDtLmZaMooYmYfZurTZEv5cAHPx                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SUMP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SUMP    ")))), trim_right(b"PUMP on SUI                     "), trim_right(b"SUMP is the PUMP on Sui, bringing up liquidity from the depths. Decide the future of this 100% decentralized project, with 0% chance of dev dumps. 100% in locked liquidity from the start.  Fixed Supply. Impossible to rug. Run with confidence, all gains to the people. Independent entertainment token, not pump.fun.      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SUMP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SUMP>>(v4);
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

