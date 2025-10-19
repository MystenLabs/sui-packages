module 0x768396057fa15687869a06fff3a748807b94a19a6f8854ac0b2ba43bfd9ac151::handles {
    struct HANDLES has drop {
        dummy_field: bool,
    }

    fun init(arg0: HANDLES, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"1646cca2a5d686f3c505d89d5e50dc5eabf727ef53ec3140568eb633bbba8f44                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HANDLES>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HANDLES     ")))), trim_right(b"X Handles Marketplace           "), trim_right(x"48616e646c65732061726520636f6d696e672e2e2e0a446f20796f75207468696e6b206e6f206f6e652077696c6c2073617920616e797468696e673f0a446f20796f75207468696e6b20456c6f6e20776f6e27742074616c6b2061626f75742069743f0a446f20796f75207468696e6b206e6f206f6e652077696c6c20757365207468656d20616e64207468657920776f6e2774206265207472656e64696e6720666f72206174206c656173742061206d6f6e74683f0a0a57656c6c2c20696620796f7520756e6465727374616e6420686f77206875676520746869732069732c2067726162206120626167206265666f726520796f75207365652069742072756e206f75742e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HANDLES>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HANDLES>>(v4);
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

