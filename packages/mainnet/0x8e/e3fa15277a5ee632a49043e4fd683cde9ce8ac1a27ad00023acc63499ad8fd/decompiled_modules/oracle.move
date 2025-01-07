module 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::oracle {
    struct Price has copy, drop, store {
        price: u64,
        updated_at: u64,
    }

    struct KriyaOracle has key {
        id: 0x2::object::UID,
        supra_pair_ids: 0x2::table::Table<0x1::type_name::TypeName, u32>,
        prices_table: 0x2::table::Table<0x1::type_name::TypeName, Price>,
        staleness_threshold: u64,
    }

    public fun add_price_pair_id<T0>(arg0: &mut KriyaOracle, arg1: u32) {
        let v0 = 0x1::type_name::get<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, u32>(&arg0.supra_pair_ids, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u32>(&mut arg0.supra_pair_ids, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, u32>(&mut arg0.supra_pair_ids, v0, arg1);
    }

    public fun get_price<T0>(arg0: &KriyaOracle, arg1: &0x2::clock::Clock) : u64 {
        0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices_table, 0x1::type_name::get<T0>()).price
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = KriyaOracle{
            id                  : 0x2::object::new(arg0),
            supra_pair_ids      : 0x2::table::new<0x1::type_name::TypeName, u32>(arg0),
            prices_table        : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            staleness_threshold : 10000,
        };
        0x2::transfer::share_object<KriyaOracle>(v0);
    }

    public fun update_price<T0>(arg0: &mut KriyaOracle, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder) {
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2) = 0x8ee3fa15277a5ee632a49043e4fd683cde9ce8ac1a27ad00023acc63499ad8fd::supra_adapter::get_supra_price(arg1, *0x2::table::borrow<0x1::type_name::TypeName, u32>(&arg0.supra_pair_ids, v0));
        assert!(v1 > 0, 0);
        let v3 = Price{
            price      : v1,
            updated_at : v2,
        };
        if (0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices_table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, Price>(&mut arg0.prices_table, v0);
        };
        0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg0.prices_table, v0, v3);
    }

    // decompiled from Move bytecode v6
}

