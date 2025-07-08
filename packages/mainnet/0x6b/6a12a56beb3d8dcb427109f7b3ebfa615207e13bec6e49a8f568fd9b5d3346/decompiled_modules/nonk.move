module 0x6b6a12a56beb3d8dcb427109f7b3ebfa615207e13bec6e49a8f568fd9b5d3346::nonk {
    struct NONK has drop {
        dummy_field: bool,
    }

    fun init(arg0: NONK, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9hjxym5uSKNAapBtYjx5U4YcW2VXvyAL1wH24cfRbonk.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NONK>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Nonk        ")))), trim_right(b"Hood Bonk                       "), trim_right(x"486f6f6420426f6e6b2c20636f6d6d6f6e6c79206b6e6f776e206173204e2a67676120426f6e6b206f7220244e6f6e6b20666f722073686f72742e0a0a41206d7973746963616c206d656c6f6e206d756e636865722066726f6d20416e6369656e74204368696e65736520746578742e20446f20796f75206b6e6f7720746865206c6f72653f202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NONK>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NONK>>(v4);
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

