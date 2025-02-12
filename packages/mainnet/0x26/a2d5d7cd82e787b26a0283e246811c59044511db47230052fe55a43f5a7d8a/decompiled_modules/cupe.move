module 0x26a2d5d7cd82e787b26a0283e246811c59044511db47230052fe55a43f5a7d8a::cupe {
    struct CUPE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<CUPE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<CUPE>>(0x2::coin::mint<CUPE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: CUPE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/C7ZrUwoxETNgFEk5n6Q6Ycbv9Q3BHHBQTH4MdkTbpump.png?size=lg&key=bcf93f                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CUPE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CUPE    ")))), trim_right(b"Cupid Pepe                      "), trim_right(b"Whether youre down bad or riding high, Cupid Pepe is here to remind you: wen Lambo doesnt matter when youve got frens. So open your heart (and maybe your wallet), because lovelike liquidity is best when it flows.                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<CUPE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<CUPE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<CUPE>>(0x2::coin::mint<CUPE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

