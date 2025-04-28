module 0xcb2c2a720c5e213c5d0d38f9a189bea22447d70af7465a7b5e8ecdb61fa7c1d0::prize {
    struct PRIZE has drop {
        dummy_field: bool,
    }

    public fun mint(arg0: &mut 0x2::coin::TreasuryCap<PRIZE>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIZE>>(0x2::coin::mint<PRIZE>(arg0, arg1, arg3), arg2);
    }

    fun init(arg0: PRIZE, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/DBW4topT6adDEvSkHAyTKurDbj9GNoPqch8XW7hBK1b4.png?size=lg&key=1047df                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4) = 0x2::coin::create_currency<PRIZE>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"PRIZE   ")))), trim_right(b"The Prize Sui                   "), trim_right(b"The Ultimate Rewards Token win huge Jackpots every single hour just for holding. Instead of earning pennies every few hours win hundreds even thousands of dollars with every drawing paid directly to your wallet in $Sui! No hassle No claiming No staking.                                                                   "), v2, arg1);
        let v5 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<PRIZE>>(v4);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<PRIZE>>(v5);
        0x2::transfer::public_transfer<0x2::coin::Coin<PRIZE>>(0x2::coin::mint<PRIZE>(&mut v5, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
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

