module 0x6a52293b0099c203b33b4d4f242cf80c3ec22880b25ef86061b85925263d999b::fartclub {
    struct FARTCLUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTCLUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/AtG49sbSaf4uW2Ldq26t3ff5MGLwrQczQtu1vXFQpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTCLUB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTCLUB    ")))), trim_right(b"FARTCLUB                        "), trim_right(x"497473204641525420434c55422121212121205965732c20746865204661727469766572736520657870616e646564207768656e2046617274626f792077656e7420746f2048696768205363686f6f6c2e20427574206e6f74206a75737420616e79206f6c64207363686f6f6c2020686520776f6e2061207363686f6c61727368697020746f2054484520414d415a494e474c592046414e4359205343484f4f4c204f4620455843454c4c454e434520494e20535041524b4c452043495459210a46617274626f79206d616b6573206e657720667269656e64732c20627574206e6f74206a75737420616e79206f6c6420667269656e647320207374696e6b792c20666172742d706f776572656420667269656e64732120546f6765746865722074686579206265636f6d6520204641525420434c5542210a0a46617274626f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTCLUB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTCLUB>>(v4);
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

