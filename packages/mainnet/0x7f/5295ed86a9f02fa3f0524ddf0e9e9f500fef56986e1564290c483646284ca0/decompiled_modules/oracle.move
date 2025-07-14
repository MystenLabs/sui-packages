module 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle {
    struct PriceFeedsMap<phantom T0> has key {
        id: 0x2::object::UID,
        map: 0x2::vec_map::VecMap<0x1::string::String, vector<u8>>,
    }

    public fun get_price<T0>(arg0: &0x2::clock::Clock, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x1::string::String, arg3: &PriceFeedsMap<T0>, arg4: u64, arg5: u64) : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg0, arg4);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        assert!((0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(&v0) as u256) * 100 <= (((0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::oracle_operations::get_magnitude(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(&v0)) as u256) * (arg5 as u256)) as u256), 2);
        assert!(*0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg3.map, arg2) == 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2), 1);
        v0
    }

    public fun insert_to_price_feed_map<T0>(arg0: &mut PriceFeedsMap<T0>, arg1: &0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::Auth<T0>, arg2: &0x1::string::String, arg3: vector<u8>, arg4: &0x2::tx_context::TxContext) {
        assert!(0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::has_cap<T0, 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg4)), 4);
        0x2::vec_map::insert<0x1::string::String, vector<u8>>(&mut arg0.map, *arg2, arg3);
    }

    public fun is_pegged_to_base<T0>(arg0: &0x1::string::String, arg1: &PriceFeedsMap<T0>) : bool {
        let v0 = b"PEGGED_TO_BASE";
        assert!(0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg1.map, arg0), 3);
        0x2::vec_map::get<0x1::string::String, vector<u8>>(&arg1.map, arg0) == &v0
    }

    public(friend) fun new_empty_price_feed_map<T0>(arg0: &mut 0x2::tx_context::TxContext) : PriceFeedsMap<T0> {
        PriceFeedsMap<T0>{
            id  : 0x2::object::new(arg0),
            map : 0x2::vec_map::empty<0x1::string::String, vector<u8>>(),
        }
    }

    public fun peg_to_base<T0>(arg0: &mut PriceFeedsMap<T0>, arg1: &0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::Auth<T0>, arg2: &0x1::string::String, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::has_cap<T0, 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        if (0x2::vec_map::contains<0x1::string::String, vector<u8>>(&arg0.map, arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::string::String, vector<u8>>(&mut arg0.map, arg2);
            insert_to_price_feed_map<T0>(arg0, arg1, arg2, b"PEGGED_TO_BASE", arg3);
        } else {
            insert_to_price_feed_map<T0>(arg0, arg1, arg2, b"PEGGED_TO_BASE", arg3);
        };
    }

    public fun remove_from_price_feed_map<T0>(arg0: &mut PriceFeedsMap<T0>, arg1: &0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::Auth<T0>, arg2: &0x1::string::String, arg3: &0x2::tx_context::TxContext) {
        assert!(0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::has_cap<T0, 0x7f5295ed86a9f02fa3f0524ddf0e9e9f500fef56986e1564290c483646284ca0::auth::OwnerCap>(arg1, 0x2::tx_context::sender(arg3)), 4);
        let (_, _) = 0x2::vec_map::remove<0x1::string::String, vector<u8>>(&mut arg0.map, arg2);
    }

    public fun share<T0>(arg0: PriceFeedsMap<T0>) {
        0x2::transfer::share_object<PriceFeedsMap<T0>>(arg0);
    }

    // decompiled from Move bytecode v6
}

