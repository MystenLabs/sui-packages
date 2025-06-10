module 0xf20e08c260f2eb850ef4b3ac4a96d5bed045953634aec6158b0dbff0cdc6251b::treeincat {
    struct TREEINCAT has drop {
        dummy_field: bool,
    }

    fun init(arg0: TREEINCAT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"H54HQrrM2TnJhFqc                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TREEINCAT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TREEINCAT   ")))), trim_right(b"Tree stuck in cat               "), trim_right(x"5472656520537475636b20696e204361742e0d0a0d0a4120706c617966756c2070617261646f7820696e206120756e6976657273652077686572652074726565732067657420737475636b20696e20636174732e20496e6e6f766174696f6e206d6565747320696d6167696e6174696f6e2070726573656e74656420696e2074686520666f726d206f662067616d65732c206172742c206d7573696320616e642041492e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TREEINCAT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TREEINCAT>>(v4);
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

