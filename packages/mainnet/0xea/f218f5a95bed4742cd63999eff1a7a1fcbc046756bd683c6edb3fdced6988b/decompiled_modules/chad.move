module 0xeaf218f5a95bed4742cd63999eff1a7a1fcbc046756bd683c6edb3fdced6988b::chad {
    struct CHAD has drop {
        dummy_field: bool,
    }

    fun init(arg0: CHAD, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"485bf4ab4141c3c60599e147b11ef3ccc5b0420c0e661b75ca57bb42c54738b9                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<CHAD>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"CHAD        ")))), trim_right(b"Be a CHAD!!!                    "), trim_right(x"5768617420737461727465642061732061206d656d6520686173206e6f77206265636f6d652074686520756c74696d6174652073796d626f6c206f6620737563636573732c20706f7765722c20616e6420766963746f72792e204d6f7265207468616e206a757374206120746f6b656e6974732061206d6f76656d656e742e20412063616c6c20746f20616c6c2077686f2073747269766520746f20646f6d696e6174652c206c6561642c20616e642077696e20696e207468652063727970746f20776f726c642e200a0a4265206120436861642e204974277320746861742073696d706c65212020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<CHAD>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<CHAD>>(v4);
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

