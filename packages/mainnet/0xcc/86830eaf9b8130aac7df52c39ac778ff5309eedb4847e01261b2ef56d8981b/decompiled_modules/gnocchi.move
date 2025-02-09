module 0xcc86830eaf9b8130aac7df52c39ac778ff5309eedb4847e01261b2ef56d8981b::gnocchi {
    struct GNOCCHI has drop {
        dummy_field: bool,
    }

    fun init(arg0: GNOCCHI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/HHcsLmPyZoVpHP6pVNyBf2vzxpeMkxgaZw9NJZyWpump.png?claimId=9tBP8KrWDfe6h2R6                                                                                                                                                                                                      ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GNOCCHI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GNOCCHI     ")))), trim_right(b"New Doge                        "), trim_right(x"476e6f63636869206973206120736869626120696e7520746861742068617320616e20756e63616e6e7920726573656d626c616e636520746f204b61626f73752c20746865206f726967696e616c20646f67206f662074686520444f4745206d656d652e200a0a536f6f6e20616674657220736865207761732061646f707465642c20736865206d616465207468652066616d6f75732022446f6765206661636522206d616b696e672068657220616e20696e7374616e742073656e736174696f6e2e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GNOCCHI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GNOCCHI>>(v4);
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

