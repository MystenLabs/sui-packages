module 0xff77917fbfd3a78c744fb839c68093f058321ccbafacfb8a0c60308986fdedf0::dogem {
    struct DOGEM has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGEM>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGEM>>(0x2::coin::mint<DOGEM>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DOGEM, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/6TUBpChomxDdCq7VUDB5TGebVPLSC4KAHS2hfGAoN945.png?size=lg&key=ed8572                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGEM>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGEM   ")))), trim_right(b"Doge Matrix                     "), trim_right(b"Doge matrix cryptocurrency holds the potential to revolutionize the free world by breaking the elite's control over global systems. Through its integration of artificial intelligence, it ensures smarter, decentralized decision-making, free from centralized oversight.                                                     "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGEM>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGEM>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGEM>>(0x2::coin::mint<DOGEM>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

