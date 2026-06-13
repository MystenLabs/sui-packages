module 0x8c9b578a0eca6bd2b735fd3e8a8594e326bf07ae8b036dbcf794b11e9658717d::burn_only_supply {
    struct BURN_ONLY_SUPPLY has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin_registry::Currency<BURN_ONLY_SUPPLY>, arg1: 0x2::coin::Coin<BURN_ONLY_SUPPLY>) {
        0x2::coin_registry::burn<BURN_ONLY_SUPPLY>(arg0, arg1);
    }

    fun init(arg0: BURN_ONLY_SUPPLY, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<BURN_ONLY_SUPPLY>(arg0, 6, 0x1::string::utf8(b"BURN_ONLY_SUPPLY"), 0x1::string::utf8(b"Deflationary Supply Coin"), 0x1::string::utf8(b"Cannot be minted, but can be burned"), 0x1::string::utf8(b"https://example.com/my_coin.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<BURN_ONLY_SUPPLY>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<BURN_ONLY_SUPPLY>>(0x2::coin_registry::finalize<BURN_ONLY_SUPPLY>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<BURN_ONLY_SUPPLY>>(0x2::coin::mint<BURN_ONLY_SUPPLY>(&mut v2, 1000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

