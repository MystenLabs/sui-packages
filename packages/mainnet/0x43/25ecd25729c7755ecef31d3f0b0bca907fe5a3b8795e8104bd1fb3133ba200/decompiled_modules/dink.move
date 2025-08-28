module 0x4325ecd25729c7755ecef31d3f0b0bca907fe5a3b8795e8104bd1fb3133ba200::dink {
    struct DINK has drop {
        dummy_field: bool,
    }

    fun init(arg0: DINK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"7e4ba2915834e7052f0fed8c370aabda803ba75828d865fd86e805a8b5358c06                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DINK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DINK        ")))), trim_right(b"$DINK or Die                    "), trim_right(x"546865204f47205069636b6c6562616c6c206d656d6520636f696e202444494e4b2e2020412063756c74206f66207069636b6c6562616c6c20656e7468757369617374732077686f2068617665206e6f207368616d6520696e20736d617368696e67206120776166666c652062616c6c2e0a0a2444494e4b2073657276657320617320746865206e61746976652063727970746f63757272656e637920666f72207069636b6c6562616c6c206576656e74732c20746f75726e616d656e74732c20616e64206d65726368616e646973652e2020200a0a20202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DINK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DINK>>(v4);
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

