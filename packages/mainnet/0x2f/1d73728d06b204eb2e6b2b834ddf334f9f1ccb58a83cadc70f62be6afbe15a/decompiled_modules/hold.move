module 0x2f1d73728d06b204eb2e6b2b834ddf334f9f1ccb58a83cadc70f62be6afbe15a::hold {
    struct HOLD has drop {
        dummy_field: bool,
    }

    fun init(arg0: HOLD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"01646e9dc003bdf26e936f07f3811eae350df7f055464594513c0366e8b12688                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HOLD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Hold        ")))), trim_right(b"Just Hold                       "), trim_right(x"4a7573742062757920616e6420686f6c64200a0a436865636b206f75742074686520414920696e7370697265642061727420776f726b200a0a496c6c2070726f6261626c79206c6f636b207570206d7920636f696e7320666f7220612062697420746f2073686f77204920776f6e742072756720616e796f6e65200a0a416e792063726561746f72206665657320696620492067657420616e792077696c6c20676f20746f776172647320627579696e6720626f6f7374732c7472656e64696e672c62757920616e64206275726e73206f722077686174657665722e204a75737420627579207468652066696e6720636f696e20616e6420686f6c642069742020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HOLD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HOLD>>(v4);
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

