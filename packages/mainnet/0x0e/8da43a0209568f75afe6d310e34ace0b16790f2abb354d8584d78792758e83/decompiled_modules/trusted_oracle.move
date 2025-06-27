module 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_oracle {
    struct TrustedOracleCap has store, key {
        id: 0x2::object::UID,
    }

    struct TrustedOracle has key {
        id: 0x2::object::UID,
        trusted_prices_cap: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceDataCap,
        price_validity_ms: u64,
        prices: 0x1::option::Option<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>,
    }

    public fun new(arg0: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::admin::AdminCap, arg1: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceDataCap, arg2: &mut 0x2::tx_context::TxContext) : (TrustedOracleCap, TrustedOracle) {
        let v0 = TrustedOracle{
            id                 : 0x2::object::new(arg2),
            trusted_prices_cap : arg1,
            price_validity_ms  : 30000,
            prices             : 0x1::option::some<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>(0x2::table::new<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>(arg2)),
        };
        let v1 = TrustedOracleCap{id: 0x2::object::new(arg2)};
        (v1, v0)
    }

    public(friend) fun share_object(arg0: TrustedOracle) {
        0x2::transfer::share_object<TrustedOracle>(arg0);
    }

    public fun destroy(arg0: TrustedOracle, arg1: TrustedOracleCap) : 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceDataCap {
        let TrustedOracle {
            id                 : v0,
            trusted_prices_cap : v1,
            price_validity_ms  : _,
            prices             : v3,
        } = arg0;
        0x2::table::drop<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>(0x1::option::destroy_some<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>(v3));
        0x2::object::delete(v0);
        let TrustedOracleCap { id: v4 } = arg1;
        0x2::object::delete(v4);
        v1
    }

    public fun make_prices(arg0: &mut TrustedOracle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceData {
        assert!(0x1::option::is_some<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>(&arg0.prices), 0);
        0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::create_trusted_price_data(0x1::option::extract<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>(&mut arg0.prices), arg1, &arg0.trusted_prices_cap, arg2)
    }

    public fun post_price<T0, T1>(arg0: &mut TrustedOracle, arg1: 0x1::uq32_32::UQ32_32, arg2: &TrustedOracleCap, arg3: &0x2::clock::Clock) {
        assert!(0x1::option::is_some<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>(&arg0.prices), 0);
        let v0 = 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::new_pair<T0, T1>();
        let v1 = 0x1::option::borrow_mut<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>(&mut arg0.prices);
        if (0x2::table::contains<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>(v1, v0)) {
            0x2::table::remove<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>(v1, v0);
        };
        0x2::table::add<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>(v1, v0, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::new_price_and_expiry(arg1, arg0.price_validity_ms, arg3));
    }

    public fun return_prices(arg0: &mut TrustedOracle, arg1: 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::TrustedPriceData) {
        assert!(0x1::option::is_none<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>(&arg0.prices), 1000);
        0x1::option::fill<0x2::table::Table<0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::price::Pair, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::PriceAndExpiry>>(&mut arg0.prices, 0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::trusted_prices::destroy_trusted_price_data(arg1, &arg0.trusted_prices_cap));
    }

    public fun update_price_expiry_ms(arg0: &mut TrustedOracle, arg1: u64, arg2: &0xe8da43a0209568f75afe6d310e34ace0b16790f2abb354d8584d78792758e83::admin::AdminCap) {
        arg0.price_validity_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

