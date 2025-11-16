module 0x8d82bedf38407a7c073e460f426542b3149c024d02bb13846d1605b675e61b7e::uut {
    struct UUT has drop {
        dummy_field: bool,
    }

    fun init(arg0: UUT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = b"https://gateway.irys.xyz/tvttcq5XxcmLblpY2-JG_P5ItpcNoIR7NGxWnn67-hU";
        let v1 = if (0x1::vector::length<u8>(&v0) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(b"https://gateway.irys.xyz/tvttcq5XxcmLblpY2-JG_P5ItpcNoIR7NGxWnn67-hU"))
        };
        let (v2, v3, v4) = 0x2::coin::create_regulated_currency_v2<UUT>(arg0, 9, trim_right(b"UUT"), trim_right(b"USDT"), trim_right(b"Leading Web3.0 tool platform that enablestoken minting, batch airdrops, market waluemanagement, and more."), v1, true, arg1);
        let v5 = 0x2::tx_context::sender(arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<UUT>>(v2, v5);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<UUT>>(v3, v5);
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<UUT>>(v4);
    }

    fun trim_right(arg0: vector<u8>) : vector<u8> {
        let v0 = 32;
        while (0x1::vector::length<u8>(&arg0) > 0) {
            if (0x1::vector::borrow<u8>(&arg0, 0x1::vector::length<u8>(&arg0) - 1) != &v0) {
                break
            };
            0x1::vector::pop_back<u8>(&mut arg0);
        };
        arg0
    }

    // decompiled from Move bytecode v6
}

