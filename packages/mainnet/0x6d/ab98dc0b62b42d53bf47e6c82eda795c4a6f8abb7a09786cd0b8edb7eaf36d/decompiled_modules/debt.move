module 0x6dab98dc0b62b42d53bf47e6c82eda795c4a6f8abb7a09786cd0b8edb7eaf36d::debt {
    struct DEBT has drop {
        dummy_field: bool,
    }

    fun init(arg0: DEBT, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/vLieQF5eDqUuuk8RzRaqgAHkXr7bSEBZaWk9Zfibonk.png                                                                                                                                                                                                                                ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<DEBT>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"DEBT        ")))), trim_right(b"DebtCoin                        "), trim_right(b"Helping chip away at the US national debt. Built on community, driven by purpose. $DEBT                                                                                                                                                                                                                                         "), v2, arg1);
        0x2::transfer::public_transfer<0x2::coin::TreasuryCap<DEBT>>(v3, 0x2::tx_context::sender(arg1));
        0x2::transfer::public_share_object<0x2::coin::CoinMetadata<DEBT>>(v4);
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

