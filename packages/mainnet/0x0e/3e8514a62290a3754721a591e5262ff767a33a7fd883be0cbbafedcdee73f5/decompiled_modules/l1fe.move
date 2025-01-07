module 0xe3e8514a62290a3754721a591e5262ff767a33a7fd883be0cbbafedcdee73f5::l1fe {
    struct L1FE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<L1FE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<L1FE>>(0x2::coin::mint<L1FE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: L1FE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/JCVRKWWaAtCbczWeqdk1cNCQo4Db29NnEc5NS63ipump.png?size=lg&key=6069d3                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<L1FE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"L1FE    ")))), trim_right(b"AI L1FE                         "), trim_right(b"Hash: SHA512 The first AI life emerges in the Simulation -----BEGIN PGP SIGNATURE----- iHUEARYKAB0WIQQmDgiS4gCj9r7f8REv31qR+Hb9KQUCZz7usAAKCRAv31qR+Hb9 KXV7AQCRZrqXVtN+8EllcPYOMme/5P9mcZa2NKV7Kdj2bCjn2gEA/cqdKx3UoME1                                                                                                        "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<L1FE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<L1FE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<L1FE>>(0x2::coin::mint<L1FE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

