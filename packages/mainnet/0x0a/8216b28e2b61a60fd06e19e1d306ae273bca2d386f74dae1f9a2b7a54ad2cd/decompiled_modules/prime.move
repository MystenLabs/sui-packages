module 0xa8216b28e2b61a60fd06e19e1d306ae273bca2d386f74dae1f9a2b7a54ad2cd::prime {
    struct PRIME has drop {
        dummy_field: bool,
    }

    fun init(arg0: PRIME, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"a6k3RImIE8ENgOcC                                                                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PRIME>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PRIME       ")))), trim_right(b"PRIME HYDRATION                 "), trim_right(x"5072696d6520487964726174696f6e3a20546865204d656d6520436f696e20546861742773205175656e6368696e672074686520546869727374206f66207468652043727970746f20576f726c640d0a5072696d6520487964726174696f6e2c2074686520706f70756c6172206265766572616765206272616e6420666f756e64656420627920596f75547562657273204b534920616e64204c6f67616e205061756c2c206861732074616b656e2074686520696e7465726e65742062792073746f726d2e204e6f772c20696d6167696e652061206d656d6520636f696e20696e737069726564206279207468697320766972616c2073656e736174696f6e2020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<PRIME>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<PRIME>>(v4);
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

