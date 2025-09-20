module 0x3a5cf32bf197e546a51ae9b39d537ed7f13bbe493b2287874714b3ecf0ea1a39::tism {
    struct TISM has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<TISM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<TISM>>(0x2::coin::mint<TISM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: TISM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/42c1122b03c811635f19f2fe4130508e80f07947c0e2622d522b15146a940433?width=128&height=128&fit=crop&quality=95&format=auto                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<TISM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"TISM    ")))), trim_right(b"AUTISM CREATURE                 "), trim_right(b"The Autism Creature isnt just a memeits a digital demigod forged from pure internet chaos, a symbol of neurospicy resilience rising from the depths of degen culture. It embodies the hyperfocused, loud-souled, deadpan-wired spirit of those who turn sensory overload into alpha and burnout into battle cries.              "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<TISM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<TISM>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<TISM>>(0x2::coin::mint<TISM>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

