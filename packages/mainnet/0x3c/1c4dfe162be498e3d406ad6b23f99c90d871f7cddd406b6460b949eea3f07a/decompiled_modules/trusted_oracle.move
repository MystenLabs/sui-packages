module 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_oracle {
    struct EventNewTrustedOracle has copy, drop {
        oracle_id: 0x2::object::ID,
        oracle_cap_id: 0x2::object::ID,
    }

    struct TrustedOracleCap has store, key {
        id: 0x2::object::UID,
        oracle: 0x2::object::ID,
    }

    struct TrustedOracle has key {
        id: 0x2::object::UID,
        trusted_prices_cap: 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::TrustedPriceDataCap,
        price_validity_ms: u64,
        prices: 0x1::option::Option<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>,
    }

    public fun new(arg0: 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::TrustedPriceDataCap, arg1: &mut 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::GlobalInfo, arg2: &mut 0x2::tx_context::TxContext) : TrustedOracleCap {
        let v0 = TrustedOracle{
            id                 : 0x2::object::new(arg2),
            trusted_prices_cap : arg0,
            price_validity_ms  : 30000,
            prices             : 0x1::option::some<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>(0x2::table::new<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>(arg2)),
        };
        let v1 = TrustedOracleCap{
            id     : 0x2::object::new(arg2),
            oracle : 0x2::object::id<TrustedOracle>(&v0),
        };
        let v2 = EventNewTrustedOracle{
            oracle_id     : 0x2::object::id<TrustedOracle>(&v0),
            oracle_cap_id : 0x2::object::id<TrustedOracleCap>(&v1),
        };
        0x2::event::emit<EventNewTrustedOracle>(v2);
        0x2::transfer::share_object<TrustedOracle>(v0);
        0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::global::update_shared_object_id<TrustedOracleCap>(arg1, b"trusted_oracle", &v1);
        v1
    }

    public(friend) fun assert_for_oracle(arg0: &TrustedOracleCap, arg1: &TrustedOracle) {
        assert!(arg0.oracle == 0x2::object::uid_to_inner(&arg1.id), 0);
    }

    public fun destroy(arg0: TrustedOracle, arg1: TrustedOracleCap) : 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::TrustedPriceDataCap {
        assert_for_oracle(&arg1, &arg0);
        let TrustedOracle {
            id                 : v0,
            trusted_prices_cap : v1,
            price_validity_ms  : _,
            prices             : v3,
        } = arg0;
        0x2::table::drop<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>(0x1::option::destroy_some<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>(v3));
        0x2::object::delete(v0);
        let TrustedOracleCap {
            id     : v4,
            oracle : _,
        } = arg1;
        0x2::object::delete(v4);
        v1
    }

    public fun make_prices(arg0: &mut TrustedOracle, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) : 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::TrustedPriceData {
        assert!(0x1::option::is_some<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>(&arg0.prices), 0);
        0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::create_trusted_price_data(0x1::option::extract<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>(&mut arg0.prices), arg1, &arg0.trusted_prices_cap, arg2)
    }

    public fun oracle_id(arg0: &TrustedOracleCap) : 0x2::object::ID {
        arg0.oracle
    }

    public fun post_price<T0>(arg0: &mut TrustedOracle, arg1: 0x1::uq32_32::UQ32_32, arg2: &TrustedOracleCap, arg3: &0x2::clock::Clock) {
        assert_for_oracle(arg2, arg0);
        assert!(0x1::option::is_some<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>(&arg0.prices), 0);
        let v0 = 0x1::type_name::get<T0>();
        let v1 = 0x1::option::borrow_mut<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>(&mut arg0.prices);
        if (0x2::table::contains<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>(v1, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>(v1, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>(v1, v0, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::new_price_and_expiry(arg1, arg0.price_validity_ms, arg3));
    }

    public fun return_prices(arg0: &mut TrustedOracle, arg1: 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::TrustedPriceData) {
        assert!(0x1::option::is_none<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>(&arg0.prices), 1000);
        0x1::option::fill<0x2::table::Table<0x1::type_name::TypeName, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::PriceAndExpiry>>(&mut arg0.prices, 0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::trusted_prices::destroy_trusted_price_data(arg1, &arg0.trusted_prices_cap));
    }

    public fun update_price_expiry_ms(arg0: &mut TrustedOracle, arg1: u64, arg2: &0x3c1c4dfe162be498e3d406ad6b23f99c90d871f7cddd406b6460b949eea3f07a::admin::AdminCap) {
        arg0.price_validity_ms = arg1;
    }

    // decompiled from Move bytecode v6
}

