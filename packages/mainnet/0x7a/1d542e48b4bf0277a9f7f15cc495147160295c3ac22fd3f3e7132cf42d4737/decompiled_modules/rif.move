module 0x7a1d542e48b4bf0277a9f7f15cc495147160295c3ac22fd3f3e7132cf42d4737::rif {
    struct RIF has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<RIF>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<RIF>>(0x2::coin::mint<RIF>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: RIF, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GJtJuWD9qYcCkrwMBmtY1tpapV1sKfB2zUv9Q4aqpump.png?size=lg&key=cd50ef                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RIF>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RIF     ")))), trim_right(b"Rifampicin                      "), trim_right(b"Rifampicin is traditionally known as an antibiotic, but it's been gaining attention for its surprising effects on aging. In tiny organisms like C. elegans, Rifampicin has been shown to activate the cell's natural defense mechanisms against stress and damage.                                                              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<RIF>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<RIF>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<RIF>>(0x2::coin::mint<RIF>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

