module 0xfe598257de3c6acd7a87bba8f07ad7670bec9d70b8e9e6306aad6e30767e0877::c3coina {
    struct C3COINA has drop {
        dummy_field: bool,
    }

    fun init(arg0: C3COINA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"ba34e81268416c1c850b1a346bd014a09d856a566a92048d1dbded369d2084ce                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<C3COINA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"C3COIN      ")))), trim_right(b"CHEW CHEW                       "), trim_right(b"Chewchew Coin is a special cryptocurrency created to enhance the welfare of all animals around the world. The capital generated through transactions and investments with Chuchu Coin is transparently allocated to global animal protection and welfare initiatives, contributing to a sustainable ecosystem where humans and a"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<C3COINA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<C3COINA>>(v4);
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

