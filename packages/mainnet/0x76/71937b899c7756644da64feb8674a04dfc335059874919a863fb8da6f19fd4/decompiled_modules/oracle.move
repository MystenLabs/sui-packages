module 0x378b2a104e8bcd7ed0317f5e6a0ec4fd271d4d12e2fe6c99bcd1f12be725cf4f::oracle {
    struct ORACLE has drop {
        dummy_field: bool,
    }

    struct PythPriceUpdationEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        pyth_price_id: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier,
        price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        ema_price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        conf: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_updated: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct OraclePyth has store, key {
        id: 0x2::object::UID,
        coin_to_identifier: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>,
        identifier_map: 0x2::vec_map::VecMap<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>,
    }

    struct OracleSupra has store, key {
        id: 0x2::object::UID,
        coin_to_identifier: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u64>>,
        identifier_map: 0x2::vec_map::VecMap<u64, 0x1::type_name::TypeName>,
    }

    struct AlternatePriceIdentifier has copy, drop, store {
        dummy_field: bool,
    }

    struct Oracle has store, key {
        id: 0x2::object::UID,
        price_infos: 0x2::table::Table<0x1::type_name::TypeName, PriceInfo>,
        max_age: u64,
    }

    struct PriceInfo has copy, drop, store {
        coin_type: 0x1::type_name::TypeName,
        price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        ema_price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        conf: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        coin_kind: u8,
        active: bool,
        circuit_breaker_threshold_bps: u16,
        last_updated: u64,
    }

    public fun add_alternate_price_identifier(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x1::type_name::TypeName) {
        let v0 = AlternatePriceIdentifier{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists_<AlternatePriceIdentifier>(&arg0.id, v0)) {
            let v2 = AlternatePriceIdentifier{dummy_field: false};
            0x2::dynamic_field::borrow_mut<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&mut arg0.id, v2)
        } else {
            let v3 = AlternatePriceIdentifier{dummy_field: false};
            0x2::dynamic_field::add<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&mut arg0.id, v3, 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::type_name::TypeName>());
            let v4 = AlternatePriceIdentifier{dummy_field: false};
            0x2::dynamic_field::borrow_mut<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&mut arg0.id, v4)
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v1, arg2, arg3);
    }

    public fun add_coin_to_oracle(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: u8, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(!0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 1);
        assert!(arg4 <= 10000, 5);
        assert!(arg3 == 0 || arg3 == 1, 8);
        let v0 = PriceInfo{
            coin_type                     : arg2,
            price                         : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            ema_price                     : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            conf                          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            coin_kind                     : arg3,
            active                        : true,
            circuit_breaker_threshold_bps : arg4,
            last_updated                  : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2, v0);
    }

    public fun add_coin_to_supra(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::option::Option<u64>) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, OracleSupra>(&mut arg0.id, 1);
        let v1 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v1, arg3);
        if (0x1::option::is_some<u64>(&arg4)) {
            let v2 = 0x1::option::extract<u64>(&mut arg4);
            assert!(0x2::vec_map::contains<u64, 0x1::type_name::TypeName>(&v0.identifier_map, &v2), 3);
            0x1::vector::push_back<u64>(&mut v1, v2);
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<u64>>(&mut v0.coin_to_identifier, arg2, v1);
        0x2::vec_map::insert<u64, 0x1::type_name::TypeName>(&mut v0.identifier_map, arg3, arg2);
    }

    public fun coin_type(arg0: &PriceInfo) : 0x1::type_name::TypeName {
        arg0.coin_type
    }

    public fun create_additional_admin_cap(arg0: &AdminCap, arg1: &mut 0x2::tx_context::TxContext) : AdminCap {
        AdminCap{id: 0x2::object::new(arg1)}
    }

    fun create_oracle(arg0: &mut 0x2::tx_context::TxContext) : (Oracle, AdminCap) {
        let v0 = Oracle{
            id          : 0x2::object::new(arg0),
            price_infos : 0x2::table::new<0x1::type_name::TypeName, PriceInfo>(arg0),
            max_age     : 20,
        };
        let v1 = OraclePyth{
            id                 : 0x2::object::new(arg0),
            coin_to_identifier : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(),
            identifier_map     : 0x2::vec_map::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(),
        };
        let v2 = OracleSupra{
            id                 : 0x2::object::new(arg0),
            coin_to_identifier : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u64>>(),
            identifier_map     : 0x2::vec_map::empty<u64, 0x1::type_name::TypeName>(),
        };
        0x2::dynamic_field::add<u64, OraclePyth>(&mut v0.id, 0, v1);
        0x2::dynamic_field::add<u64, OracleSupra>(&mut v0.id, 1, v2);
        let v3 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v3)
    }

    public fun get_all_supported_price_pyth_identifiers(arg0: &Oracle) : vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier> {
        0x2::vec_map::keys<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&0x2::dynamic_field::borrow<u64, OraclePyth>(&arg0.id, 0).identifier_map)
    }

    public fun get_ema_price(arg0: &PriceInfo) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.ema_price
    }

    public fun get_price(arg0: &PriceInfo) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.price
    }

    public fun get_price_info(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : PriceInfo {
        if (0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg1)) {
            return *0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg1)
        } else {
            let v0 = AlternatePriceIdentifier{dummy_field: false};
            if (0x2::dynamic_field::exists_<AlternatePriceIdentifier>(&arg0.id, v0)) {
                let v1 = AlternatePriceIdentifier{dummy_field: false};
                let v2 = 0x2::dynamic_field::borrow<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&arg0.id, v1);
                if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2, &arg1)) {
                    let v3 = *0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, *0x2::vec_map::get<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2, &arg1));
                    v3.coin_type = arg1;
                    return v3
                };
            };
            abort 2
        };
    }

    public fun get_pyth_identifiers_for_coin(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier> {
        let v0 = 0x2::dynamic_field::borrow<u64, OraclePyth>(&arg0.id, 0);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg1), 13906835853675593727);
        *0x2::vec_map::get<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg1)
    }

    public fun get_updated_time(arg0: &PriceInfo) : u64 {
        arg0.last_updated
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_oracle(arg1);
        0x2::transfer::public_share_object<Oracle>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun parse_price_to_number(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        if (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1)) {
            (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u8)))), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(arg0)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1) as u8)))))
        } else {
            (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u8)))), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(arg0)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x2::math::pow(10, (0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1) as u8)))))
        }
    }

    public fun remove_alternate_price_identifier(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName) {
        let v0 = AlternatePriceIdentifier{dummy_field: false};
        assert!(0x2::dynamic_field::exists_<AlternatePriceIdentifier>(&arg0.id, v0), 6);
        let v1 = AlternatePriceIdentifier{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&mut arg0.id, v1);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2, &arg2), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2, &arg2);
        if (0x2::vec_map::is_empty<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2)) {
            let v5 = AlternatePriceIdentifier{dummy_field: false};
            0x2::dynamic_field::remove<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&mut arg0.id, v5);
        };
    }

    public fun remove_coin_type(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName) {
        let v0 = 0x2::dynamic_field::borrow_mut<u64, OraclePyth>(&mut arg0.id, 0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg2)) {
            let (_, v2) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&mut v0.coin_to_identifier, &arg2);
            let v3 = v2;
            let (_, _) = 0x2::vec_map::remove<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut v0.identifier_map, 0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&v3, 0));
        };
        let v6 = 0x2::dynamic_field::borrow_mut<u64, OracleSupra>(&mut arg0.id, 1);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u64>>(&v6.coin_to_identifier, &arg2)) {
            let (_, v8) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<u64>>(&mut v6.coin_to_identifier, &arg2);
            let v9 = v8;
            let (_, _) = 0x2::vec_map::remove<u64, 0x1::type_name::TypeName>(&mut v6.identifier_map, 0x1::vector::borrow<u64>(&v9, 0));
        };
        let PriceInfo {
            coin_type                     : _,
            price                         : _,
            ema_price                     : _,
            conf                          : _,
            coin_kind                     : _,
            active                        : _,
            circuit_breaker_threshold_bps : _,
            last_updated                  : _,
        } = 0x2::table::remove<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2);
    }

    public fun update_circuit_breaker_threshold_bps(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: u16) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        assert!(arg3 <= 10000, 5);
        0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2).circuit_breaker_threshold_bps = arg3;
    }

    public fun update_max_age(arg0: &mut Oracle, arg1: &AdminCap, arg2: u64) {
        assert!(arg2 < 120, 7);
        arg0.max_age = arg2;
    }

    public fun update_price_from_pyth(arg0: &mut Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, arg0.max_age);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v1);
        0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::get_bytes(&v2);
        let (v3, v4) = parse_price_to_number(&v0);
        let v5 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v0);
        let v6 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v1));
        let (v7, v8) = parse_price_to_number(&v6);
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v4, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u8(10)), v3) || 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(v8, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u8(10)), v7)) {
            return
        };
        let v9 = 0x2::vec_map::get<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&0x2::dynamic_field::borrow<u64, OraclePyth>(&arg0.id, 0).identifier_map, &v2);
        let v10 = 0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, *v9);
        validate_price_update(v7, v3, v10.coin_kind, v10.circuit_breaker_threshold_bps);
        let v11 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, *v9);
        if (v11.last_updated > v5) {
            return
        };
        v11.ema_price = v7;
        v11.price = v3;
        let v12 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        v11.conf = v12;
        v11.last_updated = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v13 = PythPriceUpdationEvent{
            coin_type     : v11.coin_type,
            pyth_price_id : v2,
            price         : v3,
            ema_price     : v7,
            conf          : v12,
            last_updated  : v5,
        };
        0x2::event::emit<PythPriceUpdationEvent>(v13);
    }

    public fun update_pyth_identifier_for_coin(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, arg4: 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>) {
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, OraclePyth>(&mut arg0.id, 0);
        let v1 = 0x1::vector::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>();
        0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v1, arg3);
        if (0x1::option::is_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg4)) {
            let v2 = 0x1::option::extract<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg4);
            assert!(0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &v2), 3);
            0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v1, v2);
        };
        let v3 = 0x2::vec_map::get<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg2);
        let v4 = 0x1::vector::length<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(v3);
        while (v4 > 0) {
            v4 = v4 - 1;
            let v5 = *0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(v3, v4);
            if (0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &v5)) {
                if (0x2::vec_map::get<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &v5) == &arg2) {
                    let (_, _) = 0x2::vec_map::remove<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut v0.identifier_map, &v5);
                };
            };
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&mut v0.coin_to_identifier, &arg2);
        };
        if (0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &arg3)) {
            let (_, _) = 0x2::vec_map::remove<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut v0.identifier_map, &arg3);
        };
        0x2::vec_map::insert<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut v0.identifier_map, arg3, arg2);
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&mut v0.coin_to_identifier, arg2, v1);
    }

    fun validate_price_update(arg0: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg2: u8, arg3: u16) {
        let v0 = if (arg2 == 0) {
            if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::lt(arg1, arg0)) {
                0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0)
            } else {
                0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(arg1, arg0)
            }
        } else if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(arg0, arg1)) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(arg0, arg1)
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::sub(arg1, arg0)
        };
        if (0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from((arg3 as u64)), arg1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10000)))) {
            abort 4
        };
    }

    // decompiled from Move bytecode v6
}

