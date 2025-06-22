module 0xab37ac4ed8169868ccf83a22b02f4f9d8a69a0e07fb78442868977af5c395665::p33l {
    struct P33L has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<P33L>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<P33L>>(0x2::coin::mint<P33L>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: P33L, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/bsc/0x7528bd0f620d1568c307cc8d5db481a29e8d4e37.png?size=lg&key=6cac7a                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<P33L>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"P33L    ")))), trim_right(b"THE P33L                        "), trim_right(b"The P33L delivers web3 and internet culture news in VIDEO format, layered with satire, topped with meme sauce and served by its unhinged onion anchor, P33ly.                                                                                                                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<P33L>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<P33L>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<P33L>>(0x2::coin::mint<P33L>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

