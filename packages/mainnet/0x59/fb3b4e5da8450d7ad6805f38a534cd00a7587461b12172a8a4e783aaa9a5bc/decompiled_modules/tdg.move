module 0x59fb3b4e5da8450d7ad6805f38a534cd00a7587461b12172a8a4e783aaa9a5bc::tdg {
    struct TDG has drop {
        dummy_field: bool,
    }

    fun init(arg0: TDG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"11111111    ");
        let v1 = trim_right(b"https://ipfs.io/ipfs/QmeyeN9tXiGkVxtpPBv1UcBhwgtP4GAaaS9u8F7JcHdGT4                                                                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TDG>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TDG     ")))), trim_right(b"TRADING                         "), trim_right(b"un token para hacer trading donde todos pueden participar con libertad                                                                                                                                                                                                                                                          "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<TDG>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<TDG>>(v4);
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

