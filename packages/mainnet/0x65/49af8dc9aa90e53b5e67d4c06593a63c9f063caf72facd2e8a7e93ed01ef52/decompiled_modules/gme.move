module 0x6549af8dc9aa90e53b5e67d4c06593a63c9f063caf72facd2e8a7e93ed01ef52::gme {
    struct GME has drop {
        dummy_field: bool,
    }

    fun init(arg0: GME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"727462763f5844b8710d5c456c25fced2d27ba0b8a743e793b066955a4d61e91                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GME>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GME         ")))), trim_right(b"Game Stop                       "), trim_right(x"2024474d45202054686520467574757265206f6620536f6369616c46692054726164696e67200a0a24474d452069736e74206a75737420616e6f7468657220746f6b656e697473206120536f6369616c46692d706f77657265642065636f73797374656d20776865726520747261646572732c20646567656e732c20616e6420696e766573746f727320636f6d6520746f67657468657220746f206c6561726e2c206561726e2c20616e642070726f6669742e0a0a2057686174204d616b65732024474d4520446966666572656e743f0a0a5265616c2d54696d652054726164696e6720496e73696768747320205768616c65206d6f76656d656e74732c206f6e2d636861696e20646174612c20616e64206578636c757369766520616c7068612e0a0a416e74692d52756720456475636174696f6e20204c6561726e20686f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GME>>(v4);
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

