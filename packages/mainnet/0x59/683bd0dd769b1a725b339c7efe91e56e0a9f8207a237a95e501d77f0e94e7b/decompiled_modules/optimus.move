module 0x59683bd0dd769b1a725b339c7efe91e56e0a9f8207a237a95e501d77f0e94e7b::optimus {
    struct OPTIMUS has drop {
        dummy_field: bool,
    }

    fun init(arg0: OPTIMUS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"db1f9d0b0cffafcdc9b455ee862eaf3d3ad405f2973f55a7f88d62ec8e68e607                                                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<OPTIMUS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Optimus     ")))), trim_right(b"Optimus Grok Companion          "), trim_right(b"Elon is approving the idea of his baby Optimus added into Grok as companion. Optimus, also known as Tesla Bot, is a general-purpose robotic humanoid developed by Tesla, Inc.                                                                                                                                                   "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<OPTIMUS>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<OPTIMUS>>(v4);
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

