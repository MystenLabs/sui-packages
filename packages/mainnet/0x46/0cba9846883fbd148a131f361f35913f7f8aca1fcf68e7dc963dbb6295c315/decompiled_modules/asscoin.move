module 0x460cba9846883fbd148a131f361f35913f7f8aca1fcf68e7dc963dbb6295c315::asscoin {
    struct ASSCOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: ASSCOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/G3EDZoS49NRVKP8X1HggHZJueJeR8d2izUHeXdV3pump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ASSCOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ASSCOIN     ")))), trim_right(b"ASSCOIN                         "), trim_right(b"AssCoin is the latest innovative project brought to you by the same visionary behind the viral sensation, FartCoin. As the CTO of this exciting venture, we are proud to announce our official partnership with Asprofin Bank, a trusted leader in financial services. This collaboration ensures a secure foundation for AssCoi"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<ASSCOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<ASSCOIN>>(v4);
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

