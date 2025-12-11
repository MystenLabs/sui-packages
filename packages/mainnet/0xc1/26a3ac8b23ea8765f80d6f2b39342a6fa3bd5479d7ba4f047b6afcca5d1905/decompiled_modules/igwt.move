module 0xc126a3ac8b23ea8765f80d6f2b39342a6fa3bd5479d7ba4f047b6afcca5d1905::igwt {
    struct IGWT has drop {
        dummy_field: bool,
    }

    fun init(arg0: IGWT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"82c4ffaff744a3964ff4707cd01bac40f1ff85f883af72fa2cbfe1f433a298a4                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<IGWT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"IGWT        ")))), trim_right(b"In God We Trust                 "), trim_right(x"496e20476f64205765205472757374206973207374616d706564206f6e20657665727920636f696e20616e6420657665727920646f6c6c61722062696c6c20696e2074686520556e6974656420537461746573202d206e6f74206279206163636964656e742c2062757420626563617573652061206e6174696f6e206174207761722064656d616e646564207468617420697473206d6f6e6579207265666c656374206974732076616c7565732e200a0a53696e63652074686520436976696c205761722c20746865206d65737361676520686173206265656e20636c6561723a20746869732069732077686f20416d6572696361206973202d20616e6420746865206661637420746861742069742061707065617273206f6e20616c6c20552e532e2063757272656e6379206d65616e73206974206d6f766573207468726f"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<IGWT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<IGWT>>(v4);
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

