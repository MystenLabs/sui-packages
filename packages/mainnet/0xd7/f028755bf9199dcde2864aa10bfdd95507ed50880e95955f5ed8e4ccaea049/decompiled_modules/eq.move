module 0xd7f028755bf9199dcde2864aa10bfdd95507ed50880e95955f5ed8e4ccaea049::eq {
    struct EQ has drop {
        dummy_field: bool,
    }

    public fun burn(arg0: &mut 0x2::coin_registry::Currency<EQ>, arg1: 0x2::coin::Coin<EQ>) {
        0x2::coin_registry::burn<EQ>(arg0, arg1);
    }

    fun init(arg0: EQ, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin_registry::new_currency_with_otw<EQ>(arg0, 6, 0x1::string::utf8(b"EQ"), 0x1::string::utf8(b"EQ Token"), 0x1::string::utf8(b"Utility and community rewards token for the EQ Harmony ecosystem"), 0x1::string::utf8(b"https://eq-harmony-chain-6psxg85.gamma.site/eq-token.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_burn_only_init<EQ>(&mut v3, v2);
        0x2::transfer::public_transfer<0x2::coin_registry::MetadataCap<EQ>>(0x2::coin_registry::finalize<EQ>(v3, arg1), 0x2::tx_context::sender(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<EQ>>(0x2::coin::mint<EQ>(&mut v2, 5000000000000000, arg1), 0x2::tx_context::sender(arg1));
    }

    // decompiled from Move bytecode v7
}

