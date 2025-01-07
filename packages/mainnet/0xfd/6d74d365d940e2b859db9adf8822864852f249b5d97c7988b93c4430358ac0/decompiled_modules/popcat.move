module 0xfd6d74d365d940e2b859db9adf8822864852f249b5d97c7988b93c4430358ac0::popcat {
    struct POPCAT has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<POPCAT>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<POPCAT>>(0x2::coin::mint<POPCAT>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: POPCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/base/0xd9ea93a38d1771c870128f9134d4622d331c04c8.png?size=lg&key=0429b2                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POPCAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POPCAT  ")))), trim_right(b"PopCat                          "), trim_right(b"Say hello to the cutest crypto sensation in townPopcat! Inspired by the iconic Popcat meme, this little furball brings more than just rapid jaw-dropping moves to the blockchain! Every time you HODL, Popcat unleashes a flurry of purrs and pops, aiming straight for the moon!                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<POPCAT>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<POPCAT>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<POPCAT>>(0x2::coin::mint<POPCAT>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

