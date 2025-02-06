module 0x22eaa683ea8e51a9d22207e8f2473072b8f11b9fdb4925108261ca8a78ddd5df::fartiverse {
    struct FARTIVERSE has drop {
        dummy_field: bool,
    }

    fun init(arg0: FARTIVERSE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6Cf2mcRBuPZ1Aq65kP4RGmcKqGPJ1F76RD6yFngYpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<FARTIVERSE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"FARTIVERSE  ")))), trim_right(b"THE FARTIVERSE                  "), trim_right(x"54484520464152544956455253452121210a57656c636f6d6520746f2074686520466172746976657273652c20776865726520455645525920424f4f4b205354494e4b53210a546865204661727469766572736520626567616e2077697468207769746820746865206269672062616e672c2049206d65616e206269672042555454206f662046617274626f792c20626f79206f6620612074686f7573616e642066617274732e0a4e657874207761732054776173207468652046617274204265666f7265204368726973746d61732c20666f6c6c6f776564206279204661727420436c756220616e642046617274792050657473212121202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020202020"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<FARTIVERSE>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<FARTIVERSE>>(v4);
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

