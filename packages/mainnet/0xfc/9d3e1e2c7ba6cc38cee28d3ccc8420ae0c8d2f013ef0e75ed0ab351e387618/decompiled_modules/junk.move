module 0xfc9d3e1e2c7ba6cc38cee28d3ccc8420ae0c8d2f013ef0e75ed0ab351e387618::junk {
    struct JUNK has drop {
        dummy_field: bool,
    }

    fun init(arg0: JUNK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9qqHJYaHfcqJUXwFEq8EWfJJNFpfUHbanLktUJoNpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JUNK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JUNK        ")))), trim_right(b"Official_SpaceJunk              "), trim_right(x"57656c636f6d6520746f2053706163654a756e6b20284a554e4b2920206120636f736d6963206d656d6520636f696e20626f726e20696e207468652067616c6163746963206368616f73206f662074686520576f6e646572205265616c6d2e200a0a496e206120756e697665727365206f76657272756e2062792063757465204a5045477320616e64207275672070756c6c732c207468652047616c6163746963204a756e6b2046656465726174696f6e2028474a46292077617320666f726d656420746f2070726f7465637420746865206c6173742072656d6e616e7473206f66207265616c2076616c75653a2074686520736163726564204a756e6b204f7262732e204c65642062792074686520666561726c657373204368696566205a61726c6f6b2c20686973206e6f2d6e6f6e73656e7365207365636f6e642d696e"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JUNK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JUNK>>(v4);
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

