module 0x9cf30105ab517e4a41f07f57b3f16023a7d3b0b5262fbc7af32ce7238d53c695::pepecoin {
    struct PEPECOIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: PEPECOIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"4e7cbc885a50fd87b2a93e0f49623bd281d7dbeccb4f3dd6824b4efa5c527bc2                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPECOIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPECOIN    ")))), trim_right(b"PEPECOIN                        "), trim_right(x"416e20616e6f6e796d6f757320346368616e2075736572206d6164652074686520776f726c642773204649525354205065706520436f696e20696e20323031352c2074686973207761732061207768696c65206265666f726520616e79206f74686572205065706520436f696e2063616d65206f75742e0a0a5965732c207468697320776173204245464f52452074686520726563656e74205045502077686963682068616420636c61696d656420746f2062652074686520666972737420657665722c206c61756e63686564206f6e203134746820417072696c20323031352e0a0a5065706520436f696e207761732063726561746564206f6e2031737420417072696c20323031352e0a0a4966205045502077656e7420746f20346d2c20616e64205065706520697320776f72746820243442206d61726b657420636170"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PEPECOIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PEPECOIN>>(v4);
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

