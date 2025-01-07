module 0x1f4b8e7b8492d1ccc53115e3da8dd7f4042b69ec1498592f80e43d063c0dd878::pepemas {
    struct PEPEMAS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPEMAS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEMAS>>(0x2::coin::mint<PEPEMAS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPEMAS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/3TqFMpBN7YLaPzLb3xW6XNqVBAdrMqWWmnoRsMyZ54F9.png?size=lg&key=5f7131                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPEMAS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPEMAS ")))), trim_right(b"Merry Pepemas                   "), trim_right(b"PEPEMAS is a Christmas celebration exclusively for Pepe (from Matt Furie's Boys Club comic). The holiday is inspired by Pepe, the iconic character, and has evolved into a meme-filled celebration that humorously and satirically honors Pepe's unique charm.                                                                  "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPEMAS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPEMAS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPEMAS>>(0x2::coin::mint<PEPEMAS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

