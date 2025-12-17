module 0x4318f06aa35a4e33950ac0665ad898913161d3c12d0d0519cc9f0a587a5e157a::pog {
    struct POG has drop {
        dummy_field: bool,
    }

    fun init(arg0: POG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"d182c19865d23aec1cd3f2b41605033ffe0b95027c0ef1c8ae9f4bec91dc6a78                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<POG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"POG         ")))), trim_right(b"pog cult                        "), trim_right(b"What looked like a pogging opportunity fell into the water due to stolen art, a fake dev, and lots of sus moments But one thing stayed: the Cult! Thats why wethe Culttook over and are now leading $POG with real poggers! Come and join the Cult, future poggers                                                              "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<POG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<POG>>(v4);
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

