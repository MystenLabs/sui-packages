module 0xaf77a29079858dd2ec362cb35301f6ed6fde73802ff4f260856d277fd8bb95e6::beast {
    struct BEAST has drop {
        dummy_field: bool,
    }

    fun init(arg0: BEAST, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"nwlvtdQn-N7ZTQKU                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BEAST>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BEAST       ")))), trim_right(b"MR BEAST OFFICIAL               "), trim_right(x"4d72204265617374206973206f6e636520616761696e206265696e6720666f6c6c6f77656420627920536f6c616e612c2072656d696e697363656e74206f6620746865206578636974656d656e7420647572696e672074686520323032312062756c6c2072756e2e205468697320646576656c6f706d656e74207375676765737473207468617420736f6d657468696e67207369676e69666963616e742069732062726577696e6720696e207468652063727970746f2073706163652e20576861742077696c6c2068617070656e206966206f6e6c7920313025206f66204d72204265617374277320596f755475626520666f6c6c6f77657273206a6f696e20536f6c616e6120616e64207472616465206461696c79207573696e672074686520536f6c616e612065636f73797374656d2e0d0a0d0a0d0a2020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<BEAST>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<BEAST>>(v4);
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

