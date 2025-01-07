module 0x77c3e26777dbee1be246527db0700d92152f55596eaa7a6756e31cd94299e44e::evan {
    struct EVAN has drop {
        dummy_field: bool,
    }

    public fun deposit(arg0: &mut 0x2::deny_list::DenyList, arg1: &mut 0x2::coin::DenyCapV2<EVAN>, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        0x2::coin::deny_list_v2_add<EVAN>(arg0, arg1, arg2, arg3);
    }

    fun init(arg0: EVAN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = trim_right(b"111111111   ");
        let v1 = trim_right(b"https://dd.dexscreener.com/ds-data/tokens/solana/GFUgXbMeDnLkhZaJS3nYFqunqkFNMRo9ukhyajeXpump.png?size=lg&key=d451b5                                                                                                                                                                                                            ");
        let v2 = if (0x1::vector::length<u8>(&v1) == 0) {
            0x1::option::none<0x2::url::Url>()
        } else {
            0x1::option::some<0x2::url::Url>(0x2::url::new_unsafe_from_bytes(v1))
        };
        let (v3, v4, v5) = 0x2::coin::create_regulated_currency_v2<EVAN>(arg0, (0x1::vector::length<u8>(&v0) as u8), 0x1::ascii::into_bytes(0x1::string::to_ascii(0x1::string::utf8(trim_right(b"EVAN    ")))), trim_right(b"Evan                            "), trim_right(b"$EVAN is the gremlin god of degens, born from the collective consciousness of SUI warriors, to shield the sleepless and chart-obsessed. At 3AM, it awakens, fueled by Monster Energy and borrowed liquidity from protocols that don't even exist yet to protect trench warriors from getting rekd. In $EVAN We Trust.           "), v2, false, arg1);
        let v6 = v3;
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<EVAN>>(v5);
        0x2::transfer::public_freeze_object<0x2::coin::TreasuryCap<EVAN>>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<EVAN>>(0x2::coin::mint<EVAN>(&mut v6, 1000000000000000000, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::DenyCapV2<EVAN>>(v4, 0x2::tx_context::sender(arg1));
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

