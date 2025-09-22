module 0xe9fa51448aaebdddeef48b5eaa6c6f74fd6bdb4058d779ae9bc55c155437657a::sgibber {
    struct SGIBBER has drop {
        dummy_field: bool,
    }

    fun init(arg0: SGIBBER, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"70b5defdda9a416f9953d41f7d9d9ce46987d55ec99e7a962bb5bc7052900c43                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SGIBBER>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SGIBBER     ")))), trim_right(b"GRIBBER IN SPACE                "), trim_right(x"426f726e20696e20636f736d69632077696c64732c206e6f77206372756973696e672067616c6178696573207769746820756e6d61746368656420737761676765722e20546f6f20636f6f6c2c20666561726c6573732c20616e64206261642d61737320746f2065766572206265206361676564210a0a4769626265722069736e277420796f7572206f7264696e61727920686970706f6865277320746865206c6567656e64206f6620536f6c616e612c20666c6f6174696e67206672656520696e2074686520756e697665727365207769746820756e73746f707061626c6520656e6572677920616e642077696c642076696265732e20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SGIBBER>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SGIBBER>>(v4);
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

