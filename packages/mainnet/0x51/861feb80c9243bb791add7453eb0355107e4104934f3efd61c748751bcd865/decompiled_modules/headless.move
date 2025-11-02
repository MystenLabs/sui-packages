module 0x51861feb80c9243bb791add7453eb0355107e4104934f3efd61c748751bcd865::headless {
    struct HEADLESS has drop {
        dummy_field: bool,
    }

    fun init(arg0: HEADLESS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"5140763978d9f9cb4cf237f88c39df367254eb5b288bc1a8946777e373a728dd                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HEADLESS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"HEADLESS    ")))), trim_right(b"HEADLESS HORSEMAN               "), trim_right(x"20484541444c4553532069736e74206a7573742061206d656d6520206974732061206d656368616e69736d2e0a4275696c74206f6e20616476616e63656420536f6c616e61206172636869746563747572652c207468652024484541444c4553532073797374656d20747261636b732c20666c6167732c20616e64206578706f736573207275676765727320696e207265616c2074696d6520207475726e696e6720626c6f636b636861696e207472616e73706172656e637920696e746f2076656e6765616e63652e0a0a20506f77657265642062793a0a204f6e2d636861696e2052756720547261636b65722050726f746f636f6c2028525450290a2041492d64726976656e2057616c6c6574205363616e6e65720a20446563656e7472616c697a65642052657075746174696f6e20496e6465780a0a2045616368207472"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<HEADLESS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<HEADLESS>>(v4);
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

