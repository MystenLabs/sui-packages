module 0xd1797685f32ca1c34bb81c4c9a2467ba7f1cea38673e5131bcb2401fa0bf0920::xenti {
    struct XENTI has drop {
        dummy_field: bool,
    }

    fun init(arg0: XENTI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CjZ74SVHFcyUB2kMDy9bfqY5GdPYSC4PfxyxsGYEpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<XENTI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"XENTI       ")))), trim_right(b"XENTINET                        "), trim_right(b"Xentinet is a defense-grade technology company building next-generation digital infrastructure where AI, quantum-aware security, and autonomous defense converge to create the most secure, intelligent migration pathway into Web4. We deliver sovereign, AI-governed environments for assets, identity, and communitiesshielde"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<XENTI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<XENTI>>(v4);
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

