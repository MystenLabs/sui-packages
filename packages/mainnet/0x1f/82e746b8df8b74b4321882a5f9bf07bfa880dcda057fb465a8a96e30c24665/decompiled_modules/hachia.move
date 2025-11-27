module 0x1f82e746b8df8b74b4321882a5f9bf07bfa880dcda057fb465a8a96e30c24665::hachia {
    struct HACHIA has drop {
        dummy_field: bool,
    }

    fun init(arg0: HACHIA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"fa014f5176e4539922c5c53c54698e03a98ce8c99ca2ac27fde525bbaa2ffcb9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HACHIA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HACHI       ")))), trim_right(b"Hachiko                         "), trim_right(x"48616368696b6f20697320746865206d656d65636f696e20696e73706972656420627920746865206c6567656e6461727920416b6974612077686f207761697465642065766572792073696e676c652064617920617420536869627579612053746174696f6e20666f7220686973206f776e65722d206576656e206166746572206865207061737365642e0a0a5768696c65206f7468657220746f6b656e7320636f6d6520616e6420676f2c2048616368696b6f20776169747320666f7220796f7520657665727920626c6f636b2c206576657279206469702c2065766572792070756d702e204c6f79616c2074696c6c2074686520656e642020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HACHIA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HACHIA>>(v4);
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

