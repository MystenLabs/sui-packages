module 0x9da1faddc97fd38448b688e5a064f1b4b3af9e43d7dab3cc07b681ec44ccff5a::single_oracle {
    struct SingleOracle<phantom T0> has store, key {
        id: 0x2::object::UID,
        price: u64,
        precision_decimal: u8,
        precision: u64,
        tolerance_ms: u64,
        threshold: u64,
        latest_update_ms: u64,
    }

    struct WhitelistRule<phantom T0: drop> has copy, drop, store {
        dummy_field: bool,
    }

    public(friend) fun new<T0>(arg0: u8, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : SingleOracle<T0> {
        SingleOracle<T0>{
            id                : 0x2::object::new(arg3),
            price             : 0,
            precision_decimal : arg0,
            precision         : 0x1::u64::pow(10, arg0),
            tolerance_ms      : arg1,
            threshold         : arg2,
            latest_update_ms  : 0,
        }
    }

    public(friend) fun add_rule<T0, T1: drop>(arg0: &mut SingleOracle<T0>) {
        let v0 = WhitelistRule<T1>{dummy_field: false};
        0x2::dynamic_field::add<WhitelistRule<T1>, bool>(&mut arg0.id, v0, true);
    }

    public fun get_price<T0>(arg0: &SingleOracle<T0>, arg1: &0x2::clock::Clock) : (u64, u64) {
        assert!(0x2::clock::timestamp_ms(arg1) <= arg0.latest_update_ms + 10000, 2);
        (arg0.price, arg0.precision)
    }

    public fun precision<T0>(arg0: &SingleOracle<T0>) : u64 {
        arg0.precision
    }

    public fun precision_decimal<T0>(arg0: &SingleOracle<T0>) : u8 {
        arg0.precision_decimal
    }

    public(friend) fun remove_rule<T0, T1: drop>(arg0: &mut SingleOracle<T0>) {
        let v0 = WhitelistRule<T1>{dummy_field: false};
        0x2::dynamic_field::remove<WhitelistRule<T1>, bool>(&mut arg0.id, v0);
    }

    public fun update_oracle_price_with_rule<T0, T1: drop>(arg0: &mut SingleOracle<T0>, arg1: T1, arg2: &0x2::clock::Clock, arg3: u64) {
        let v0 = WhitelistRule<T1>{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<WhitelistRule<T1>>(&arg0.id, v0), 3);
        arg0.price = arg3;
        arg0.latest_update_ms = 0x2::clock::timestamp_ms(arg2);
    }

    public(friend) fun update_price<T0>(arg0: &mut SingleOracle<T0>, arg1: &0x2::clock::Clock, arg2: u64) {
        arg0.price = arg2;
        arg0.latest_update_ms = 0x2::clock::timestamp_ms(arg1);
    }

    public(friend) fun update_threshold<T0>(arg0: &mut SingleOracle<T0>, arg1: u64) {
        arg0.threshold = arg1;
    }

    // decompiled from Move bytecode v7
}

