module 0x4adcffcd9e8946b24426edfeefbdb023f5e3023035d4eaf1ba471e9ac69bee1b::price_provider {
    struct PriceProvider has store, key {
        id: 0x2::object::UID,
        owner: address,
        prices: 0x2::table::Table<address, u64>,
    }

    public fun new(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceProvider{
            id     : 0x2::object::new(arg0),
            owner  : 0x2::tx_context::sender(arg0),
            prices : 0x2::table::new<address, u64>(arg0),
        };
        0x2::transfer::share_object<PriceProvider>(v0);
    }

    public fun get_price(arg0: &PriceProvider, arg1: address) : u64 {
        if (0x2::table::contains<address, u64>(&arg0.prices, arg1)) {
            *0x2::table::borrow<address, u64>(&arg0.prices, arg1)
        } else {
            0
        }
    }

    public fun has_feed(arg0: &PriceProvider, arg1: address) : bool {
        0x2::table::contains<address, u64>(&arg0.prices, arg1)
    }

    public fun update_price(arg0: &mut PriceProvider, arg1: address, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg3), 0);
        assert!(arg2 > 0, 1);
        if (0x2::table::contains<address, u64>(&arg0.prices, arg1)) {
            0x2::table::remove<address, u64>(&mut arg0.prices, arg1);
            0x2::table::add<address, u64>(&mut arg0.prices, arg1, arg2);
        } else {
            0x2::table::add<address, u64>(&mut arg0.prices, arg1, arg2);
        };
    }

    // decompiled from Move bytecode v6
}

