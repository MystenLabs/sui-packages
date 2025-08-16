module 0xd18e176a0ae9eeaa0695a5c31483dc089ba630204aeefe9e3704649ca28f3ff6::snorfle {
    struct SNORFLE has drop {
        dummy_field: bool,
    }

    fun init(arg0: SNORFLE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6dsoD1LjP41RBuYQfCxicKCe8neD2pZQBkt4fwXNP4mt.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SNORFLE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SNORFLE     ")))), trim_right(b"Mrsnorfle                       "), trim_right(x"486520646f65736e74206261726b20206865206269746573207363616d732e0a41726d656420776974682070757265206d656d6520706f7765722c20686520706973736573206f6e2072756770756c6c732c20736e69666673206f757420736861647920636f696e732c0a616e642070726f746563747320796f75722062616773206c696b6520612074727565207761746368646f672020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SNORFLE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SNORFLE>>(v4);
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

