module 0x9feccd1fc528f59f817928b6fc2520af1f3c6a917e869506c4b5788cd79e6b2c::oracle_voucher {
    struct PriceOracleConfig has store, key {
        id: 0x2::object::UID,
        price_fluctuation_threshold: 0x2::table::Table<0x1::type_name::TypeName, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>,
        price_ticket_block: 0x2::bag::Bag,
        twap_oracles: 0x2::table::Table<0x1::type_name::TypeName, TwapOracle>,
        twap_window_size: u64,
    }

    struct PriceTicket<phantom T0: drop> has store, key {
        id: 0x2::object::UID,
    }

    struct PriceVoucher<phantom T0: drop> {
        underlying_price: u128,
    }

    struct TwapOracle has store {
        observations: vector<Observation>,
        observation_index: u64,
        observation_cardinality: u64,
    }

    struct Observation has drop, store {
        block_timestamp: u32,
        price_cumulative: u256,
        initialized: bool,
    }

    fun binary_search_observations(arg0: &vector<Observation>, arg1: u32, arg2: u64, arg3: u64) : (Observation, Observation) {
        let v0 = (arg2 + 1) % arg3;
        let v1 = v0 + arg3 - 1;
        let v2 = 0;
        while (v0 <= v1) {
            let v3 = (v0 + v1) / 2;
            v2 = v3;
            let v4 = 0x1::vector::borrow<Observation>(arg0, v3 % arg3);
            if (!v4.initialized) {
                v0 = v3 + 1;
                continue
            };
            let v5 = 0x1::vector::borrow<Observation>(arg0, (v3 + 1) % arg3);
            let v6 = v4.block_timestamp <= arg1;
            if (v6 && arg1 <= v5.block_timestamp) {
                let v7 = Observation{
                    block_timestamp  : v4.block_timestamp,
                    price_cumulative : v4.price_cumulative,
                    initialized      : v4.initialized,
                };
                let v8 = Observation{
                    block_timestamp  : v5.block_timestamp,
                    price_cumulative : v5.price_cumulative,
                    initialized      : v5.initialized,
                };
                return (v7, v8)
            };
            if (!v6) {
                v1 = v3 - 1;
                continue
            };
            v0 = v3 + 1;
        };
        let v9 = 0x1::vector::borrow<Observation>(arg0, v2 % arg3);
        let v10 = 0x1::vector::borrow<Observation>(arg0, (v2 + 1) % arg3);
        let v11 = Observation{
            block_timestamp  : v10.block_timestamp,
            price_cumulative : v10.price_cumulative,
            initialized      : v10.initialized,
        };
        let v12 = Observation{
            block_timestamp  : v9.block_timestamp,
            price_cumulative : v9.price_cumulative,
            initialized      : v9.initialized,
        };
        (v11, v12)
    }

    public fun block_price_ticket(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut PriceOracleConfig, arg3: address, arg4: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        0x2::bag::add<address, bool>(&mut arg2.price_ticket_block, arg3, true);
    }

    public(friend) fun calculate_twap<T0: drop>(arg0: &PriceOracleConfig, arg1: u256, arg2: &0x2::clock::Clock, arg3: u64) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        assert!(0x2::table::contains<0x1::type_name::TypeName, TwapOracle>(&arg0.twap_oracles, v0), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::invalid_argument(772));
        let v1 = 0x2::table::borrow<0x1::type_name::TypeName, TwapOracle>(&arg0.twap_oracles, v0);
        let v2 = ((0x2::clock::timestamp_ms(arg2) / 1000) as u32);
        let v3 = ((arg3 / 1000) as u32);
        let (v4, v5) = observe_single(&v1.observations, v2, v3, arg1, v1.observation_index, v1.observation_cardinality);
        let (v6, v7) = observe_single(&v1.observations, v2, 0, arg1, v1.observation_index, v1.observation_cardinality);
        if (v3 == 0) {
            abort 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::invalid_argument(775)
        };
        let v8 = v7 - v5;
        assert!(v8 != 0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::invalid_argument(776));
        0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value((((v6 - v4) / (v8 as u256)) as u128))
    }

    public fun generate_price_ticket<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut 0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg2), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        let v0 = PriceTicket<T0>{id: 0x2::object::new(arg2)};
        0x2::transfer::transfer<PriceTicket<T0>>(v0, 0x2::tx_context::sender(arg2));
    }

    public fun generate_price_voucher<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &mut PriceOracleConfig, arg2: &PriceTicket<T0>, arg3: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg4: &0x2::clock::Clock) : PriceVoucher<T0> {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(!0x2::bag::contains<address>(&arg1.price_ticket_block, 0x2::object::id_address<PriceTicket<T0>>(arg2)), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        update_twap_oracle<T0>(arg1, arg3, arg4);
        let (v0, v1) = is_price_fluctuation_within_twap_threshold<T0>(arg1, arg3, arg4);
        assert!(v0, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::price_fluctuation_too_large());
        if (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v1) != 0) {
            PriceVoucher<T0>{underlying_price: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(v1)}
        } else {
            PriceVoucher<T0>{underlying_price: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(arg3)}
        }
    }

    public fun get_price<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: PriceVoucher<T0>, arg2: &mut 0x2::tx_context::TxContext) : u128 {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        let PriceVoucher { underlying_price: v0 } = arg1;
        v0
    }

    public(friend) fun get_price_fluctuation_threshold<T0: drop>(arg0: &PriceOracleConfig) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&arg0.price_fluctuation_threshold, v0)) {
            0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::value(0x2::table::borrow<0x1::type_name::TypeName, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&arg0.price_fluctuation_threshold, v0)))
        } else {
            0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_rational(1, 100)
        }
    }

    fun get_surrounding_observations(arg0: &vector<Observation>, arg1: u32, arg2: u256, arg3: u64, arg4: u64) : (Observation, Observation) {
        let v0 = 0x1::vector::borrow<Observation>(arg0, arg3);
        if (v0.block_timestamp <= arg1) {
            if (v0.block_timestamp == arg1) {
                let v1 = Observation{
                    block_timestamp  : v0.block_timestamp,
                    price_cumulative : v0.price_cumulative,
                    initialized      : v0.initialized,
                };
                let v2 = Observation{
                    block_timestamp  : 0,
                    price_cumulative : 0,
                    initialized      : false,
                };
                return (v1, v2)
            };
            let v3 = Observation{
                block_timestamp  : v0.block_timestamp,
                price_cumulative : v0.price_cumulative,
                initialized      : v0.initialized,
            };
            return (v3, transform_observation(v0, arg1, arg2))
        };
        let v4 = 0x1::vector::borrow<Observation>(arg0, (arg3 + 1) % arg4);
        let v5 = v4;
        if (!v4.initialized) {
            v5 = 0x1::vector::borrow<Observation>(arg0, 0);
        };
        assert!(v5.block_timestamp <= arg1, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::invalid_argument(773));
        binary_search_observations(arg0, arg1, arg3, arg4)
    }

    public fun get_twap_price<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &PriceOracleConfig, arg2: u256, arg3: &0x2::clock::Clock, arg4: u64) : 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64 {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        calculate_twap<T0>(arg1, arg2, arg3, arg4)
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = PriceOracleConfig{
            id                          : 0x2::object::new(arg0),
            price_fluctuation_threshold : 0x2::table::new<0x1::type_name::TypeName, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(arg0),
            price_ticket_block          : 0x2::bag::new(arg0),
            twap_oracles                : 0x2::table::new<0x1::type_name::TypeName, TwapOracle>(arg0),
            twap_window_size            : 300000,
        };
        0x2::transfer::share_object<PriceOracleConfig>(v0);
    }

    public fun init_twap_oracle<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut PriceOracleConfig, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (!0x2::table::contains<0x1::type_name::TypeName, TwapOracle>(&arg2.twap_oracles, v0)) {
            let v1 = TwapOracle{
                observations            : 0x1::vector::empty<Observation>(),
                observation_index       : 0,
                observation_cardinality : 1,
            };
            let v2 = Observation{
                block_timestamp  : ((0x2::clock::timestamp_ms(arg3) / 1000) as u32),
                price_cumulative : 0,
                initialized      : true,
            };
            0x1::vector::push_back<Observation>(&mut v1.observations, v2);
            0x2::table::add<0x1::type_name::TypeName, TwapOracle>(&mut arg2.twap_oracles, v0, v1);
        };
    }

    public(friend) fun is_price_fluctuation_within_twap_threshold<T0: drop>(arg0: &PriceOracleConfig, arg1: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg2: &0x2::clock::Clock) : (bool, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64) {
        if (!0x2::table::contains<0x1::type_name::TypeName, TwapOracle>(&arg0.twap_oracles, 0x1::type_name::with_defining_ids<T0>())) {
            return (true, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::zero())
        };
        let v0 = get_price_fluctuation_threshold<T0>(arg0);
        let v1 = calculate_twap<T0>(arg0, (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(arg1) as u256), arg2, arg0.twap_window_size);
        let v2 = !0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::greater(arg1, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::multiply(v1, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::add(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::one(), v0))) && !0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::less(arg1, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::multiply(v1, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::sub(0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::one(), v0)));
        (v2, v1)
    }

    fun observe_single(arg0: &vector<Observation>, arg1: u32, arg2: u32, arg3: u256, arg4: u64, arg5: u64) : (u256, u32) {
        if (arg2 == 0) {
            let v0 = 0x1::vector::borrow<Observation>(arg0, arg4);
            if (v0.block_timestamp != arg1) {
                let v1 = transform_observation(v0, arg1, arg3);
                return (v1.price_cumulative, v1.block_timestamp)
            };
            return (v0.price_cumulative, v0.block_timestamp)
        };
        let v2 = if (arg2 > arg1) {
            0
        } else {
            arg1 - arg2
        };
        let (v3, v4) = get_surrounding_observations(arg0, v2, arg3, arg4, arg5);
        let v5 = v4;
        let v6 = v3;
        if (v2 == v6.block_timestamp) {
            return (v6.price_cumulative, v6.block_timestamp)
        };
        if (v2 == v5.block_timestamp) {
            return (v5.price_cumulative, v5.block_timestamp)
        };
        let v7 = v2 - v6.block_timestamp;
        (v6.price_cumulative + (v5.price_cumulative - v6.price_cumulative) * (v7 as u256) / ((v5.block_timestamp - v6.block_timestamp) as u256), v6.block_timestamp + v7)
    }

    public fun set_price_fluctuation_threshold<T0: drop>(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut PriceOracleConfig, arg3: u128, arg4: &0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        let v0 = 0x1::type_name::with_defining_ids<T0>();
        if (0x2::table::contains<0x1::type_name::TypeName, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&arg2.price_fluctuation_threshold, v0)) {
            0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::set_value(0x2::table::borrow_mut<0x1::type_name::TypeName, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&mut arg2.price_fluctuation_threshold, v0), arg3);
        } else {
            0x2::table::add<0x1::type_name::TypeName, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64>(&mut arg2.price_fluctuation_threshold, v0, 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::create_from_raw_value(arg3));
        };
    }

    public fun set_twap_window_size(arg0: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::Version, arg1: &0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::ACL, arg2: &mut PriceOracleConfig, arg3: u64, arg4: &0x2::tx_context::TxContext) {
        0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::version::assert_current_version(arg0);
        assert!(0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::has_role(arg1, 0x2::tx_context::sender(arg4), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::acl::admin_role()), 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::acl_invalid_permission());
        assert!(arg3 > 60000, 0x82d35fd978ebf1588e73c8d69b810a1615d03afe8ca2c2c600f6ecaf6269ab93::error::invalid_argument(769));
        arg2.twap_window_size = arg3;
    }

    fun transform_observation(arg0: &Observation, arg1: u32, arg2: u256) : Observation {
        Observation{
            block_timestamp  : arg1,
            price_cumulative : arg0.price_cumulative + arg2 * ((arg1 - arg0.block_timestamp) as u256),
            initialized      : true,
        }
    }

    public(friend) fun update_twap_oracle<T0: drop>(arg0: &mut PriceOracleConfig, arg1: 0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::FixedPoint64, arg2: &0x2::clock::Clock) {
        let v0 = ((0x2::clock::timestamp_ms(arg2) / 1000) as u32);
        let v1 = 0x2::table::borrow_mut<0x1::type_name::TypeName, TwapOracle>(&mut arg0.twap_oracles, 0x1::type_name::with_defining_ids<T0>());
        let v2 = 0x1::vector::borrow<Observation>(&v1.observations, v1.observation_index);
        if (v2.initialized && v2.block_timestamp == v0) {
            return
        };
        let v3 = v2.price_cumulative;
        if (!v2.initialized) {
            let v4 = 0x1::vector::borrow_mut<Observation>(&mut v1.observations, v1.observation_index);
            v4.block_timestamp = v0;
            v4.price_cumulative = 0;
            v4.initialized = true;
        } else {
            if (v1.observation_cardinality < 720 && v1.observation_index == v1.observation_cardinality - 1) {
                let v5 = Observation{
                    block_timestamp  : 0,
                    price_cumulative : 0,
                    initialized      : false,
                };
                0x1::vector::push_back<Observation>(&mut v1.observations, v5);
                v1.observation_cardinality = v1.observation_cardinality + 1;
            };
            v1.observation_index = (v1.observation_index + 1) % v1.observation_cardinality;
            let v6 = 0x1::vector::borrow_mut<Observation>(&mut v1.observations, v1.observation_index);
            v6.block_timestamp = v0;
            v6.price_cumulative = v3 + (0x120fc4f90f308b81dc95d89cde8e758140395b83ada59405f33cf68ef6e97024::fixed_point64::get_raw_value(arg1) as u256) * ((v0 - v2.block_timestamp) as u256);
            v6.initialized = true;
        };
    }

    // decompiled from Move bytecode v6
}

