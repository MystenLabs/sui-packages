module 0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: address,
        dev_wallet: address,
        total_protocol_fee_bps: u128,
        treasury_fee_bps: u128,
        max_allowable_deviation_ms: u64,
        min_frequncy_ms: u64,
        mist_required_per_trade: u64,
    }

    public(friend) fun assert_enough_gas_was_provided_to_cover_all_trades(arg0: &Config, arg1: &0x2::coin::Coin<0x2::sui::SUI>, arg2: u8) {
        assert!((arg2 as u64) * arg0.mist_required_per_trade <= 0x2::coin::value<0x2::sui::SUI>(arg1), 13906835613157687301);
    }

    public(friend) fun assert_enough_time_has_passed_since_last_trade(arg0: &Config, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1 + arg2 - arg0.max_allowable_deviation_ms <= 0x2::clock::timestamp_ms(arg3), 13906835668992131075);
    }

    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 13906835535848013825);
    }

    public(friend) fun assert_trading_frequency_is_above_minimum_frequency(arg0: &Config, arg1: u64) {
        assert!(arg0.min_frequncy_ms <= arg1, 13906835565912915971);
    }

    public(friend) fun calculate_protocol_fee(arg0: &Config, arg1: u64) : (u64, u64) {
        let v0 = (((((arg1 as u128) * arg0.total_protocol_fee_bps / 10000) as u128) * arg0.total_protocol_fee_bps / 10000) as u64);
        (v0, (10000 as u64) - v0)
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 13906834616725405703);
        let v0 = Config{
            id                         : 0x2::object::new(arg1),
            version                    : 1,
            treasury                   : @0xd27f45b27fd36d44e7fe4674ae4666022dfb1dfd14c2a41905b7fbbc240b8b32,
            dev_wallet                 : @0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777,
            total_protocol_fee_bps     : 0,
            treasury_fee_bps           : 5000,
            max_allowable_deviation_ms : 30000,
            min_frequncy_ms            : 60000,
            mist_required_per_trade    : 5000000,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public fun dev_wallet(arg0: &Config) : address {
        arg0.dev_wallet
    }

    public fun max_allowable_deviation_ms(arg0: &Config) : u64 {
        arg0.max_allowable_deviation_ms
    }

    public fun min_frequency_ms(arg0: &Config) : u64 {
        arg0.min_frequncy_ms
    }

    public fun mist_required_per_trade(arg0: &Config) : u64 {
        arg0.mist_required_per_trade
    }

    public(friend) fun take_protocol_fee<T0>(arg0: &Config, arg1: &mut 0x2::coin::Coin<T0>, arg2: &mut 0x2::tx_context::TxContext) {
        if (arg0.total_protocol_fee_bps == 0) {
            return
        };
        let (v0, v1) = calculate_protocol_fee(arg0, 0x2::coin::value<T0>(arg1));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v0, arg2), treasury(arg0));
        0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::split<T0>(arg1, v1, arg2), dev_wallet(arg0));
    }

    public fun total_protocol_fee_bps(arg0: &Config) : u128 {
        arg0.total_protocol_fee_bps
    }

    public fun treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun treasury_fee_bps(arg0: &Config) : u128 {
        arg0.treasury_fee_bps
    }

    public fun update_dev_wallet(arg0: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::AdminCap, arg1: &mut Config, arg2: address) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.dev_wallet = arg2;
    }

    public fun update_max_allowable_deviation_ms(arg0: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.max_allowable_deviation_ms = arg2;
    }

    public fun update_min_frequency_ms(arg0: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.min_frequncy_ms = arg2;
    }

    public fun update_mist_required_per_trade(arg0: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.mist_required_per_trade = arg2;
    }

    public fun update_total_protocol_fee_bps(arg0: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::AdminCap, arg1: &mut Config, arg2: u128) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.total_protocol_fee_bps = arg2;
    }

    public fun update_treasury(arg0: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::AdminCap, arg1: &mut Config, arg2: address) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.treasury = arg2;
    }

    public fun update_treasury_fee_bps(arg0: &0x2134246a32eec18e68f1f5aadb8edd34856298ae6d32c145d28f3ca46c7fd1::admin::AdminCap, arg1: &mut Config, arg2: u128) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.treasury_fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

