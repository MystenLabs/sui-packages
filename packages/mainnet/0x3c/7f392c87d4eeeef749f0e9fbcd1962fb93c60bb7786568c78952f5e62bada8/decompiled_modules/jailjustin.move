module 0x3c7f392c87d4eeeef749f0e9fbcd1962fb93c60bb7786568c78952f5e62bada8::jailjustin {
    struct JAILJUSTIN has drop {
        dummy_field: bool,
    }

    fun init(arg0: JAILJUSTIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"12ae95018d376a9f0687e8c24f31b7f6d75c67a0c8c27eb459f12dc25e92555d                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<JAILJUSTIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"JailJustin  ")))), trim_right(b"Jail Justin Sun                 "), trim_right(b"An alleged crypto mogul presented himself with luxury, visions, and grand promises as the savior of the financial world. Behind the scenes, he used aggressive marketing tricks and lured investors with unrealistic profit opportunities. His scheme relied on pump-and-dump strategies, empty promises, and fabricated success"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<JAILJUSTIN>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<JAILJUSTIN>>(v4);
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

