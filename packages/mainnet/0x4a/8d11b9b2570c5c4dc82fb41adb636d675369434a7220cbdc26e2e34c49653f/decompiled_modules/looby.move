module 0x4a8d11b9b2570c5c4dc82fb41adb636d675369434a7220cbdc26e2e34c49653f::looby {
    struct LOOBY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<LOOBY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<LOOBY>>(0x2::coin::mint<LOOBY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: LOOBY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/41ef4d055dd24c517914dbfc2b89e9f5ecc9a676a5944a96814273661def1166?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<LOOBY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"LOOBY   ")))), trim_right(b"Looby by Stephen Bliss          "), trim_right(b"The first meme created by Stephen Bliss (Senior Artist at Rockstar Games 2001-2016, and OG artist of video game phenomenon Grand Theft Auto) and his son, Alex.                                                                                                                                                                 "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<LOOBY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<LOOBY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<LOOBY>>(0x2::coin::mint<LOOBY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

