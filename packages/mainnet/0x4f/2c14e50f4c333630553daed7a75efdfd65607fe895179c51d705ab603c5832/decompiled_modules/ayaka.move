module 0x4f2c14e50f4c333630553daed7a75efdfd65607fe895179c51d705ab603c5832::ayaka {
    struct AYAKA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<AYAKA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<AYAKA>>(0x2::coin::mint<AYAKA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: AYAKA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/9ffdbe50a77a5fdfa6e9d5a4b5c2035cc05e02115ff5d752d77a1964a1d25762?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<AYAKA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"AYAKA   ")))), trim_right(b"AYAKA AI                        "), trim_right(b"The First AI Girlfriend Powered by Crypto  Ayaka is not just another AI chatbot. She's a sophisticated virtual companion designed to provide meaningful conversations, emotional support, and genuine connection.                                                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<AYAKA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<AYAKA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<AYAKA>>(0x2::coin::mint<AYAKA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

