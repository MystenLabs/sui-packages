module 0xc8e9254f4d3678f9630b8a8ea61f7139f7e3fbaaa1ef1cd85bce4ebdf8ae9881::zygo {
    struct ZYGO has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<ZYGO>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<ZYGO>>(0x2::coin::mint<ZYGO>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: ZYGO, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://cdn.dexscreener.com/cms/images/9JUHMjmzfKqK2rS2?width=150&height=150&fit=crop&quality=95&format=auto                                                                                                                                                                                                                    ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<ZYGO>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Zygo    ")))), trim_right(b"Zygo The Frog                   "), trim_right(b"From the original Ethereum Zygo the frog developing team. Zygo is leap frogging into the Sui ecosystem. Zygo will be the meme of 2025! Animated series, online video game, poker game, Zygo AI, Crypto token tracker in just 4 months. 1 project, 2 chains!                                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ZYGO>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ZYGO>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<ZYGO>>(0x2::coin::mint<ZYGO>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

