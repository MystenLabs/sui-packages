module 0x2bdc716d6356f02d74ad483148692a456fb56f98b9ff9db87d975d03b25cd31c::dogs {
    struct DOGS has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<DOGS>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGS>>(0x2::coin::mint<DOGS>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: DOGS, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DPJZgS7SSn98MSrDKft4bUWMF98gSWeDs4WuBUuL6xmD.png?size=lg&key=22687b                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DOGS>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DOGS    ")))), trim_right(b"DOGE SKYWALKER                  "), trim_right(b"Doge Skywalker, a charismatic Shiba Inu from the Meme System, wields humor and heart as deftly as his lightsaber.                                                                                                                                                                                                               "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<DOGS>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<DOGS>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<DOGS>>(0x2::coin::mint<DOGS>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

