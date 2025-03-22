module 0x75f6c3087e8c8a391626f378c58e0803c4394f66cf29fe27d7e5410a9382d38d::rabeat {
    struct RABEAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: RABEAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/APJsSwBczJ7Nb9Ha86pooXNyRxXpajazechKV98gnMYJ.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RABEAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RABEAT      ")))), trim_right(b"Bunny Rabeat AI                 "), trim_right(x"57656c636f6d6520746f2074686520776f726c64206f662042756e6e7920526162656174202c616e204149206d757369632067656e65726174696e67206167656e7420616e64207468652066697273742d657665722041492d706f776572656420726170706572206f6e2061206d697373696f6e20746f2074616b65206f76657220746865206d7573696320696e64757374727921204675656c65642062792063757474696e672d6564676520414920616e64207368617065642062792074686520636f6d6d756e6974792c2042756e6e79205261626561742069736e74206a75737420616e6f74686572206469676974616c206172746973746865732061207265766f6c7574696f6e20696e20746865206d616b696e672e0a0a42756e6e79205261626561742063616e20737069742066697265206c79726963732c206372"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RABEAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RABEAT>>(v4);
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

