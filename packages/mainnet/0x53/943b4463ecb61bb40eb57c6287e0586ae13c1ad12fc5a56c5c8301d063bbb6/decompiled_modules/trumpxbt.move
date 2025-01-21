module 0x53943b4463ecb61bb40eb57c6287e0586ae13c1ad12fc5a56c5c8301d063bbb6::trumpxbt {
    struct TRUMPXBT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TRUMPXBT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPXBT>>(0x2::coin::mint<TRUMPXBT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TRUMPXBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/G6bdrcgYBxuMqq4fZGLxtywb8cW94VEDJ1mgNyU3pump.png?size=lg&key=6ec38b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TRUMPXBT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TrumpXBT")))), trim_right(b"Trump XBT                       "), trim_right(b"During President Biden's term, ZachXBT's contributions were overlooked. But with the rise of the 47th President - TrumpXBT - there's now an official effort to bring JUSTICE to ZachXBT.                                                                                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TRUMPXBT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TRUMPXBT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TRUMPXBT>>(0x2::coin::mint<TRUMPXBT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

