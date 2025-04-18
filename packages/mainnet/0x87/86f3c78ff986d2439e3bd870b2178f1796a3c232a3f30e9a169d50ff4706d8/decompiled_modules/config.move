module 0x8786f3c78ff986d2439e3bd870b2178f1796a3c232a3f30e9a169d50ff4706d8::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        treasury: address,
        dev_wallet: address,
        total_protocol_fee_bps: u128,
        treasury_fee_bps: u128,
        mist_required_per_order: u64,
    }

    public(friend) fun assert_enough_gas_was_provided(arg0: &Config, arg1: &0x2::coin::Coin<0x2::sui::SUI>) {
        assert!(arg0.mist_required_per_order <= 0x2::coin::value<0x2::sui::SUI>(arg1), 9223373054762156035);
    }

    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 9223373024697253889);
    }

    public(friend) fun calculate_fee(arg0: u64, arg1: u128) : u64 {
        (((arg0 as u128) * arg1 / 10000) as u64)
    }

    public(friend) fun calculate_protocol_fee(arg0: &Config, arg1: u64) : (u64, u64) {
        let v0 = calculate_fee(calculate_fee(arg1, arg0.total_protocol_fee_bps), arg0.total_protocol_fee_bps);
        (v0, (10000 as u64) - v0)
    }

    public(friend) fun create_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 9223372427697061893);
        let v0 = Config{
            id                      : 0x2::object::new(arg1),
            version                 : 1,
            treasury                : @0x6,
            dev_wallet              : @0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777,
            total_protocol_fee_bps  : 10,
            treasury_fee_bps        : 5000,
            mist_required_per_order : 5000000,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public fun dev_wallet(arg0: &Config) : address {
        arg0.dev_wallet
    }

    public fun mist_required_per_order(arg0: &Config) : u64 {
        arg0.mist_required_per_order
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

    public fun update_mist_required_per_order(arg0: &0x8786f3c78ff986d2439e3bd870b2178f1796a3c232a3f30e9a169d50ff4706d8::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.mist_required_per_order = arg2;
    }

    public fun upgrade_version(arg0: &0x8786f3c78ff986d2439e3bd870b2178f1796a3c232a3f30e9a169d50ff4706d8::admin::AdminCap, arg1: &mut Config) {
        assert!(arg1.version == 1 - 1, 9223372749819346945);
        arg1.version = 1;
    }

    // decompiled from Move bytecode v6
}

