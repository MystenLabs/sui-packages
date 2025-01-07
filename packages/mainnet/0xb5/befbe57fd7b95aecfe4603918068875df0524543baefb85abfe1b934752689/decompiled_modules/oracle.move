module 0xb5befbe57fd7b95aecfe4603918068875df0524543baefb85abfe1b934752689::oracle {
    struct Price has copy, drop, store {
        price: u64,
        updated_at: u64,
    }

    struct KriyaOracle has key {
        id: 0x2::object::UID,
        price_info_id_table: 0x2::table::Table<0x1::type_name::TypeName, 0x2::object::ID>,
        prices_table: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        staleness_threshold: u64,
    }

    public fun get_price(arg0: &KriyaOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices_table, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) - v0.updated_at <= arg0.staleness_threshold, 0);
        v0.price
    }

    public fun add_price_info_id(arg0: &mut KriyaOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: 0x1::type_name::TypeName) {
        if (0x2::table::contains<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_info_id_table, arg2)) {
            0x2::table::remove<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.price_info_id_table, arg2);
        };
        0x2::table::add<0x1::type_name::TypeName, 0x2::object::ID>(&mut arg0.price_info_id_table, arg2, 0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg1));
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) : KriyaOracle {
        KriyaOracle{
            id                  : 0x2::object::new(arg0),
            price_info_id_table : 0x2::table::new<0x1::type_name::TypeName, 0x2::object::ID>(arg0),
            prices_table        : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            staleness_threshold : 10000,
        }
    }

    public fun update_price(arg0: &mut KriyaOracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::state::State, arg2: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg3: 0x1::type_name::TypeName, arg4: &0x2::clock::Clock) {
        assert!(0x2::object::id<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject>(arg2) == *0x2::table::borrow<0x1::type_name::TypeName, 0x2::object::ID>(&arg0.price_info_id_table, arg3), 0);
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price(arg1, arg2, arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1);
        let v3 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(&v0);
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v3);
        assert!(v4 <= 255, 0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0);
        assert!(v5 >= 0x2::clock::timestamp_ms(arg4) - arg0.staleness_threshold, 0);
        let v6 = 10000;
        assert!(((((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) * v6 * 100) as u128) / (v2 as u128)) as u64) <= 2 * v6, 0);
        let v7 = (v4 as u8);
        let v8 = if (v7 < 9) {
            v2 * 0x2::math::pow(10, 9 - v7)
        } else {
            v2 / 0x2::math::pow(10, 9 - v7)
        };
        assert!(v8 > 0, 0);
        let v9 = Price{
            price      : v8,
            updated_at : v5,
        };
        if (0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices_table, arg3)) {
            0x2::table::remove<0x1::type_name::TypeName, Price>(&mut arg0.prices_table, arg3);
        };
        0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg0.prices_table, arg3, v9);
    }

    // decompiled from Move bytecode v6
}

