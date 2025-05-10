module 0xa9d584b402ecfaa1324167c882814ddcdc4f781e4fda6b2cd7c11a0af0f89f83::turtlix {
    struct TURTLIX has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TURTLIX>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TURTLIX>>(0x2::coin::mint<TURTLIX>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TURTLIX, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://img.upanh.tv/2025/05/10/photo_6122914079237589597_y.jpg                                                                                                                                                                                                                                                                 ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TURTLIX>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TURTLIX ")))), trim_right(b"Turtlix                         "), trim_right(b"Turtlix is a uniquely crafted digital character embodying the balance between resilience, strategy, and playfulness in the evolving world of decentralized technology. With a signature Sui-branded helmet and iconic coin spin, Turtlix represents the spirit of builders navigating Web3 with confidence and character.       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TURTLIX>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TURTLIX>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TURTLIX>>(0x2::coin::mint<TURTLIX>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

