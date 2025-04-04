module 0xa28588f54976d2955d3cd9a9a7d4a87e00c9659f07593d6b1977eec24f91531e::wstdog {
    struct WSTDOG has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<WSTDOG>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<WSTDOG>>(0x2::coin::mint<WSTDOG>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: WSTDOG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/7dKNGtP9YYk26V9G8SzhSRoy7QYk6LmT6oxGazrapump.png?size=lg&key=fe4790                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<WSTDOG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"wstDOG  ")))), trim_right(b"First Dog Listed On WallStreet  "), trim_right(b"First Dog Listed On WallStreet                                                                                                                                                                                                                                                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<WSTDOG>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<WSTDOG>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<WSTDOG>>(0x2::coin::mint<WSTDOG>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

