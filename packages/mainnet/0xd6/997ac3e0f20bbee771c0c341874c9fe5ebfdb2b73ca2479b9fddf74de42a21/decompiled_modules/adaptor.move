module 0xd6997ac3e0f20bbee771c0c341874c9fe5ebfdb2b73ca2479b9fddf74de42a21::adaptor {
    struct CenterRegistry has key {
        id: 0x2::object::UID,
        table: 0x2::table::Table<0x1::type_name::TypeName, u8>,
        id_table: 0x2::table::Table<u8, 0x1::type_name::TypeName>,
    }

    struct CenterRegistryCap has store, key {
        id: 0x2::object::UID,
        for: 0x2::object::ID,
    }

    struct RegisterTokenEvent has copy, drop {
        admin: address,
        type_name: 0x1::ascii::String,
        index: u8,
    }

    fun assert_params(arg0: &CenterRegistry, arg1: vector<u8>) {
        let v0 = 0;
        let v1 = &arg0.id_table;
        while (v0 < 0x1::vector::length<u8>(&arg1)) {
            assert!(0x2::table::contains<u8, 0x1::type_name::TypeName>(v1, *0x1::vector::borrow<u8>(&arg1, v0)), 10001);
            v0 = v0 + 1;
        };
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = CenterRegistry{
            id       : 0x2::object::new(arg0),
            table    : 0x2::table::new<0x1::type_name::TypeName, u8>(arg0),
            id_table : 0x2::table::new<u8, 0x1::type_name::TypeName>(arg0),
        };
        let v1 = CenterRegistryCap{
            id  : 0x2::object::new(arg0),
            for : 0x2::object::id<CenterRegistry>(&v0),
        };
        0x2::transfer::share_object<CenterRegistry>(v0);
        0x2::transfer::transfer<CenterRegistryCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public entry fun register_center_token<T0>(arg0: &mut CenterRegistry, arg1: &CenterRegistryCap, arg2: &0xe7de25f46e8038f64314cbec062cf37c37a13bb341bf9992e4549c545fb28d68::navi_aggregator::NaviAggregator, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::object::id<CenterRegistry>(arg0) == arg1.for, 10000);
        let v0 = 0x1::type_name::get<T0>();
        let (v1, v2, _) = 0xe7de25f46e8038f64314cbec062cf37c37a13bb341bf9992e4549c545fb28d68::navi_aggregator::get_token_info<T0>(arg2);
        assert!(v1, 10001);
        if (0x2::table::contains<0x1::type_name::TypeName, u8>(&arg0.table, v0)) {
            0x2::table::remove<0x1::type_name::TypeName, u8>(&mut arg0.table, v0);
            0x2::table::remove<u8, 0x1::type_name::TypeName>(&mut arg0.id_table, v2);
        };
        0x2::table::add<0x1::type_name::TypeName, u8>(&mut arg0.table, v0, v2);
        0x2::table::add<u8, 0x1::type_name::TypeName>(&mut arg0.id_table, v2, v0);
        let v4 = RegisterTokenEvent{
            admin     : 0x2::tx_context::sender(arg3),
            type_name : 0x1::type_name::into_string(v0),
            index     : v2,
        };
        0x2::event::emit<RegisterTokenEvent>(v4);
    }

    public entry fun set_center_price(arg0: &CenterRegistry, arg1: &0xe7de25f46e8038f64314cbec062cf37c37a13bb341bf9992e4549c545fb28d68::navi_aggregator::NaviAggregatorCap, arg2: &mut 0xe7de25f46e8038f64314cbec062cf37c37a13bb341bf9992e4549c545fb28d68::navi_aggregator::NaviAggregator, arg3: &0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::OracleFeederCap, arg4: &mut 0xd7e35e63f6abb21bd6182db8d4d88cbbcad06f4175356fd201dcf435d0cf2306::oracle::PriceOracle, arg5: &0x2::clock::Clock, arg6: vector<u8>, arg7: vector<u256>, arg8: vector<u64>, arg9: &mut 0x2::tx_context::TxContext) {
        assert_params(arg0, arg6);
        0xe7de25f46e8038f64314cbec062cf37c37a13bb341bf9992e4549c545fb28d68::navi_aggregator::update_token_price_batch(arg1, arg2, arg3, arg4, arg5, 0, arg6, arg7, arg8, arg9);
    }

    // decompiled from Move bytecode v6
}

