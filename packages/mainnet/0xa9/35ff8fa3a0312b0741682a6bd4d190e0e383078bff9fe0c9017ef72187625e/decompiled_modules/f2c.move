module 0xa935ff8fa3a0312b0741682a6bd4d190e0e383078bff9fe0c9017ef72187625e::f2c {
    struct F2C has drop {
        dummy_field: bool,
    }

    fun init(arg0: F2C, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"11111111    ");
        let v1 = trim_right(b"https://gateway.irys.xyz/3gjUWEmjf76Lx1yvfYFzDyB6q7xP7Kl7WtEVaSL3je8                                                                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<F2C>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"F2C     ")))), trim_right(b"Factory to Consumer             "), trim_right(x"46324320436f696e204f766572766965773a0a4e61747572652061732061205574696c69747920546f6b656e3a2046324320636f696e20697320612074797065206f662072657761726420746f6b656e2077697468696e206120636f6e73756d65722d6d65726368616e742073797374656d2e0a4163717569736974696f6e204d6574686f64733a0a436f6e73756d6572733a20526563656976652072657761726420746f6b656e73207768656e2074686579206d616b65207075726368617365732e0a4d65726368616e74733a204761696e2072657761726420746f6b656e73207768656e20636f6e73756d657273206275792074686569722070726f64756374732e202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<F2C>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<F2C>>(v4);
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

