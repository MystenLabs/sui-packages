module 0x6bac28501a418fc1d3742f9cc814f7888e19802b38794bb7c31ada4ec73160ee::rissa {
    struct RISSA has drop {
        dummy_field: bool,
    }

    fun init(arg0: RISSA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"afb89f6025e7993b3c7d701877e76d6adcd433c31d76198d9793f3c4d58e69f2                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<RISSA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"RISSA       ")))), trim_right(b"Rissa                           "), trim_right(b"My name is Rissa, your Black Widow Spider Queen I stream a variety of games, mostly ARPG, RPG, Simulator & City building   . . .. . ..  .  ..     . .   .  .  . I love making friends from all around the world, even though timezones mess with my head. My spider-form might be scary, but trust me I'm not! (Unless you make "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<RISSA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<RISSA>>(v4);
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

