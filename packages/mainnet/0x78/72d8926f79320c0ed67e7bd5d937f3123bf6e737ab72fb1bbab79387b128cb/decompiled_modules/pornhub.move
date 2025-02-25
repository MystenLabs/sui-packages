module 0x7872d8926f79320c0ed67e7bd5d937f3123bf6e737ab72fb1bbab79387b128cb::pornhub {
    struct PORNHUB has drop {
        dummy_field: bool,
    }

    fun init(arg0: PORNHUB, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"KezSi85SliTblGKp                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PORNHUB>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PORNHUB     ")))), trim_right(b"PORNHUB                         "), trim_right(x"506f726e68756220697320746865206f6666696369616c20746f6b656e206f662074686520506f726e6875622e636f6d20776562736974652e20506f726e687562206973206120706f70756c6172206164756c7420656e7465727461696e6d656e7420706c6174666f726d206f66666572696e672061207661737420636f6c6c656374696f6e206f6620757365722d67656e65726174656420616e642070726f66657373696f6e616c206164756c7420636f6e74656e742c20696e636c7564696e6720766964656f732c206c6976652073747265616d732c20616e642070686f746f732e20504820546f6b656e20726577617264732070726f6772616d20616e6e6f756e63656d656e7420636f6d696e67206166746572205261796469756d206c697374696e672e0d0a0d0a2020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PORNHUB>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PORNHUB>>(v4);
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

