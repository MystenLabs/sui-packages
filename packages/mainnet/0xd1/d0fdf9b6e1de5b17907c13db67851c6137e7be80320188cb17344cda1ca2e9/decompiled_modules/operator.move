module 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::operator {
    struct OperatorCap has key {
        id: 0x2::object::UID,
    }

    public entry fun update_min_bet_amount<T0, T1>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg3: u64) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::update_min_bet_amount<T0, T1>(arg2, arg3);
    }

    public entry fun add_bet_coin_info<T0, T1>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg3: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg4: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg5: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::PriceFeedState, arg6: &0x2::coin::CoinMetadata<T1>, arg7: 0x1::string::String, arg8: 0x1::string::String, arg9: u64, arg10: &mut 0x2::tx_context::TxContext) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::add_bet_coin_info<T0, T1>(arg3, arg5, arg6, arg7, arg8);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::update_min_bet_amount<T0, T1>(arg2, arg9);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::add<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::CustodianKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::Custodian<T0, T1>>(arg4, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::new_custodian_key<T0, T1>(), 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::new<T0, T1>(arg10));
    }

    public entry fun calculate_rewards<T0>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg3: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg4: u64, arg5: vector<0x1::string::String>) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg4);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::contains<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg3, v0), 8);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::calculate_rewards<T0>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg3, v0), arg2, arg5);
    }

    fun end_round<T0>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg3: 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo, arg4: u64, arg5: u64) {
        let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg4);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::contains<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg2, v0), 5);
        let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg2, v0);
        if (!0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::is_finished<T0>(v1)) {
            assert!(arg5 >= 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::close_timestamp<T0>(v1) - 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::buffer_ms<T0>(arg0), 6);
            assert!(arg5 <= 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::close_timestamp<T0>(v1) + 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::buffer_ms<T0>(arg0), 6);
            0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::end_round<T0>(v1, arg1, arg3, arg5);
        };
    }

    public entry fun execute_round<T0>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg3: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg4: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg5: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::current_epoch<T0>(arg4);
        if (v1 == 0) {
            start_round<T0>(arg2, arg4, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg3), v1 + 1, v0, arg7);
        } else if (v1 > 0) {
            let (v2, v3) = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::get_price_by_pyth(arg5, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::price_feed_update_allowance<T0>(arg2), v0);
            if (v3 > 0) {
                stop_round<T0>(arg3, arg4, v3);
                start_round<T0>(arg2, arg4, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg3), v1 + 1, v0, arg7);
                return
            };
            if (v1 == 1) {
                lock_round<T0>(arg2, arg3, arg4, v2, v1, v0);
                start_round<T0>(arg2, arg4, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg3), v1 + 1, v0, arg7);
            } else {
                lock_round<T0>(arg2, arg3, arg4, v2, v1, v0);
                end_round<T0>(arg2, arg3, arg4, v2, v1 - 1, v0);
                start_round<T0>(arg2, arg4, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::name<T0>(arg3), v1 + 1, v0, arg7);
            };
        };
    }

    public entry fun force_stop_round<T0>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg3: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        stop_round<T0>(arg2, arg3, 9);
    }

    public entry fun force_stop_round_by_epoch<T0>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg3: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg4: u64, arg5: u64) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        stop_round_by_epoch<T0>(arg2, arg3, arg4, arg5);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<OperatorCap>(v0, @0xe27acda061cfba9cf6d52de482957ce5fe5fffc3ee5a3c7c3981ba48bc13cf1a);
    }

    public entry fun init_pool<T0>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &mut 0x2::tx_context::TxContext) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::share<T0>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::new<T0>(arg2, arg3, arg4, arg9));
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::share<T0>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::new<T0>(arg5, arg6, arg7, arg8, arg9));
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::share<T0>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::new<T0>(arg9));
    }

    fun lock_round<T0>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg3: 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo, arg4: u64, arg5: u64) {
        let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg4);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::contains<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg2, v0), 3);
        let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg2, v0);
        if (!0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::is_finished<T0>(v1)) {
            assert!(arg5 >= 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::lock_timestamp<T0>(v1) - 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::buffer_ms<T0>(arg0), 4);
            assert!(arg5 <= 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::lock_timestamp<T0>(v1) + 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::buffer_ms<T0>(arg0), 4);
            0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::lock_round<T0>(v1, arg0, arg1, arg3, arg5);
        };
    }

    public(friend) fun new_operator(arg0: address, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = OperatorCap{id: 0x2::object::new(arg1)};
        0x2::transfer::transfer<OperatorCap>(v0, arg0);
    }

    public entry fun remove_bet_coin_info<T0, T1>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg3: &0x2::coin::CoinMetadata<T1>) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::remove_bet_coin_info<T0, T1>(arg2, arg3);
    }

    fun start_round<T0>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg1: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg2: 0x1::string::String, arg3: u64, arg4: u64, arg5: &mut 0x2::tx_context::TxContext) {
        if (arg3 > 2) {
            assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::contains<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg1, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg3 - 1)), 1);
            assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::is_finished<T0>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg1, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg3 - 2))), 2);
        };
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::add<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg1, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg3), 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::start_new_round<T0>(arg0, arg2, arg3, arg4, arg5));
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::update_state<T0>(arg1, arg3);
    }

    fun stop_round<T0>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg1: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg2: u64) {
        let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::current_epoch<T0>(arg1);
        if (v0 > 1) {
            let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg1, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(v0 - 1));
            if (!0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::is_finished<T0>(v1)) {
                0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::force_stop_round<T0>(v1, arg0, arg2);
            };
        };
        let v2 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg1, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(v0));
        if (!0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::is_finished<T0>(v2)) {
            0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::force_stop_round<T0>(v2, arg0, arg2);
        };
    }

    fun stop_round_by_epoch<T0>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg1: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg2: u64, arg3: u64) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::force_stop_round<T0>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg1, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg2)), arg0, arg3);
    }

    public entry fun update_bet_coin_info<T0, T1>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg3: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::PriceFeedState, arg4: &0x2::coin::CoinMetadata<T1>, arg5: 0x1::string::String, arg6: 0x1::string::String) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::update_bet_coin_info<T0, T1>(arg2, arg3, arg4, arg5, arg6);
    }

    public entry fun update_configuration<T0>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::update<T0>(arg2, arg3, arg4, arg5, arg6);
    }

    fun update_pool_price_and_treasury<T0, T1>(arg0: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg2: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg3: u64, arg4: 0x1::string::String, arg5: 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_info::PriceInfo) {
        let v0 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::new_round_key<T0>(arg3);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::contains<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg2, v0), 7);
        let v1 = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::CustodianKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::Custodian<T0, T1>>(arg2, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::new_custodian_key<T0, T1>());
        if (!0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::contains_treasury_balance<T0, T1>(v1, arg3)) {
            0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::add_round_balance<T0, T1>(v1, arg3, 0x2::balance::zero<T1>());
        };
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::add_treasury_balance<T0, T1>(v1, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::custodian::sub_round_balance<T0, T1>(v1, arg3, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::update_pool_price_and_treasury<T0>(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::borrow_mut<T0, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundKey<T0>, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::round::RoundInfo<T0>>(arg2, v0), arg0, arg1, arg4, arg5)));
    }

    public entry fun update_pyth_pool_price_and_treasury<T0, T1>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg3: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg4: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg5: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::PriceFeedState, arg6: u64, arg7: 0x1::string::String, arg8: &0x8d97f1cd6ac663735be08d1d2b6d02a159e711586461306ce60a2b7a6a565a9e::price_info::PriceInfoObject, arg9: &0x2::clock::Clock) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::contains_bet_coin<T0, T1>(arg3, arg7), 10);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::is_valid_price_info_object<T1>(arg5, arg8), 11);
        let (v0, v1) = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::get_price_by_pyth(arg8, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::price_feed_update_allowance<T0>(arg2), 0x2::clock::timestamp_ms(arg9));
        assert!(v1 == 0, 12);
        update_pool_price_and_treasury<T0, T1>(arg2, arg3, arg4, arg6, arg7, v0);
    }

    public entry fun update_supra_pool_price_and_treasury<T0, T1>(arg0: &OperatorCap, arg1: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::Version, arg2: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::Configuration<T0>, arg3: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::Pool<T0>, arg4: &mut 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::state::State<T0>, arg5: &0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::PriceFeedState, arg6: u64, arg7: 0x1::string::String, arg8: &0x5d8fbbf6f908a4af8c6d072669a462d53e03eb3c1d863bd0359dc818c69ea706::SupraSValueFeed::OracleHolder, arg9: bool, arg10: &0x2::clock::Clock) {
        0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::version::assert_current_version(arg1);
        assert!(0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::contains_bet_coin<T0, T1>(arg3, arg7), 10);
        let (v0, v1) = 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::price_feed::get_price_by_supra(arg5, arg8, 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::pool::bet_coin_type<T0>(arg3, arg7), 0x6c534b6f95c9f8563f9722c7784f25efaa8c102d4b644bccbc2b041c274c6c61::configuration::price_feed_update_allowance<T0>(arg2), arg9, 0x2::clock::timestamp_ms(arg10));
        assert!(v1 == 0, 12);
        update_pool_price_and_treasury<T0, T1>(arg2, arg3, arg4, arg6, arg7, v0);
    }

    // decompiled from Move bytecode v6
}

