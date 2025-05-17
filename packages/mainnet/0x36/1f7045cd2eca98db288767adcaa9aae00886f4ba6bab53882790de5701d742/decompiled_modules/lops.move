module 0x361f7045cd2eca98db288767adcaa9aae00886f4ba6bab53882790de5701d742::lops {
    struct LOPS has drop {
        dummy_field: bool,
    }

    fun init(arg0: LOPS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/cdwmqcpjcqzrvVsKYANCdGkdvGG8H5rpeKVT9YZpump.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LOPS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LOPS        ")))), trim_right(b"LAUNCHONPUMPSCANNER             "), trim_right(x"4c61756e63686f6e70756d70205363616e6e6572206d6f6e69746f727320616c6c207265706c6965732066726f6d20406c61756e63686f6e70756d702c2070726f766964696e6720612073747265616d6c696e656420696e7465726661636520746f2076696577206e657720746f6b656e206c61756e63686573206f6e20536f6c616e612e200a54686520444170702061676772656761746573207265706c69657320696e746f20616e2061636365737369626c65206c6973742c20656e737572696e6720796f75206e65766572206d697373206120706f74656e7469616c206f70706f7274756e69747920696e2074686520666173742d70616365642063727970746f206d61726b65742e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<LOPS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<LOPS>>(v4);
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

