module 0x23270c83fbf0f23e9ac20d0a35e904e8bfdfda3c107d6ecc6eb2c79ca2ea4d81::beenz {
    struct BEENZ has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BEENZ>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BEENZ>>(0x2::coin::mint<BEENZ>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BEENZ, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/9sbrLLnk4vxJajnZWXP9h5qk1NDFw7dz2eHjgemcpump.png?size=lg&key=84ae76                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BEENZ>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"Beenz   ")))), trim_right(b"Beenz                           "), trim_right(b"THE FIRST SHITCOIN Beenz was a virtual currency that was launched in 1998. It was created by Charles Cohen and was intended to encourage online spending and brand loyalty. Beenz could be earned by completing online activities, such as signing up for websites, and could be used as currency by participating traders.     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BEENZ>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BEENZ>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BEENZ>>(0x2::coin::mint<BEENZ>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

