module 0xf9f31e0b26ca42263a68f27d8c28642baeac6d6810ef2d79a211c2d0ef6ad7f5::coral {
    struct CORAL has drop {
        dummy_field: bool,
    }

    struct CoralWitness has drop {
        dummy_field: bool,
    }

    public(friend) fun resolve_market<T0>(arg0: &mut 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::Market<T0>, arg1: vector<u8>, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::vec_set::keys<vector<u8>>(0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::outcome_values<T0>(arg0));
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<vector<u8>>(v0)) {
            if (0x1::vector::borrow<vector<u8>>(v0, v1) == &arg1) {
                v2 = 0x1::option::some<u64>(v1);
                /* label 6 */
                assert!(0x1::option::is_some<u64>(&v2), 0);
                let v3 = CoralWitness{dummy_field: false};
                0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::resolve_market<T0, CoralWitness>(arg0, 0x1::option::destroy_some<u64>(v2), v3, arg2);
                return
            };
            v1 = v1 + 1;
        };
        v2 = 0x1::option::none<u64>();
        /* goto 6 */
    }

    public fun create_market_with_custom_topic<T0, T1>(arg0: &0x2::coin_registry::Currency<T1>, arg1: &0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::config::ProtocolConfig, arg2: &mut 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::protocol::Protocol, arg3: &0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::resolver::Resolver, arg4: vector<u8>, arg5: vector<u8>, arg6: 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::schema::DataType, arg7: vector<vector<u8>>, arg8: 0x1::option::Option<u64>, arg9: u64, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : (0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::Market<T1>, 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::CreatorCap) {
        let v0 = CoralWitness{dummy_field: false};
        let (v1, v2) = 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::create_market<T1, CoralWitness>(arg0, arg1, v0, 0x1::option::none<0x2::object::ID>(), arg8, 0x1::option::some<u64>(arg9), arg5, arg7, arg10, arg11);
        let v3 = v1;
        let v4 = CoralWitness{dummy_field: false};
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x2::object::ID>(v6, 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::id<T1>(&mut v3));
        0x1::vector::push_back<0x2::object::ID>(v6, 0x2::object::id<0x2::clock::Clock>(arg10));
        let v7 = 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::create_with_schema<T0, CoralWitness>(v4, arg2, arg3, 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::new_custom_schema(0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::schema::new_options_schema(arg6, arg7)), arg4, arg5, 0x1::option::none<u64>(), 0x1::option::none<u64>(), v5, arg10, arg11);
        let v8 = CoralWitness{dummy_field: false};
        0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::set_oracle_id<T1, CoralWitness>(&mut v3, v8, 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::id<T0>(&v7));
        0x2::transfer::public_share_object<0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::Query<T0>>(v7);
        (v3, v2)
    }

    public fun create_market_with_standard_topic<T0, T1>(arg0: &0x2::coin_registry::Currency<T1>, arg1: &0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::config::ProtocolConfig, arg2: &mut 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::protocol::Protocol, arg3: &0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::resolver::Resolver, arg4: vector<u8>, arg5: u64, arg6: vector<u8>, arg7: 0x1::option::Option<u64>, arg8: u64, arg9: &0x2::clock::Clock, arg10: &mut 0x2::tx_context::TxContext) : (0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::Market<T1>, 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::CreatorCap) {
        let v0 = CoralWitness{dummy_field: false};
        let (v1, v2) = 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::create_market<T1, CoralWitness>(arg0, arg1, v0, 0x1::option::none<0x2::object::ID>(), arg7, 0x1::option::some<u64>(arg8), arg6, 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::schema::options(0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::protocol::topic_schema(arg2, arg4, arg5)), arg9, arg10);
        let v3 = v1;
        let v4 = CoralWitness{dummy_field: false};
        let v5 = 0x1::vector::empty<0x2::object::ID>();
        let v6 = &mut v5;
        0x1::vector::push_back<0x2::object::ID>(v6, 0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::id<T1>(&mut v3));
        0x1::vector::push_back<0x2::object::ID>(v6, 0x2::object::id<0x2::clock::Clock>(arg9));
        let v7 = 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::create<T0, CoralWitness>(v4, arg2, arg3, arg4, arg5, arg6, 0x1::option::none<u64>(), 0x1::option::none<u64>(), v5, arg9, arg10);
        let v8 = CoralWitness{dummy_field: false};
        0x265ba5ccf346b8c8a0c3f80a600347cfaa3f005a2d594d7acfcfc6081f72767e::market::set_oracle_id<T1, CoralWitness>(&mut v3, v8, 0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::id<T0>(&v7));
        0x2::transfer::public_share_object<0x2a90623ad1931724f7d60995f7497bb292b0b2408fb7beba72bf1a355a76cab::query::Query<T0>>(v7);
        (v3, v2)
    }

    fun init(arg0: CORAL, arg1: &mut 0x2::tx_context::TxContext) {
        0x2::package::claim_and_keep<CORAL>(arg0, arg1);
    }

    public(friend) fun witness() : CoralWitness {
        CoralWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

