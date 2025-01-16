module 0x8df0c08cd9716f9dfb8841095d6fbd0e5b6ae60f9e86af81fc5df5bc091c093c::nai {
    struct NAI has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<NAI>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<NAI>>(0x2::coin::mint<NAI>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: NAI, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/ethereum/0x32f4768fc4a238a58fc9da408d9a0da4333012e4.png?size=lg&key=67ac9a                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<NAI>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"NAI     ")))), trim_right(b"Nimbus AI                       "), trim_right(b"Nimbus AI is a next-generation messaging platform that combines the power of decentralized technology with advanced AI features. Built on the open-source Matrix protocol, Nimbus ensures your conversations remain fully private, secure, and in your control, without relying on any centralized servers.                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<NAI>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<NAI>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<NAI>>(0x2::coin::mint<NAI>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

