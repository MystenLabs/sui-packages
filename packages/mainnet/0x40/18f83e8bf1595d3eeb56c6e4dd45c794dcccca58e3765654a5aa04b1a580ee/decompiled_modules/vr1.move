module 0x4018f83e8bf1595d3eeb56c6e4dd45c794dcccca58e3765654a5aa04b1a580ee::vr1 {
    struct VR1 has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<VR1>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<VR1>>(0x2::coin::mint<VR1>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: VR1, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/6T3HbCXGnC4L3OUn?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<VR1>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"VR1     ")))), trim_right(b"VR1                             "), trim_right(b"VR1 Token is the ultimate gaming cryptocurrency built on the lightning-fast Solana blockchain, powering the VR1 Arcade ecosystem and next-gen gaming experiences.                                                                                                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<VR1>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<VR1>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<VR1>>(0x2::coin::mint<VR1>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

