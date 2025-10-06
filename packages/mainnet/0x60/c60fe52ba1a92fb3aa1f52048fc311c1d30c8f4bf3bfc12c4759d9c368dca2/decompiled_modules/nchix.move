module 0x60c60fe52ba1a92fb3aa1f52048fc311c1d30c8f4bf3bfc12c4759d9c368dca2::nchix {
    struct NCHIX has drop {
        dummy_field: bool,
    }

    fun init(arg0: NCHIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6c2091ef00e0518f5d8223b8cc1aa2955be91096bb0874dd3096e0e057072960                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NCHIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NCHIX       ")))), trim_right(b"NAKEDCHIX                       "), trim_right(x"204e414b4544434849582028244e43484958292020486f74204761696e732c2053747265616d696e67204e6f77200a0a5468652073657869657374206d656d6520636f696e206f6e20536f6c616e612068617320656e74657265642074686520636861742e0a4e6f206368696c6c2e204e6f20726572756e732e204a75737420707572652c20756e66696c74657265642070756d7020656e657267792e0a0a496e737069726564206279204e6574666c69782c20706f7765726564206279207468652070656f706c65202020244e43484958206272696e67732063696e656d61746963206d656d65732c20626f6c642076697375616c732c20616e64206120636f6d6d756e697479207468617420646f65736e74206a7573742077617463682069742073747265616d73206761696e732e0a0a20546f6b656e20416464726573"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NCHIX>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NCHIX>>(v4);
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

