module 0xdf9dbcbb20d2635e4d701a1150a45c3cd2797ec0a62b01b56de72cf89f060164::cum {
    struct CUM has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CUM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CUM>>(0x2::coin::mint<CUM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CUM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/CRctn3n2KWEX1ZiuwNRU8MPj2q11wnn17x4mcuLbpump.png?size=lg&key=e6761d                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CUM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CUM     ")))), trim_right(b"Cum Token                       "), trim_right(x"43756d20546f6b656e20697320612070696f6e656572696e672063727970746f63757272656e6379207461696c6f72656420666f722070656f706c652077686f20656d626f647920737472656e6774682c20616d626974696f6e2c20616e6420756e72656c656e74696e672064726976652e2043756d20546f6b656e206973206e6f74206a7573742061206469676974616c2061737365742c2069747320612073796d626f6c206f6620726573696c69656e636520616e6420612072616c6c79696e672063616c6c20666f722074686f73652077686f206c656164207769746820707572706f736520616e6420656d6272616365206368616c6c656e67657320686561642d6f6e002e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CUM>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CUM>>(0x2::coin::mint<CUM>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

