module 0xcc88e22d5042c96a1e6c234c00656d9849c6ef43ff8d59d96f7ae8d90d8a4aae::log {
    struct LOG has key {
        id: 0x2::object::UID,
    }

    struct CurrencyCreationCap has store, key {
        id: 0x2::object::UID,
    }

    public fun create_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: CurrencyCreationCap, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LOG>, 0x2::coin_registry::MetadataCap<LOG>) {
        create_currency_inner(arg1, arg0, arg2)
    }

    fun create_currency_inner(arg0: CurrencyCreationCap, arg1: &mut 0x2::coin_registry::CoinRegistry, arg2: &mut 0x2::tx_context::TxContext) : (0x2::coin::Coin<LOG>, 0x2::coin_registry::MetadataCap<LOG>) {
        let CurrencyCreationCap { id: v0 } = arg0;
        0x2::object::delete(v0);
        let (v1, v2) = prepare_currency(arg1, arg2);
        (v2, 0x2::coin_registry::finalize<LOG>(v1, arg2))
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CurrencyCreationCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<CurrencyCreationCap>(v0, 0x2::tx_context::sender(arg0));
    }

    fun prepare_currency(arg0: &mut 0x2::coin_registry::CoinRegistry, arg1: &mut 0x2::tx_context::TxContext) : (0x2::coin_registry::CurrencyInitializer<LOG>, 0x2::coin::Coin<LOG>) {
        let (v0, v1) = 0x2::coin_registry::new_currency<LOG>(arg0, 9, 0x1::string::utf8(b"LOG"), 0x1::string::utf8(b"LOG"), 0x1::string::utf8(b"Official LOG ecosystem token"), 0x1::string::utf8(b"https://uselog.xyz/assets/png/log-token-256.png"), arg1);
        let v2 = v1;
        let v3 = v0;
        0x2::coin_registry::make_supply_fixed_init<LOG>(&mut v3, v2);
        (v3, 0x2::coin::mint<LOG>(&mut v2, 100000000000000000, arg1))
    }

    public fun total_supply() : u64 {
        100000000000000000
    }

    // decompiled from Move bytecode v7
}

