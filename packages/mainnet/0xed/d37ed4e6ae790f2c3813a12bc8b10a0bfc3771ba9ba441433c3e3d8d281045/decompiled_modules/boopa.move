module 0xedd37ed4e6ae790f2c3813a12bc8b10a0bfc3771ba9ba441433c3e3d8d281045::boopa {
    struct BOOPA has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<BOOPA>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOPA>>(0x2::coin::mint<BOOPA>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: BOOPA, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/JmMRbLcKgNCu17yHZDAn4strE5NjmWJ4pCeJ7s7boop.png?size=lg&key=9a3291                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<BOOPA>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"BOOPA   ")))), trim_right(b"Boopa                           "), trim_right(b"Meet the BOOP family, brought to you by Dingaling. Boopi and Boopa are not just cute faces - they're part of a growing community that's taking the crypto world by storm!                                                                                                                                                       "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<BOOPA>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<BOOPA>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<BOOPA>>(0x2::coin::mint<BOOPA>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

