module 0xf542c8d7e821fb7432a06701a0f9ff0471e784cfefcfecbfc59904950b7708b0::fall {
    struct FALL has drop {
        dummy_field: bool,
    }

    fun init(arg0: FALL, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"e7300765bb7553e2f9ff7fff3f9fc3c7f3046a42c798a3654e4532035c8e89db                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FALL>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FALL        ")))), trim_right(b"Fallana                         "), trim_right(x"2446414c4c20746f2074686520746f702e0a0a46616c6c2047757973206f6e20536f6c616e612e200a0a323025206f6620616c6c2067616d6520766f6c756d65206175746f6d61746963616c6c79206275797320616e64206275726e73202446414c4c2c206675656c696e67206f75722065636f73797374656d20616e642062656e65666974696e67206f757220686f6c646572732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FALL>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FALL>>(v4);
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

