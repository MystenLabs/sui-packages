module 0xa79640585e42d8e9fee333e8e909d047e6cd2ef11928c3635d9a62dedaa89a31::nsai {
    struct NSAI has drop {
        dummy_field: bool,
    }

    fun init(arg0: NSAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/EStrdGdFpZEv8nrMgmWddeEnY6EPf6hWN8yFfbUDpump.png                                                                                                                                                                                                                               ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NSAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NSAI        ")))), trim_right(b"Node Sphere AI                  "), trim_right(b"NSAI token powers a versatile AI agent creation platform that seamlessly integrates with leading language models. Our platform empowers users to build, deploy, and manage custom AI agents across multiple LLMs through a unified interface, enabling powerful automation and intelligent task execution. NSAI facilitates agen"), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<NSAI>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<NSAI>>(v4);
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

