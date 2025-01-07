module 0x9b09eaf8825d326f8fc7a46d3a3a45e817fd53d6db06b8dfb12d4f94ada39357::jinxy {
    struct JINXY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<JINXY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<JINXY>>(0x2::coin::mint<JINXY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: JINXY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/BFhtS2T2y6KTicomS9xTCUN5HYZ8UdxZJBJkE31oCjeK.png?size=lg&key=1cca35                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JINXY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JINXY   ")))), trim_right(b"Pnut's Sister                   "), trim_right(b"Jinxy the squirrel is Pnuts sister that had passed away from her disability. Jinxy was the happiest, sassiest, love bug you couldnt help fall in love with. RIP JINXY and PNUT. We will carry on your legacy                                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<JINXY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<JINXY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<JINXY>>(0x2::coin::mint<JINXY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

