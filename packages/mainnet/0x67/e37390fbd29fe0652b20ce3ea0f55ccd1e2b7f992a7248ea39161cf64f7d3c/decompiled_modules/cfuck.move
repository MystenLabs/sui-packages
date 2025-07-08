module 0x67e37390fbd29fe0652b20ce3ea0f55ccd1e2b7f992a7248ea39161cf64f7d3c::cfuck {
    struct CFUCK has drop {
        dummy_field: bool,
    }

    fun init(arg0: CFUCK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/LegiuxbrPh7SKEpnTN1nB2AjtrmSGP7XJtYZV4spump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CFUCK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CFUCK       ")))), trim_right(b"CLUSTERFUCK                     "), trim_right(b"The Monster born from the trenches of hell. He feeds on false conviction and busted dreams. You know him well. He obliterates charts and reduces candles to rubble. He's hungry and his bubble clusters are coming to eat your SOL.                                                                                             "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CFUCK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CFUCK>>(v4);
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

