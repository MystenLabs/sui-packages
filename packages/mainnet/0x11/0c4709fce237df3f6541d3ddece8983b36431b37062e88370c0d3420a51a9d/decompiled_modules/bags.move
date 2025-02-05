module 0x110c4709fce237df3f6541d3ddece8983b36431b37062e88370c0d3420a51a9d::bags {
    struct BAGS has drop {
        dummy_field: bool,
    }

    fun init(arg0: BAGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"x59bbKD4ckDCWmg3                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BAGS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BAGS        ")))), trim_right(b"BAGS DOWN                       "), trim_right(x"4d592024424147532041524520444f574e0d0a0d0a244241475320686f6c647320746865207265636f726420666f72206c6f6e67657374204c50206d6967726174696f6e20696e20686973746f72792e2e2e206f76657220313230206d696e757465732e0d0a0d0a4920776f756c64206c696b6520746f207468616e6b204d6574656f726120616e64204d6f6f6e73686f7420666f72207468697320686973746f726963616c206d6f6d656e742e0d0a0d0a576974686f757420796f75206e6f6e65206f66207468697320776f756c642068617665206265656e20706f737369626c652e0d0a0d0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BAGS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BAGS>>(v4);
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

