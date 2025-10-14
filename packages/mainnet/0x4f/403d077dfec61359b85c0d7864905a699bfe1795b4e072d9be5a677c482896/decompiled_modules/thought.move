module 0x4f403d077dfec61359b85c0d7864905a699bfe1795b4e072d9be5a677c482896::thought {
    struct THOUGHT has drop {
        dummy_field: bool,
    }

    fun init(arg0: THOUGHT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"6abb373d061f4d6a69243d482c72412b1b382999f8563a7944a087b7d2a0fc36                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<THOUGHT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Thought     ")))), trim_right(b"Thought Coin                    "), trim_right(b"Inspired by the idea of rewarding recursive improvement, by andyayrey, this token is designed to invest in the very fabric of thought  a self-reinforcing economy where each insight, action, and iteration leads to smarter, stronger outcomes over time.                                                                      "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<THOUGHT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<THOUGHT>>(v4);
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

