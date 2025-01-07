module 0x94fd1eeb44c5c8ca0fe58e2be90128212d51b1c6cf4b0fd24bbb2a9c7ba2337b::niggabob {
    struct NIGGABOB has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NIGGABOB>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NIGGABOB>>(0x2::coin::mint<NIGGABOB>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NIGGABOB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreehttps://dd.dexscreener.com/ds-data/tokens/solana/8H2Cpwfi6V2hR9YJ3rUtrjLvPQQZTP6BPhDZgRjViRub.png?size=lg&key=bbed1c                                                                                                                                                                                         ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NIGGABOB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NIGGABOB")))), trim_right(b"NiggaBob                        "), trim_right(b"Niggabob is Spongebob's long lost brother, who is desperately trying to get that bag, because, he needs to keep up his lifestyle to continue clapping Sandy's cheeks. Help NiggaBob to continue his lifestyle by investing and he will bring you profits inreturn.                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NIGGABOB>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NIGGABOB>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NIGGABOB>>(0x2::coin::mint<NIGGABOB>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

