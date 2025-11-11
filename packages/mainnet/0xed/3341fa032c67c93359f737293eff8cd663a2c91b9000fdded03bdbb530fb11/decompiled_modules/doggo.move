module 0xed3341fa032c67c93359f737293eff8cd663a2c91b9000fdded03bdbb530fb11::doggo {
    struct DOGGO has drop {
        dummy_field: bool,
    }

    fun init(arg0: DOGGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"c9e61a117833236c74de41f2669257a8a8d933aec130310f8e1c02394e2061e9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGGO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Doggo       ")))), trim_right(b"Bad Doggo                       "), trim_right(x"4d6565742042616420446f67676f2e20204157532028416d617a6f6e20576562205365727669636573204d6173636f74292024444f47474f0a0a4f6e63652061204b2d392e204e6f7720612063726564656e7469616c20637261636b65722e20486520627265616b732073797374656d7320746f206b656570207468656d20736166652c2062616420666f722074686520726967687420726561736f6e732e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DOGGO>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DOGGO>>(v4);
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

