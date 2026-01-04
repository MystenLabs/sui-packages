module 0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::pricing_guard {
    struct UsdToSuiQuoteEvent has copy, drop, store {
        usd_cents: u64,
        required_sui_mist: u64,
    }

    struct Guard has key {
        id: 0x2::object::UID,
        last_nonce: 0x2::table::Table<address, u64>,
    }

    public entry fun create_and_share(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Guard{
            id         : 0x2::object::new(arg0),
            last_nonce : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Guard>(v0);
    }

    public entry fun debug_get_sui_for_cents(arg0: &0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::config_registry::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: u64) {
        let v0 = UsdToSuiQuoteEvent{
            usd_cents         : arg4,
            required_sui_mist : usd_cents_to_sui_min_coins(arg0, arg1, arg2, arg3, arg4),
        };
        0x2::event::emit<UsdToSuiQuoteEvent>(v0);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Guard{
            id         : 0x2::object::new(arg0),
            last_nonce : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<Guard>(v0);
    }

    public fun usd_cents_to_sui_min_coins(arg0: &0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::config_registry::Config, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: &0x2::clock::Clock, arg4: u64) : u64 {
        arg4 * 100000000000 / 0x3e01531f86b2a18c54e288b78f6719114d5858ab973ed2eb38c1ff37fb3c660a::oracle_adapter::read_sui_usd_bps(arg0, arg1, arg2, arg3)
    }

    public fun validate_quote(arg0: &mut Guard, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::clock::timestamp_ms(arg3) < arg2, 1);
        let v1 = if (0x2::table::contains<address, u64>(&arg0.last_nonce, v0)) {
            *0x2::table::borrow<address, u64>(&arg0.last_nonce, v0)
        } else {
            0
        };
        assert!(arg1 > v1, 2);
        if (0x2::table::contains<address, u64>(&arg0.last_nonce, v0)) {
            *0x2::table::borrow_mut<address, u64>(&mut arg0.last_nonce, v0) = arg1;
        } else {
            0x2::table::add<address, u64>(&mut arg0.last_nonce, v0, arg1);
        };
    }

    // decompiled from Move bytecode v6
}

