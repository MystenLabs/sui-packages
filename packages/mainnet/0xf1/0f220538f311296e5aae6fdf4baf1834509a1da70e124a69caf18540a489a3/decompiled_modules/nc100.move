module 0xf10f220538f311296e5aae6fdf4baf1834509a1da70e124a69caf18540a489a3::nc100 {
    struct NC100 has drop {
        dummy_field: bool,
    }

    fun init(arg0: NC100, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GVSwZbH37oj4xCp24oJUaSV8ug2RrpVoSfGprh1jpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NC100>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NC100       ")))), trim_right(b"NoCap100                        "), trim_right(x"20244e6f43617031303020204e6f206c6965732e204e6f2073756974732e204a75737420726577617264732c20726562656c6c696f6e2026207265616c206f6e65732e2041697264726f70732c207361766167652063756c747572652c20616e64207472757468206f6e20536f6c616e612e204275696c7420646966666572656e742e2020234e6f4361703130300a0a57652077696c6c206265206a6f696e2061206269676765722065636f73797374656d206f6e636520776520626f6e642e2047657420726561647920666f720a46697265776f726b2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NC100>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NC100>>(v4);
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

