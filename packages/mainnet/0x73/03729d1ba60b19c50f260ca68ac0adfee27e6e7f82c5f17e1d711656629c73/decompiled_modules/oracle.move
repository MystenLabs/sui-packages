module 0x7303729d1ba60b19c50f260ca68ac0adfee27e6e7f82c5f17e1d711656629c73::oracle {
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

    public fun add_price_pair_id(arg0: &mut KriyaOracle, arg1: u32, arg2: 0x1::type_name::TypeName) {
        if (0x2::table::contains<0x1::type_name::TypeName, u32>(&arg0.supra_pair_ids, arg2)) {
            0x2::table::remove<0x1::type_name::TypeName, u32>(&mut arg0.supra_pair_ids, arg2);
        };
        0x2::table::add<0x1::type_name::TypeName, u32>(&mut arg0.supra_pair_ids, arg2, arg1);
    }

    public fun get_price(arg0: &KriyaOracle, arg1: 0x1::type_name::TypeName, arg2: &0x2::clock::Clock) : u64 {
        let v0 = 0x2::table::borrow<0x1::type_name::TypeName, Price>(&arg0.prices_table, arg1);
        assert!(0x2::clock::timestamp_ms(arg2) - v0.updated_at <= arg0.staleness_threshold, 0);
        v0.price
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) : KriyaOracle {
        KriyaOracle{
            id                  : 0x2::object::new(arg0),
            supra_pair_ids      : 0x2::table::new<0x1::type_name::TypeName, u32>(arg0),
            prices_table        : 0x2::table::new<0x1::type_name::TypeName, Price>(arg0),
            staleness_threshold : 10000,
        }
    }

    public fun update_price(arg0: &mut KriyaOracle, arg1: &mut 0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg2: 0x1::type_name::TypeName) {
        let (v0, v1) = 0x7303729d1ba60b19c50f260ca68ac0adfee27e6e7f82c5f17e1d711656629c73::supra_adapter::get_supra_price(arg1, *0x2::table::borrow<0x1::type_name::TypeName, u32>(&arg0.supra_pair_ids, arg2));
        assert!(v0 > 0, 0);
        let v2 = Price{
            price      : v0,
            updated_at : v1,
        };
        if (0x2::table::contains<0x1::type_name::TypeName, Price>(&arg0.prices_table, arg2)) {
            0x2::table::remove<0x1::type_name::TypeName, Price>(&mut arg0.prices_table, arg2);
        };
        0x2::table::add<0x1::type_name::TypeName, Price>(&mut arg0.prices_table, arg2, v2);
    }

    // decompiled from Move bytecode v6
}

