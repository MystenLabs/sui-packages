module 0xfa586dca0c394eb1b1a963c9dcd6a834a7b7cad05eae9ccf0f4f0de6fa13590a::oracle {
    struct ORACLE has drop {
        dummy_field: bool,
    }

    struct PriceUpdationEvent has copy, drop {
        id: 0x2::object::ID,
        coin_type: 0x1::type_name::TypeName,
        pyth_price_id: vector<u8>,
        price: 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::Number,
        ema_price: 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::Number,
        last_updated: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Oracle has store, key {
        id: 0x2::object::UID,
        coin_to_identifier: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>,
        pyth_identifier_map: 0x2::vec_map::VecMap<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>,
        price_infos: 0x2::table::Table<0x1::type_name::TypeName, PriceInfo>,
        max_age: u64,
    }

    struct PriceInfo has store, key {
        id: 0x2::object::UID,
        coin_type: 0x1::type_name::TypeName,
        pyth_price_id: vector<u8>,
        price: 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::Number,
        ema_price: 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::Number,
        last_updated: u64,
    }

    public fun get_price(arg0: &PriceInfo) : 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::Number {
        arg0.price
    }

    public fun get_ema_price(arg0: &PriceInfo) : 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::Number {
        arg0.ema_price
    }

    public fun add_coin_to_oracle(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, arg4: 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&arg0.pyth_identifier_map, &arg3), 9223372620970328065);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 9223372633855361027);
        let v0 = 0x1::vector::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>();
        if (0x1::option::is_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg4)) {
            let v1 = 0x1::option::extract<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg4);
            assert!(0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&arg0.pyth_identifier_map, &v1), 9223372668215361543);
            0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v0, v1);
        };
        0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v0, arg3);
        0x2::vec_map::insert<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut arg0.pyth_identifier_map, arg3, arg2);
        let v2 = PriceInfo{
            id            : 0x2::object::new(arg5),
            coin_type     : arg2,
            pyth_price_id : 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&arg3),
            price         : 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::from(0),
            ema_price     : 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::from(0),
            last_updated  : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2, v2);
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&mut arg0.coin_to_identifier, arg2, v0);
    }

    public fun create_additional_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    fun create_oracle(arg0: &mut 0x2::tx_context::TxContext) : (Oracle, AdminCap) {
        let v0 = Oracle{
            id                  : 0x2::object::new(arg0),
            coin_to_identifier  : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(),
            pyth_identifier_map : 0x2::vec_map::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(),
            price_infos         : 0x2::table::new<0x1::type_name::TypeName, PriceInfo>(arg0),
            max_age             : 20,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v1)
    }

    public fun get_all_supported_price_identifiers(arg0: &Oracle) : vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier> {
        0x2::vec_map::keys<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&arg0.pyth_identifier_map)
    }

    public fun get_identifiers_for_coin(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier> {
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&arg0.coin_to_identifier, &arg1), 9223373183611043839);
        *0x2::vec_map::get<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&arg0.coin_to_identifier, &arg1)
    }

    public fun get_price_info(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : &PriceInfo {
        0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg1)
    }

    public fun get_updated_time(arg0: &PriceInfo) : u64 {
        arg0.last_updated
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_oracle(arg1);
        0x2::transfer::public_share_object<Oracle>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun parse_price_to_number(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::Number {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::div(0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u8))))
        } else {
            0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::mul(0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u8))))
        }
    }

    public fun remove_coin_type(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 9223372947388104709);
        let v0 = 0x2::table::remove<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::from_byte_vec(v0.pyth_price_id);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&mut arg0.coin_to_identifier, &arg2);
        let (_, _) = 0x2::vec_map::remove<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut arg0.pyth_identifier_map, &v1);
        let PriceInfo {
            id            : v6,
            coin_type     : _,
            pyth_price_id : _,
            price         : _,
            ema_price     : _,
            last_updated  : _,
        } = v0;
        0x2::object::delete(v6);
    }

    public fun update_identifier_for_coin(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>, arg4: 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 9223372788474314757);
        let v0 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2);
        let v1 = 0x1::vector::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>();
        if (0x1::option::is_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg4)) {
            let v2 = 0x1::option::extract<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg4);
            assert!(0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&arg0.pyth_identifier_map, &v2), 9223372822834184199);
            0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v1, v2);
        };
        if (0x1::option::is_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg3)) {
            let v3 = 0x1::option::extract<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg3);
            assert!(!0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&arg0.pyth_identifier_map, &v3), 9223372852898562049);
            0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v1, v3);
            0x2::vec_map::insert<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut arg0.pyth_identifier_map, v3, arg2);
            v0.pyth_price_id = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v3);
        } else {
            0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v1, 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::from_byte_vec(0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2).pyth_price_id));
        };
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&mut arg0.coin_to_identifier, &arg2);
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&mut arg0.coin_to_identifier, arg2, v1);
    }

    public fun update_max_age(arg0: &mut Oracle, arg1: &AdminCap, arg2: u64) {
        arg0.max_age = arg2;
    }

    public fun update_price(arg0: &mut Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, 15);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        let v3 = parse_price_to_number(&v0);
        let v4 = v3;
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0);
        let v6 = v5;
        let v7 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v1));
        let v8 = parse_price_to_number(&v7);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2) == x"0449948a9a210481464ea7030734fa79f59b751c2f411cfb1ba56b5f69e4a62a") {
            let v9 = get_price_info(arg0, 0x1::type_name::get<0x2::sui::SUI>());
            let v10 = 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::mul(v3, v9.price);
            v4 = v10;
            v8 = 0x482801dd5944c6ba06810966647f6835240c750bc3e980917a3e9e4617f278bc::math::mul(v10, v9.ema_price);
            if (v5 > v9.last_updated) {
                v6 = v9.last_updated;
            };
        };
        let v11 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, *0x2::vec_map::get<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&arg0.pyth_identifier_map, &v2));
        v11.ema_price = v8;
        v11.price = v4;
        v11.last_updated = v6;
        let v12 = PriceUpdationEvent{
            id            : 0x2::object::id<PriceInfo>(v11),
            coin_type     : v11.coin_type,
            pyth_price_id : v11.pyth_price_id,
            price         : v4,
            ema_price     : v8,
            last_updated  : v6,
        };
        0x2::event::emit<PriceUpdationEvent>(v12);
    }

    // decompiled from Move bytecode v6
}

