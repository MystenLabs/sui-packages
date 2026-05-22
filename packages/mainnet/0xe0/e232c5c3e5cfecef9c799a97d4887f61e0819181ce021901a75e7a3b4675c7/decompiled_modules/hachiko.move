module 0xe0e232c5c3e5cfecef9c799a97d4887f61e0819181ce021901a75e7a3b4675c7::hachiko {
    struct HACHIKO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<HACHIKO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<HACHIKO>>(0x2::coin::mint<HACHIKO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: HACHIKO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/7080f2b37bf2673fc88646bc15b5e4138de4cf718a8b7c017e952eb612f3eb52?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<HACHIKO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Hachiko ")))), trim_right(b"Hachiko Inu                     "), trim_right(b"Hachiko is a loyalty-driven memecoin inspired by Japans legendary dog who waited nearly 10 years for his owner. A symbol of trust, patience, and community strength.                                                                                                                                                            "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<HACHIKO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<HACHIKO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<HACHIKO>>(0x2::coin::mint<HACHIKO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

