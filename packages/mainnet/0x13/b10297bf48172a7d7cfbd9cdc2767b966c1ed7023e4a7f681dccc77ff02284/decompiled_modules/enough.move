module 0x13b10297bf48172a7d7cfbd9cdc2767b966c1ed7023e4a7f681dccc77ff02284::enough {
    struct ENOUGH has drop {
        dummy_field: bool,
    }

    public entry fun burn(arg0: &mut 0x2::coin::TreasuryCap<ENOUGH>, arg1: 0x2::coin::Coin<ENOUGH>) {
        0x2::coin::burn<ENOUGH>(arg0, arg1);
    }

    fun mint_and_transfer(arg0: &mut 0x2::coin::TreasuryCap<ENOUGH>, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::mint_and_transfer<ENOUGH>(arg0, arg1, arg2, arg3);
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<ENOUGH>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<ENOUGH>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: ENOUGH, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/b8mCYh9psBHCw5L5YZZTJgRuVcaDBd1zZD8TK1Cpump.png?size=lg&key=065050                                                                                                                                                                                                             ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<ENOUGH>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"ENOUGH    ")))), trim_right(b"Enough is enough                "), trim_right(b"                                                                                                                                                                                                                                                                                                                                "), v2, false, arg1);
        let v6 = v3;
        let v7 = &mut v6;
        let v8 = 0x2::tx_context::sender(arg1);
        mint_and_transfer(v7, 1000000000000000000, v8, arg1);
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<ENOUGH>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<ENOUGH>>(v6);
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<ENOUGH>>(v4, 0x2::tx_context::sender(arg1));
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

