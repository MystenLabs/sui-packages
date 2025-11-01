module 0x96db55ec185d6a0ffa16aeae43742f5f9e10b6ef5f6bc9594bd3f3d411c0201e::rflip {
    struct RFLIP has drop {
        dummy_field: bool,
    }

    fun init(arg0: RFLIP, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"a3ea1efe69f9819e55481b72e03ba87cb368f62aafac93c82a7fd100fb314d9e                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RFLIP>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RFLIP       ")))), trim_right(b"Rugflip                         "), trim_right(x"527567666c6970206973207468652066697273742041492d67656e65726174656420726564656d7074696f6e20746f6b656e206275696c7420746f206669676874206261636b20616761696e7374206f6e65206f662074686520626967676573742070726f626c656d7320696e2063727970746f20207275672070756c6c732e0a0a4f766572202431342062696c6c696f6e20686173206265656e2073746f6c656e2066726f6d20696e766573746f7273207468726f756768207363616d732c2066616b652070726f6a656374732c20616e64206c697175696469747920647261696e732e20527567666c697073206d697373696f6e20697320746f20747261636b20727567732c206578706f7365207363616d6d6572732c20616e6420666c69702074686520746f74616c206d61726b657420636170206f66207468652031"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RFLIP>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RFLIP>>(v4);
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

