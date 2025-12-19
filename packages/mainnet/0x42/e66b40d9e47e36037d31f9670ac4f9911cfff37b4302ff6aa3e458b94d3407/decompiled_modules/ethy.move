module 0x42e66b40d9e47e36037d31f9670ac4f9911cfff37b4302ff6aa3e458b94d3407::ethy {
    struct ETHY has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ETHY>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ETHY>>(0x2::coin::mint<ETHY>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ETHY, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/a7cda5fa24f5c7855421f51e16eaa9afeed0e4770dbccbbf7e4b022641e8b5b4?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ETHY>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ETHY    ")))), trim_right(b"Ethy AI                         "), trim_right(b"Ethy is your autonomous trading assistant. Define your strategies in plain language, tap into alpha from expert agents, and let Ethy monitor markets and execute when conditions are right.                                                                                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ETHY>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ETHY>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ETHY>>(0x2::coin::mint<ETHY>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

