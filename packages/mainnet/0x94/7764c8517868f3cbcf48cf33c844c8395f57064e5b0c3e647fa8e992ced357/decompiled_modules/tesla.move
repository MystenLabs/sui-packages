module 0x947764c8517868f3cbcf48cf33c844c8395f57064e5b0c3e647fa8e992ced357::tesla {
    struct TESLA has drop {
        dummy_field: bool,
    }

    fun init(arg0: TESLA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"YzO0T3N9IS048TSZ                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TESLA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TESLA       ")))), trim_right(b"TESLA AI                        "), trim_right(x"576520646576656c6f7020616e64206465706c6f79206175746f6e6f6d79206174207363616c6520696e2076656869636c65732c20726f626f747320616e64206d6f72652e2057652062656c69657665207468617420616e20617070726f616368206261736564206f6e20616476616e63656420414920666f7220766973696f6e20616e6420706c616e6e696e672c20737570706f7274656420627920656666696369656e7420757365206f6620696e666572656e63652068617264776172652c20697320746865206f6e6c792077617920746f206163686965766520612067656e6572616c20736f6c7574696f6e20666f722066756c6c2073656c662d64726976696e672c2062692d706564616c20726f626f7469637320616e64206265796f6e642e0d0a0d0a0d0a0d0a2020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TESLA>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TESLA>>(v4);
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

