module 0xcaaffb2bc537dc422fd723de6547c86c3c0fe27947b58316e771ea8cc884d538::trace {
    struct TRCE has key {
        id: 0x2::object::UID,
    }

    struct CurrencyCreationCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: CurrencyCreationCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<TRCE>, 0x2::coin_registry::MetadataCap<TRCE>) {
        create_currency_inner(arg1, arg0, arg2)
    }

    fun create_currency_inner(arg0: CurrencyCreationCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<TRCE>, 0x2::coin_registry::MetadataCap<TRCE>) {
        let CurrencyCreationCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let (v1, v2) = prepare_currency(arg1, arg2);
        (v2, 0x2::coin_registry::finalize<TRCE>(v1, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CurrencyCreationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CurrencyCreationCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun prepare_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<TRCE>, 0x2::coin::Coin<TRCE>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<TRCE>(arg0, 9, 0x1::string::utf8(b"TRCE"), 0x1::string::utf8(b"Trace"), 0x1::string::utf8(b"Trace token for the LOG ecosystem"), 0x1::string::utf8(b"https://uselog.xyz/assets/png/log-token-256.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<TRCE>(&mut v3, v2);
        (v3, 0x2::coin::mint<TRCE>(&mut v2, 500000000000000000, arg1))
    }

    public fun total_supply() : u64 {
        500000000000000000
    }

    // decompiled from Move bytecode v7
}

