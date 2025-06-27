module 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::trusted_prices {
    struct TrustedPriceDataCap has store, key {
        id: 0x2::object::UID,
    }

    struct EventNewTrustedPriceDataCap has copy, drop {
        id: 0x2::object::ID,
    }

    struct PriceAndExpiry has copy, drop, store {
        value: 0x1::uq32_32::UQ32_32,
        expiry_time_ms: u64,
    }

    struct TrustedPriceData {
        current_time_ms: u64,
        prices: 0x2::table::Table<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, PriceAndExpiry>,
        cache: 0x2::table::Table<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>,
    }

    public fun new(arg0: &0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) : TrustedPriceDataCap {
        let v0 = TrustedPriceDataCap{id: 0x2::object::new(arg1)};
        let v1 = EventNewTrustedPriceDataCap{id: 0x2::object::id<TrustedPriceDataCap>(&v0)};
        0x2::event::emit<EventNewTrustedPriceDataCap>(v1);
        v0
    }

    fun compute_price(arg0: &TrustedPriceData, arg1: 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair) : 0x1::uq32_32::UQ32_32 {
        if (0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::base(&arg1) == 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::quote(&arg1)) {
            return 0x1::uq32_32::from_int(1)
        };
        let v0 = if (0x2::table::contains<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, PriceAndExpiry>(&arg0.prices, arg1)) {
            *0x2::table::borrow<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, PriceAndExpiry>(&arg0.prices, arg1)
        } else {
            let v1 = 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::to_inverse(&arg1);
            assert!(0x2::table::contains<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, PriceAndExpiry>(&arg0.prices, v1), 1);
            let v2 = *0x2::table::borrow<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, PriceAndExpiry>(&arg0.prices, v1);
            let v3 = &mut v2;
            invert_price(v3);
            v2
        };
        let v4 = v0;
        assert!(v4.expiry_time_ms > arg0.current_time_ms, 0);
        v4.value
    }

    public fun create_empty_trusted_price_data(arg0: &TrustedPriceDataCap, arg1: &mut 0x2::tx_context::TxContext) : TrustedPriceData {
        TrustedPriceData{
            current_time_ms : 0,
            prices          : 0x2::table::new<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, PriceAndExpiry>(arg1),
            cache           : 0x2::table::new<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>(arg1),
        }
    }

    public fun create_trusted_price_data(arg0: 0x2::table::Table<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, PriceAndExpiry>, arg1: &0x2::clock::Clock, arg2: &TrustedPriceDataCap, arg3: &mut 0x2::tx_context::TxContext) : TrustedPriceData {
        TrustedPriceData{
            current_time_ms : 0x2::clock::timestamp_ms(arg1),
            prices          : arg0,
            cache           : 0x2::table::new<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>(arg3),
        }
    }

    public fun destroy(arg0: TrustedPriceDataCap) {
        let TrustedPriceDataCap { id: v0 } = arg0;
        0x2::object::delete(v0);
    }

    public fun destroy_trusted_price_data(arg0: TrustedPriceData, arg1: &TrustedPriceDataCap) : 0x2::table::Table<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, PriceAndExpiry> {
        let TrustedPriceData {
            current_time_ms : _,
            prices          : v1,
            cache           : v2,
        } = arg0;
        0x2::table::drop<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>(v2);
        v1
    }

    fun invert_price(arg0: &mut PriceAndExpiry) {
        arg0.value = 0x1::uq32_32::div(0x1::uq32_32::from_int(1), arg0.value);
    }

    public fun new_price_and_expiry(arg0: 0x1::uq32_32::UQ32_32, arg1: u64, arg2: &0x2::clock::Clock) : PriceAndExpiry {
        PriceAndExpiry{
            value          : arg0,
            expiry_time_ms : 0x2::clock::timestamp_ms(arg2) + arg1,
        }
    }

    public fun pull_price<T0, T1>(arg0: &mut TrustedPriceData) : 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::PairPrice<T0, T1> {
        0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::new_pair_price<T0, T1>(pull_price_internal(arg0, 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::new_pair<T0, T1>()))
    }

    fun pull_price_internal(arg0: &mut TrustedPriceData, arg1: 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair) : 0x1::uq32_32::UQ32_32 {
        if (0x2::table::contains<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>(&arg0.cache, arg1)) {
            *0x2::table::borrow<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>(&arg0.cache, arg1)
        } else {
            let v1 = compute_price(arg0, arg1);
            0x2::table::add<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>(&mut arg0.cache, arg1, v1);
            v1
        }
    }

    public fun pull_raw_price(arg0: &mut TrustedPriceData, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName) : 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::RawPrice {
        0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::new_raw_price(pull_price_internal(arg0, 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::new_pair_from_raw(arg1, arg2)))
    }

    public fun set_price<T0, T1>(arg0: &mut TrustedPriceData, arg1: 0x1::uq32_32::UQ32_32, arg2: &TrustedPriceDataCap) {
        set_price_raw(arg0, 0x1::type_name::get<T0>(), 0x1::type_name::get<T1>(), arg1, arg2);
    }

    public fun set_price_raw(arg0: &mut TrustedPriceData, arg1: 0x1::type_name::TypeName, arg2: 0x1::type_name::TypeName, arg3: 0x1::uq32_32::UQ32_32, arg4: &TrustedPriceDataCap) {
        let v0 = 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::new_pair_from_raw(arg1, arg2);
        0x2::table::add<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>(&mut arg0.cache, v0, arg3);
        0x2::table::add<0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::Pair, 0x1::uq32_32::UQ32_32>(&mut arg0.cache, 0x77e9b4bbec28db0fb1067c81ffd8edbe679b3ed2298aeb2d6865c72d37e93128::price::to_inverse(&v0), 0x1::uq32_32::div(0x1::uq32_32::from_int(1), arg3));
    }

    // decompiled from Move bytecode v6
}

