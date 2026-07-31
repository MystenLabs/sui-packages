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

    struct OracleLazer has store, key {
        id: 0x2::object::UID,
        coin_to_identifier: 0x2::vec_map::VecMap<0x1::type_name::TypeName, vector<u32>>,
        identifier_map: 0x2::vec_map::VecMap<u32, 0x1::type_name::TypeName>,
    }

    struct LazerPriceUpdationEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        feed_id: u32,
        price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        ema_price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        conf: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_updated: u64,
    }

    struct LazerPriceSkippedEvent has copy, drop {
        coin_type: 0x1::type_name::TypeName,
        feed_id: u32,
        reason: u8,
        price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        ema_price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
    }

    struct AlternatePriceIdentifier has copy, drop, store {
        dummy_field: bool,
    }

    struct FixedPrice has copy, drop, store {
        dummy_field: bool,
    }

    struct FixedPriceEntry has copy, drop, store {
        price: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number,
        last_updated: u64,
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
        verify_version(arg0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 1);
        let v0 = FixedPrice{dummy_field: false};
        if (0x2::dynamic_field::exists<FixedPrice>(&arg0.id, v0)) {
            let v1 = FixedPrice{dummy_field: false};
            assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, FixedPriceEntry>(0x2::dynamic_field::borrow<FixedPrice, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FixedPriceEntry>>(&arg0.id, v1), &arg2), 20);
        };
        let v2 = AlternatePriceIdentifier{dummy_field: false};
        let v3 = if (0x2::dynamic_field::exists<AlternatePriceIdentifier>(&arg0.id, v2)) {
            let v4 = AlternatePriceIdentifier{dummy_field: false};
            0x2::dynamic_field::borrow_mut<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&mut arg0.id, v4)
        } else {
            let v5 = AlternatePriceIdentifier{dummy_field: false};
            0x2::dynamic_field::add<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&mut arg0.id, v5, 0x2::vec_map::empty<0x1::type_name::TypeName, 0x1::type_name::TypeName>());
            let v6 = AlternatePriceIdentifier{dummy_field: false};
            0x2::dynamic_field::borrow_mut<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&mut arg0.id, v6)
        };
        0x2::vec_map::insert<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v3, arg2, arg3);
    }

    public fun add_coin_to_lazer(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: u32, arg4: 0x1::option::Option<u32>) {
        verify_version(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        assert!(0x1::option::is_none<u32>(&arg4), 14);
        assert!(0x2::dynamic_field::exists<u64>(&arg0.id, 2), 9);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, OracleLazer>(&mut arg0.id, 2);
        let v1 = vector[];
        0x1::vector::push_back<u32>(&mut v1, arg3);
        if (0x1::option::is_some<u32>(&arg4)) {
            let v2 = 0x1::option::extract<u32>(&mut arg4);
            assert!(0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &v2), 3);
            0x1::vector::push_back<u32>(&mut v1, v2);
        };
        assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, vector<u32>>(&v0.coin_to_identifier, &arg2), 1);
        assert!(!0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &arg3), 13906837176525520897);
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<u32>>(&mut v0.coin_to_identifier, arg2, v1);
        0x2::vec_map::insert<u32, 0x1::type_name::TypeName>(&mut v0.identifier_map, arg3, arg2);
    }

    public fun add_coin_to_oracle(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: u8, arg4: u16, arg5: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 1);
        assert!(arg4 <= 10000, 5);
        assert!(arg3 == 0 || arg3 == 1, 8);
        let v0 = AlternatePriceIdentifier{dummy_field: false};
        if (0x2::dynamic_field::exists<AlternatePriceIdentifier>(&arg0.id, v0)) {
            let v1 = AlternatePriceIdentifier{dummy_field: false};
            assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(0x2::dynamic_field::borrow<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&arg0.id, v1), &arg2), 13);
        };
        let v2 = FixedPrice{dummy_field: false};
        if (0x2::dynamic_field::exists<FixedPrice>(&arg0.id, v2)) {
            let v3 = FixedPrice{dummy_field: false};
            assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, FixedPriceEntry>(0x2::dynamic_field::borrow<FixedPrice, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FixedPriceEntry>>(&arg0.id, v3), &arg2), 20);
        };
        let v4 = PriceInfo{
            coin_type                     : arg2,
            price                         : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            ema_price                     : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            conf                          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
            coin_kind                     : arg3,
            active                        : true,
            circuit_breaker_threshold_bps : arg4,
            last_updated                  : 0,
        };
        0x2::table::add<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2, v4);
    }

    public fun add_coin_to_supra(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: u64, arg4: 0x1::option::Option<u64>) {
        verify_version(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        let v0 = 0x2::dynamic_field::borrow_mut<u8, OracleSupra>(&mut arg0.id, 1);
        let v1 = vector[];
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

    fun conf_band_ok(arg0: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) : bool {
        !0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(arg0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(100)), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from_u8(10)), arg1)
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
        let v3 = OracleLazer{
            id                 : 0x2::object::new(arg0),
            coin_to_identifier : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u32>>(),
            identifier_map     : 0x2::vec_map::empty<u32, 0x1::type_name::TypeName>(),
        };
        0x2::dynamic_field::add<u64, OraclePyth>(&mut v0.id, 0, v1);
        0x2::dynamic_field::add<u8, OracleSupra>(&mut v0.id, 1, v2);
        0x2::dynamic_field::add<u64, OracleLazer>(&mut v0.id, 2, v3);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v0.id, b"version", 1);
        0x2::dynamic_field::add<vector<u8>, u64>(&mut v0.id, b"read_version", 1);
        let v4 = AdminCap{id: 0x2::object::new(arg0)};
        (v0, v4)
    }

    public fun enable_lazer(arg0: &mut Oracle, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_version(arg0);
        assert!(!0x2::dynamic_field::exists<u64>(&arg0.id, 2), 10);
        let v0 = OracleLazer{
            id                 : 0x2::object::new(arg2),
            coin_to_identifier : 0x2::vec_map::empty<0x1::type_name::TypeName, vector<u32>>(),
            identifier_map     : 0x2::vec_map::empty<u32, 0x1::type_name::TypeName>(),
        };
        0x2::dynamic_field::add<u64, OracleLazer>(&mut arg0.id, 2, v0);
    }

    fun feed_ts_fresh(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg0 > arg1 && arg0 - arg1 <= 3 || arg1 - arg0 <= arg2
    }

    public fun get_all_supported_price_lazer_identifiers(arg0: &Oracle) : vector<u32> {
        assert!(0x2::dynamic_field::exists<u64>(&arg0.id, 2), 9);
        0x2::vec_map::keys<u32, 0x1::type_name::TypeName>(&0x2::dynamic_field::borrow<u64, OracleLazer>(&arg0.id, 2).identifier_map)
    }

    public fun get_all_supported_price_pyth_identifiers(arg0: &Oracle) : vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier> {
        0x2::vec_map::keys<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&0x2::dynamic_field::borrow<u64, OraclePyth>(&arg0.id, 0).identifier_map)
    }

    public fun get_coin_type_for_lazer_feed_id(arg0: &Oracle, arg1: u32) : 0x1::type_name::TypeName {
        assert!(0x2::dynamic_field::exists<u64>(&arg0.id, 2), 9);
        let v0 = 0x2::dynamic_field::borrow<u64, OracleLazer>(&arg0.id, 2);
        assert!(0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &arg1), 11);
        *0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &arg1)
    }

    public fun get_conf(arg0: &PriceInfo) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.conf
    }

    public fun get_ema_price(arg0: &PriceInfo) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.ema_price
    }

    public fun get_lazer_feed_ids_for_coin(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : vector<u32> {
        assert!(0x2::dynamic_field::exists<u64>(&arg0.id, 2), 9);
        let v0 = 0x2::dynamic_field::borrow<u64, OracleLazer>(&arg0.id, 2);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, vector<u32>>(&v0.coin_to_identifier, &arg1), 2);
        *0x2::vec_map::get<0x1::type_name::TypeName, vector<u32>>(&v0.coin_to_identifier, &arg1)
    }

    public fun get_price(arg0: &PriceInfo) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        arg0.price
    }

    public fun get_price_info(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : PriceInfo {
        verify_version_read(arg0);
        if (0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg1)) {
            return *0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg1)
        } else {
            let v0 = AlternatePriceIdentifier{dummy_field: false};
            if (0x2::dynamic_field::exists<AlternatePriceIdentifier>(&arg0.id, v0)) {
                let v1 = AlternatePriceIdentifier{dummy_field: false};
                let v2 = 0x2::dynamic_field::borrow<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&arg0.id, v1);
                if (0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2, &arg1)) {
                    let v3 = *0x2::vec_map::get<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2, &arg1);
                    assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, v3), 2);
                    let v4 = *0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, v3);
                    v4.coin_type = arg1;
                    return v4
                };
            };
            let v5 = FixedPrice{dummy_field: false};
            if (0x2::dynamic_field::exists<FixedPrice>(&arg0.id, v5)) {
                let v6 = FixedPrice{dummy_field: false};
                let v7 = 0x2::dynamic_field::borrow<FixedPrice, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FixedPriceEntry>>(&arg0.id, v6);
                if (0x2::vec_map::contains<0x1::type_name::TypeName, FixedPriceEntry>(v7, &arg1)) {
                    let v8 = *0x2::vec_map::get<0x1::type_name::TypeName, FixedPriceEntry>(v7, &arg1);
                    let v9 = if (0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"last_lazer_ingest_time")) {
                        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"last_lazer_ingest_time")
                    } else {
                        0
                    };
                    let v10 = if (v9 > v8.last_updated) {
                        v9
                    } else {
                        v8.last_updated
                    };
                    return PriceInfo{
                        coin_type                     : arg1,
                        price                         : v8.price,
                        ema_price                     : v8.price,
                        conf                          : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                        coin_kind                     : 0,
                        active                        : true,
                        circuit_breaker_threshold_bps : 0,
                        last_updated                  : v10,
                    }
                };
            };
            abort 2
        };
    }

    public fun get_pyth_identifiers_for_coin(arg0: &Oracle, arg1: 0x1::type_name::TypeName) : vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier> {
        let v0 = 0x2::dynamic_field::borrow<u64, OraclePyth>(&arg0.id, 0);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg1), 13906838228792508415);
        *0x2::vec_map::get<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg1)
    }

    public fun get_read_version(arg0: &Oracle) : u64 {
        if (!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"read_version")) {
            return 0
        };
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"read_version")
    }

    public fun get_updated_time(arg0: &PriceInfo) : u64 {
        arg0.last_updated
    }

    public fun get_version(arg0: &Oracle) : u64 {
        if (!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"version")) {
            return 0
        };
        *0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"version")
    }

    public fun ingest_lazer_update(arg0: &mut Oracle, arg1: 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::Update, arg2: &0x2::clock::Clock) {
        verify_version(arg0);
        assert!(0x2::dynamic_field::exists<u64>(&arg0.id, 2), 9);
        let v0 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::update_v2::feeds(&arg1);
        let v1 = 0;
        while (v1 < 0x1::vector::length<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v0)) {
            let v2 = *0x1::vector::borrow<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::Feed>(&v0, v1);
            v1 = v1 + 1;
            let v3 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_id(&v2);
            let v4 = 0x2::dynamic_field::borrow<u64, OracleLazer>(&arg0.id, 2);
            let v5 = if (0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v4.identifier_map, &v3)) {
                0x1::option::some<0x1::type_name::TypeName>(*0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&v4.identifier_map, &v3))
            } else {
                0x1::option::none<0x1::type_name::TypeName>()
            };
            let v6 = v5;
            if (0x1::option::is_none<0x1::type_name::TypeName>(&v6)) {
                0x1::option::destroy_none<0x1::type_name::TypeName>(v6);
                continue
            };
            let v7 = 0x1::option::destroy_some<0x1::type_name::TypeName>(v6);
            if (!0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, v7).active) {
                let v8 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 14,
                    price     : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                    ema_price : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v8);
                continue
            };
            let (v9, v10) = lazer_opt_positive_magnitude(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::price(&v2));
            if (!v9) {
                let v11 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 0,
                    price     : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                    ema_price : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v11);
                continue
            };
            if (v10 == 0) {
                let v12 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 1,
                    price     : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                    ema_price : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v12);
                continue
            };
            let v13 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::exponent(&v2);
            if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(&v13)) {
                0x1::option::destroy_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v13);
                let v14 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 2,
                    price     : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                    ema_price : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v14);
                continue
            };
            let v15 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::I16>(v13);
            let v16 = 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_is_negative(&v15);
            let v17 = if (v16) {
                (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_negative(&v15) as u64)
            } else {
                (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i16::get_magnitude_if_positive(&v15) as u64)
            };
            if (v17 > 19) {
                let v18 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 3,
                    price     : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                    ema_price : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v18);
                continue
            };
            let v19 = scaled_number(v10, v16, v17);
            let (v20, v21) = lazer_opt_positive_magnitude(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::ema_price(&v2));
            if (!v20) {
                let v22 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 4,
                    price     : v19,
                    ema_price : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0),
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v22);
                continue
            };
            let v23 = scaled_number(v21, v16, v17);
            let (v24, v25) = lazer_opt_positive_magnitude(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::confidence(&v2));
            if (!v24) {
                let v26 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 5,
                    price     : v19,
                    ema_price : v23,
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v26);
                continue
            };
            let v27 = scaled_number(v25, v16, v17);
            if (!conf_band_ok(v27, v19)) {
                let v28 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 6,
                    price     : v19,
                    ema_price : v23,
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v28);
                continue
            };
            let (v29, v30) = lazer_opt_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::ema_confidence(&v2));
            if (!v29) {
                let v31 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 7,
                    price     : v19,
                    ema_price : v23,
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v31);
                continue
            };
            if (!conf_band_ok(scaled_number(v30, v16, v17), v23)) {
                let v32 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 8,
                    price     : v19,
                    ema_price : v23,
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v32);
                continue
            };
            let (v33, v34) = lazer_opt_u64(0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::feed::feed_update_timestamp(&v2));
            if (!v33) {
                let v35 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 13,
                    price     : v19,
                    ema_price : v23,
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v35);
                continue
            };
            let v36 = v34 / 1000000;
            let v37 = 0x2::clock::timestamp_ms(arg2) / 1000;
            if (!feed_ts_fresh(v36, v37, arg0.max_age)) {
                let v38 = if (v36 > v37) {
                    12
                } else {
                    9
                };
                let v39 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : v38,
                    price     : v19,
                    ema_price : v23,
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v39);
                continue
            };
            let v40 = 0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, v7);
            if (!price_breaker_ok(v23, v19, v40.coin_kind, v40.circuit_breaker_threshold_bps)) {
                let v41 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 10,
                    price     : v19,
                    ema_price : v23,
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v41);
                continue
            };
            let v42 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, v7);
            if (v42.last_updated > v36) {
                let v43 = LazerPriceSkippedEvent{
                    coin_type : v7,
                    feed_id   : v3,
                    reason    : 11,
                    price     : v19,
                    ema_price : v23,
                };
                0x2::event::emit<LazerPriceSkippedEvent>(v43);
                continue
            };
            v42.price = v19;
            v42.ema_price = v23;
            v42.conf = v27;
            let v44 = if (v36 < v37) {
                v36
            } else {
                v37
            };
            v42.last_updated = v44;
            let v45 = LazerPriceUpdationEvent{
                coin_type    : v7,
                feed_id      : v3,
                price        : v19,
                ema_price    : v23,
                conf         : v27,
                last_updated : v42.last_updated,
            };
            0x2::event::emit<LazerPriceUpdationEvent>(v45);
        };
        if (0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"last_lazer_ingest_time")) {
            *0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"last_lazer_ingest_time") = 0x2::clock::timestamp_ms(arg2) / 1000;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"last_lazer_ingest_time", 0x2::clock::timestamp_ms(arg2) / 1000);
        };
    }

    fun init(arg0: ORACLE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = create_oracle(arg1);
        0x2::transfer::public_share_object<Oracle>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg1));
    }

    fun is_fixed_price_allowed(arg0: 0x1::ascii::String) : bool {
        arg0 == 0x1::ascii::string(b"1a8f4bc33f8ef7fbc851f156857aa65d397a6a6fd27a7ac2ca717b51f2fd9489::alkimi::ALKIMI") || arg0 == 0x1::ascii::string(b"87dfe1248a1dc4ce473bd9cb2937d66cdc6c30fee63f3fe0dbb55c7a09d35dec::up::UP")
    }

    public fun is_lazer_enabled(arg0: &Oracle) : bool {
        0x2::dynamic_field::exists<u64>(&arg0.id, 2)
    }

    fun lazer_opt_positive_magnitude(arg0: 0x1::option::Option<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>) : (bool, u64) {
        if (0x1::option::is_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(&arg0)) {
            0x1::option::destroy_none<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
            return (false, 0)
        };
        let v0 = 0x1::option::destroy_some<0x1::option::Option<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>>(arg0);
        if (0x1::option::is_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(&v0)) {
            0x1::option::destroy_none<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0);
            return (false, 0)
        };
        let v1 = 0x1::option::destroy_some<0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::I64>(v0);
        if (0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_is_negative(&v1)) {
            return (false, 0)
        };
        (true, 0x7b502c8a7bcb3915892347f11086745570e759fe9708d03c03accf4c90bbf580::i64::get_magnitude_if_positive(&v1))
    }

    fun lazer_opt_u64(arg0: 0x1::option::Option<0x1::option::Option<u64>>) : (bool, u64) {
        if (0x1::option::is_none<0x1::option::Option<u64>>(&arg0)) {
            0x1::option::destroy_none<0x1::option::Option<u64>>(arg0);
            return (false, 0)
        };
        let v0 = 0x1::option::destroy_some<0x1::option::Option<u64>>(arg0);
        if (0x1::option::is_none<u64>(&v0)) {
            0x1::option::destroy_none<u64>(v0);
            return (false, 0)
        };
        (true, 0x1::option::destroy_some<u64>(v0))
    }

    fun parse_price_to_number(arg0: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::Price) : (bool, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_price(arg0);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_expo(arg0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_is_negative(&v1);
        let v3 = if (v2) {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_negative(&v1)
        } else {
            0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v1)
        };
        if (v3 > 19) {
            return (false, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0))
        };
        (true, scaled_number(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::i64::get_magnitude_if_positive(&v0), v2, v3), scaled_number(0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_conf(arg0), v2, v3))
    }

    fun price_breaker_ok(arg0: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg2: u8, arg3: u16) : bool {
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
        !0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::gt(v0, 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from((arg3 as u64)), arg1), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(10000)))
    }

    public fun remove_alternate_price_identifier(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName) {
        verify_version(arg0);
        let v0 = AlternatePriceIdentifier{dummy_field: false};
        assert!(0x2::dynamic_field::exists<AlternatePriceIdentifier>(&arg0.id, v0), 6);
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
        verify_version(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        let v0 = AlternatePriceIdentifier{dummy_field: false};
        if (0x2::dynamic_field::exists<AlternatePriceIdentifier>(&arg0.id, v0)) {
            let v1 = AlternatePriceIdentifier{dummy_field: false};
            let v2 = 0x2::dynamic_field::borrow<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&arg0.id, v1);
            let v3 = 0;
            while (v3 < 0x2::vec_map::length<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2)) {
                let (v4, v5) = 0x2::vec_map::get_entry_by_idx<0x1::type_name::TypeName, 0x1::type_name::TypeName>(v2, v3);
                assert!(v4 != &arg2 && v5 != &arg2, 13);
                v3 = v3 + 1;
            };
        };
        let v6 = 0x2::dynamic_field::borrow_mut<u64, OraclePyth>(&mut arg0.id, 0);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v6.coin_to_identifier, &arg2)) {
            let (_, v8) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&mut v6.coin_to_identifier, &arg2);
            let v9 = v8;
            if (0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v6.identifier_map, 0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&v9, 0)) && 0x2::vec_map::get<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v6.identifier_map, 0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&v9, 0)) == &arg2) {
                let (_, _) = 0x2::vec_map::remove<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut v6.identifier_map, 0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&v9, 0));
            };
        };
        let v12 = 0x2::dynamic_field::borrow_mut<u8, OracleSupra>(&mut arg0.id, 1);
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u64>>(&v12.coin_to_identifier, &arg2)) {
            let (_, v14) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<u64>>(&mut v12.coin_to_identifier, &arg2);
            let v15 = v14;
            if (0x2::vec_map::contains<u64, 0x1::type_name::TypeName>(&v12.identifier_map, 0x1::vector::borrow<u64>(&v15, 0)) && 0x2::vec_map::get<u64, 0x1::type_name::TypeName>(&v12.identifier_map, 0x1::vector::borrow<u64>(&v15, 0)) == &arg2) {
                let (_, _) = 0x2::vec_map::remove<u64, 0x1::type_name::TypeName>(&mut v12.identifier_map, 0x1::vector::borrow<u64>(&v15, 0));
            };
        };
        if (0x2::dynamic_field::exists<u64>(&arg0.id, 2)) {
            let v18 = 0x2::dynamic_field::borrow_mut<u64, OracleLazer>(&mut arg0.id, 2);
            if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u32>>(&v18.coin_to_identifier, &arg2)) {
                let (_, v20) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<u32>>(&mut v18.coin_to_identifier, &arg2);
                let v21 = v20;
                let v22 = 0;
                while (v22 < 0x1::vector::length<u32>(&v21)) {
                    let v23 = *0x1::vector::borrow<u32>(&v21, v22);
                    if (0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v18.identifier_map, &v23) && 0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&v18.identifier_map, &v23) == &arg2) {
                        let (_, _) = 0x2::vec_map::remove<u32, 0x1::type_name::TypeName>(&mut v18.identifier_map, &v23);
                    };
                    v22 = v22 + 1;
                };
            };
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

    public fun remove_fixed_price(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName) {
        verify_version(arg0);
        let v0 = FixedPrice{dummy_field: false};
        assert!(0x2::dynamic_field::exists<FixedPrice>(&arg0.id, v0), 19);
        let v1 = FixedPrice{dummy_field: false};
        let v2 = 0x2::dynamic_field::borrow_mut<FixedPrice, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FixedPriceEntry>>(&mut arg0.id, v1);
        assert!(0x2::vec_map::contains<0x1::type_name::TypeName, FixedPriceEntry>(v2, &arg2), 2);
        let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, FixedPriceEntry>(v2, &arg2);
        if (0x2::vec_map::is_empty<0x1::type_name::TypeName, FixedPriceEntry>(v2)) {
            let v5 = FixedPrice{dummy_field: false};
            0x2::dynamic_field::remove<FixedPrice, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FixedPriceEntry>>(&mut arg0.id, v5);
        };
    }

    fun scaled_number(arg0: u64, arg1: bool, arg2: u64) : 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number {
        assert!(arg2 <= 19, 12);
        if (arg1) {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::div(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x1::u64::pow(10, (arg2 as u8))))
        } else {
            0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::mul(0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(arg0), 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0x1::u64::pow(10, (arg2 as u8))))
        }
    }

    public fun set_coin_active(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: bool) {
        verify_version(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2).active = arg3;
    }

    public fun set_fixed_price(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg4: &0x2::clock::Clock) {
        assert!(is_fixed_price_allowed(*0x1::type_name::as_string(&arg2)), 21);
        set_fixed_price_internal(arg0, arg1, arg2, arg3, arg4);
    }

    fun set_fixed_price_internal(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg4: &0x2::clock::Clock) {
        verify_version(arg0);
        assert!(!0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 1);
        let v0 = AlternatePriceIdentifier{dummy_field: false};
        if (0x2::dynamic_field::exists<AlternatePriceIdentifier>(&arg0.id, v0)) {
            let v1 = AlternatePriceIdentifier{dummy_field: false};
            assert!(!0x2::vec_map::contains<0x1::type_name::TypeName, 0x1::type_name::TypeName>(0x2::dynamic_field::borrow<AlternatePriceIdentifier, 0x2::vec_map::VecMap<0x1::type_name::TypeName, 0x1::type_name::TypeName>>(&arg0.id, v1), &arg2), 13);
        };
        let v2 = FixedPriceEntry{
            price        : arg3,
            last_updated : 0x2::clock::timestamp_ms(arg4) / 1000,
        };
        let v3 = FixedPrice{dummy_field: false};
        let v4 = if (0x2::dynamic_field::exists<FixedPrice>(&arg0.id, v3)) {
            let v5 = FixedPrice{dummy_field: false};
            0x2::dynamic_field::borrow_mut<FixedPrice, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FixedPriceEntry>>(&mut arg0.id, v5)
        } else {
            let v6 = FixedPrice{dummy_field: false};
            0x2::dynamic_field::add<FixedPrice, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FixedPriceEntry>>(&mut arg0.id, v6, 0x2::vec_map::empty<0x1::type_name::TypeName, FixedPriceEntry>());
            let v7 = FixedPrice{dummy_field: false};
            0x2::dynamic_field::borrow_mut<FixedPrice, 0x2::vec_map::VecMap<0x1::type_name::TypeName, FixedPriceEntry>>(&mut arg0.id, v7)
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, FixedPriceEntry>(v4, &arg2)) {
            *0x2::vec_map::get_mut<0x1::type_name::TypeName, FixedPriceEntry>(v4, &arg2) = v2;
        } else {
            0x2::vec_map::insert<0x1::type_name::TypeName, FixedPriceEntry>(v4, arg2, v2);
        };
    }

    public fun update_circuit_breaker_threshold_bps(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: u16) {
        verify_version(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        assert!(arg3 <= 10000, 5);
        0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, arg2).circuit_breaker_threshold_bps = arg3;
    }

    public fun update_lazer_identifier_for_coin(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: u32, arg4: 0x1::option::Option<u32>) {
        verify_version(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        assert!(0x1::option::is_none<u32>(&arg4), 14);
        assert!(0x2::dynamic_field::exists<u64>(&arg0.id, 2), 9);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, OracleLazer>(&mut arg0.id, 2);
        if (0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &arg3)) {
            assert!(0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &arg3) == &arg2, 15);
        };
        let v1 = vector[];
        0x1::vector::push_back<u32>(&mut v1, arg3);
        let v2 = if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u32>>(&v0.coin_to_identifier, &arg2)) {
            *0x2::vec_map::get<0x1::type_name::TypeName, vector<u32>>(&v0.coin_to_identifier, &arg2)
        } else {
            vector[]
        };
        let v3 = v2;
        let v4 = 0x1::vector::length<u32>(&v3);
        while (v4 > 0) {
            v4 = v4 - 1;
            let v5 = *0x1::vector::borrow<u32>(&v3, v4);
            if (0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &v5) && 0x2::vec_map::get<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &v5) == &arg2) {
                let (_, _) = 0x2::vec_map::remove<u32, 0x1::type_name::TypeName>(&mut v0.identifier_map, &v5);
            };
        };
        if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<u32>>(&v0.coin_to_identifier, &arg2)) {
            let (_, _) = 0x2::vec_map::remove<0x1::type_name::TypeName, vector<u32>>(&mut v0.coin_to_identifier, &arg2);
        };
        if (0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &arg3)) {
            let (_, _) = 0x2::vec_map::remove<u32, 0x1::type_name::TypeName>(&mut v0.identifier_map, &arg3);
        };
        if (0x1::option::is_some<u32>(&arg4)) {
            let v12 = 0x1::option::extract<u32>(&mut arg4);
            assert!(0x2::vec_map::contains<u32, 0x1::type_name::TypeName>(&v0.identifier_map, &v12), 3);
            0x1::vector::push_back<u32>(&mut v1, v12);
        };
        0x2::vec_map::insert<u32, 0x1::type_name::TypeName>(&mut v0.identifier_map, arg3, arg2);
        0x2::vec_map::insert<0x1::type_name::TypeName, vector<u32>>(&mut v0.coin_to_identifier, arg2, v1);
    }

    public fun update_max_age(arg0: &mut Oracle, arg1: &AdminCap, arg2: u64) {
        verify_version(arg0);
        assert!(arg2 < 120, 7);
        arg0.max_age = arg2;
    }

    public fun update_price_from_pyth(arg0: &mut Oracle, arg1: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg2: &0x2::clock::Clock) {
        let v0 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_info_from_price_info_object(arg1);
        let v1 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_identifier(&v0);
        let v2 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::get_price_feed(&v0);
        let v3 = *0x2::vec_map::get<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&0x2::dynamic_field::borrow<u64, OraclePyth>(&arg0.id, 0).identifier_map, &v1);
        if (!0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, v3).active) {
            return
        };
        let v4 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::pyth::get_price_no_older_than(arg1, arg2, arg0.max_age);
        let (v5, v6, v7) = parse_price_to_number(&v4);
        if (!v5) {
            return
        };
        let v8 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price::get_timestamp(&v4);
        let v9 = 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_feed::get_ema_price(v2);
        let (v10, v11, v12) = parse_price_to_number(&v9);
        if (!v10) {
            return
        };
        if (!conf_band_ok(v7, v6) || !conf_band_ok(v12, v11)) {
            return
        };
        let v13 = 0x2::table::borrow<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, v3);
        validate_price_update(v11, v6, v13.coin_kind, v13.circuit_breaker_threshold_bps);
        let v14 = 0x2::table::borrow_mut<0x1::type_name::TypeName, PriceInfo>(&mut arg0.price_infos, v3);
        if (v14.last_updated > v8) {
            return
        };
        v14.ema_price = v11;
        v14.price = v6;
        let v15 = 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::from(0);
        v14.conf = v15;
        let v16 = 0x2::clock::timestamp_ms(arg2) / 1000;
        let v17 = if (v8 < v16) {
            v8
        } else {
            v16
        };
        v14.last_updated = v17;
        let v18 = PythPriceUpdationEvent{
            coin_type     : v14.coin_type,
            pyth_price_id : v1,
            price         : v6,
            ema_price     : v11,
            conf          : v15,
            last_updated  : v14.last_updated,
        };
        0x2::event::emit<PythPriceUpdationEvent>(v18);
    }

    public fun update_pyth_identifier_for_coin(arg0: &mut Oracle, arg1: &AdminCap, arg2: 0x1::type_name::TypeName, arg3: 0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, arg4: 0x1::option::Option<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>) {
        verify_version(arg0);
        assert!(0x2::table::contains<0x1::type_name::TypeName, PriceInfo>(&arg0.price_infos, arg2), 2);
        let v0 = 0x2::dynamic_field::borrow_mut<u64, OraclePyth>(&mut arg0.id, 0);
        if (0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &arg3)) {
            assert!(0x2::vec_map::get<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &arg3) == &arg2, 16);
        };
        let v1 = 0x1::vector::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>();
        0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v1, arg3);
        if (0x1::option::is_some<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&arg4)) {
            let v2 = 0x1::option::extract<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut arg4);
            assert!(0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &v2), 3);
            0x1::vector::push_back<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(&mut v1, v2);
        };
        let v3 = if (0x2::vec_map::contains<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg2)) {
            0x2::vec_map::get<0x1::type_name::TypeName, vector<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>>(&v0.coin_to_identifier, &arg2)
        } else {
            let v4 = 0x1::vector::empty<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>();
            &v4
        };
        let v5 = 0x1::vector::length<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(v3);
        while (v5 > 0) {
            v5 = v5 - 1;
            let v6 = *0x1::vector::borrow<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier>(v3, v5);
            if (0x2::vec_map::contains<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &v6)) {
                if (0x2::vec_map::get<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&v0.identifier_map, &v6) == &arg2) {
                    let (_, _) = 0x2::vec_map::remove<0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_identifier::PriceIdentifier, 0x1::type_name::TypeName>(&mut v0.identifier_map, &v6);
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

    public fun update_read_version(arg0: &mut Oracle, arg1: &AdminCap) {
        if (0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"read_version")) {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"read_version");
            assert!(*v0 < 1, 23);
            *v0 = 1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"read_version", 1);
        };
    }

    public fun update_version(arg0: &mut Oracle, arg1: &AdminCap) {
        if (!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"read_version")) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"read_version", 1);
        };
        if (0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"version")) {
            let v0 = 0x2::dynamic_field::borrow_mut<vector<u8>, u64>(&mut arg0.id, b"version");
            assert!(*v0 < 1, 18);
            *v0 = 1;
        } else {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"version", 1);
        };
    }

    fun validate_price_update(arg0: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg1: 0x4b591bbc246c9fadd28e7ac895e0778fb0e102f1b0d9f441e78d35f0d1ea1fcc::math::Number, arg2: u8, arg3: u16) {
        assert!(price_breaker_ok(arg0, arg1, arg2, arg3), 4);
    }

    fun verify_version(arg0: &mut Oracle) {
        if (!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"version")) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"version", 1);
        };
        if (!0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"read_version")) {
            0x2::dynamic_field::add<vector<u8>, u64>(&mut arg0.id, b"read_version", 1);
        };
        assert!(*0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"version") == 1, 17);
    }

    fun verify_version_read(arg0: &Oracle) {
        assert!(0x2::dynamic_field::exists<vector<u8>>(&arg0.id, b"read_version"), 22);
        assert!(*0x2::dynamic_field::borrow<vector<u8>, u64>(&arg0.id, b"read_version") <= 1, 22);
    }

    // decompiled from Move bytecode v7
}

