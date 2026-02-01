module 0x819560d303b2e5ea8e8eb017786c2b73419f959f3c3c1504935c53a9aad296ef::pepstein {
    struct PEPSTEIN has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PEPSTEIN>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPSTEIN>>(0x2::coin::mint<PEPSTEIN>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PEPSTEIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/50f7d94d8c615e109f2dc917cef40ab552720bf039e57727f7becbda4e4df10f?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PEPSTEIN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PEPSTEIN")))), trim_right(b"PEPSTEIN                        "), trim_right(b"A token tied to Jeffrey Epstein reaching tens to hundreds of millions in market cap is not a theory, its an eventual outcome. The only reason it hasnt happened yet is timing and execution.                                                                                                                                    "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PEPSTEIN>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PEPSTEIN>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PEPSTEIN>>(0x2::coin::mint<PEPSTEIN>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

