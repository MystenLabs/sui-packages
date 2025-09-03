module 0xbcce664483cf8c41852e1c204634fb84951c8081d0d821f78af81c289290d505::gr {
    struct GR has drop {
        dummy_field: bool,
    }

    fun init(arg0: GR, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7cV3ycRSBqB4Jq4YAbr2ag3uvxp1xQLQVmBWgVMCpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GR>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GR          ")))), trim_right(b"Generation Remigration          "), trim_right(x"47656e65726174696f6e2052656d6967726174696f6e20697320746865206e6577206d6f76656d656e742068617070656e696e67206f6e205820200a0a54686520766972616c20766964656f206769726c20697320666f6c6c6f776564206279200a40656c6f6e6d75736b0a0a0a45766572796f6e652077616e747320746f207265636c61696d20746865726520636f756e7472696573206261636b0a0a492063616e2062657420796f75200a40656c6f6e6d75736b0a207265706c69657320746f2074686973206d6f76656d656e7420202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GR>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GR>>(v4);
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

