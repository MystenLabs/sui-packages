module 0x710af53a17c961136c9376607875e247ec95aaec4bff1f23894588030ea3d170::bony {
    struct BONY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BONY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BONY>>(0x2::coin::mint<BONY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BONY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/4uKBAi232T5Zb9hLkerN3LX37z4JfPh4SWkd39Tcpump.png?size=lg&key=c256f4                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BONY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BONY    ")))), trim_right(b"Santa's Little Helper           "), trim_right(b"The Santa's Little Helper meme on Sui is a humorous and playful reference within the Sui blockchain community. It typically involves the image of a cute, mischievous character associated with Santa Claus.                                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BONY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BONY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BONY>>(0x2::coin::mint<BONY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

