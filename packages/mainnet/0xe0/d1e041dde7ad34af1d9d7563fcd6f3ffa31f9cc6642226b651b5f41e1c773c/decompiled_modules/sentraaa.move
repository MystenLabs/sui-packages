module 0xe0d1e041dde7ad34af1d9d7563fcd6f3ffa31f9cc6642226b651b5f41e1c773c::sentraaa {
    struct SENTRAAA has drop {
        dummy_field: bool,
    }

    fun init(arg0: SENTRAAA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DzutBAJKANBR5b9kHxH7Pv2r64JHxByTC4zFkXnddsGA.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<SENTRAAA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"SENTRA      ")))), trim_right(b"SENTRA AI                       "), trim_right(b"Sentra AI, we specialize in advanced security solutions designed to combat cyber threats. Our team is dedicated to staying ahead of evolving risks, ensuring businesses and individuals remain protected in an increasingly digital world. Recognizing the growing danger of cyber attacks and data breaches, we developed an in"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<SENTRAAA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<SENTRAAA>>(v4);
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

