module 0x6a4506ae814d4847163e62d08e8cf79b8e63ba39de8a95eab7ca4e39753a8337::grinch {
    struct GRINCH has drop {
        dummy_field: bool,
    }

    fun init(arg0: GRINCH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"920883aed3c1eccc92484a7636c9b6d938906250cb6ceda16df77f89f24bfbe0                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<GRINCH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"GRINCH      ")))), trim_right(b"GRINCH                          "), trim_right(x"20244772696e63682069736e74206865726520746f20737072656164206368656572697473206865726520746f20666c69702074686520686f6c69646179732075707369646520646f776e2e0a4d656d6520706f776572202b207265616c207574696c697479202b206120636f6d6d756e6974792074686174206c6f766573206368616f732e0a0a204661697220746f6b656e6f6d6963730a204e4654732c2067616d65732026206576656e74730a2041206d6f76656d656e742c206e6f74206a7573742061206d656d650a0a41726520796f7520696e2c206f722061726520796f75206f6e20746865206e617567687479206c6973743f202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<GRINCH>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<GRINCH>>(v4);
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

