module 0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        dev_wallet: address,
        total_protocol_fee_bps: u128,
        treasury_fee_bps: u128,
        max_allowable_deviation_ms: u64,
        min_frequncy_ms: u64,
        mist_required_per_trade: u64,
        aftermath_pk: vector<u8>,
    }

    fun address_from_bytes(arg0: &vector<u8>, arg1: u64) : address {
        assert!(0x1::vector::length<u8>(arg0) == arg1, 5);
        0x2::address::from_bytes(0x2::hash::blake2b256(arg0))
    }

    public(friend) fun assert_enough_gas_was_provided_to_cover_all_trades(arg0: &Config, arg1: &0x2::coin::Coin<0x2::sui::SUI>, arg2: u8) {
        assert!((arg2 as u64) * arg0.mist_required_per_trade <= 0x2::coin::value<0x2::sui::SUI>(arg1), 2);
    }

    public(friend) fun assert_enough_time_has_passed_since_last_trade(arg0: &Config, arg1: u64, arg2: u64, arg3: &0x2::clock::Clock) {
        assert!(arg1 + arg2 - arg0.max_allowable_deviation_ms <= 0x2::clock::timestamp_ms(arg3), 1);
    }

    public(friend) fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun assert_public_key_corresponds_to_tx_sender(arg0: &vector<u8>, arg1: address) {
        let v0 = if (*0x1::vector::borrow<u8>(arg0, 0) == 0) {
            33
        } else {
            34
        };
        assert!(arg1 == address_from_bytes(arg0, v0), 4);
    }

    public(friend) fun assert_trading_frequency_is_above_minimum_frequency(arg0: &Config, arg1: u64) {
        assert!(arg0.min_frequncy_ms <= arg1, 1);
    }

    public(friend) fun calculate_protocol_fee(arg0: &Config, arg1: u64) : (u64, u64) {
        let v0 = (((((arg1 as u128) * arg0.total_protocol_fee_bps / 10000) as u128) * arg0.total_protocol_fee_bps / 10000) as u64);
        (v0, (10000 as u64) - v0)
    }

    public(friend) fun create_package_config<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 3);
        let v0 = Config{
            id                         : 0x2::object::new(arg1),
            version                    : 1,
            dev_wallet                 : @0x1fb0c0a6790860fc83c8f26f6fa089868ad94de9468348f98dfb4cdf89a53777,
            total_protocol_fee_bps     : 10,
            treasury_fee_bps           : 5000,
            max_allowable_deviation_ms : 30000,
            min_frequncy_ms            : 60000,
            mist_required_per_trade    : 5000000,
            aftermath_pk               : x"00a6698d05dbff3c19903a3c83dc7815f2cdf77225be97df88f53abd1ccbb43f20",
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public fun derive_multisig_address(arg0: &Config, arg1: vector<u8>) : address {
        let v0 = b"";
        0x1::vector::push_back<u8>(&mut v0, 3);
        0x1::vector::append<u8>(&mut v0, x"0100");
        0x1::vector::append<u8>(&mut v0, arg0.aftermath_pk);
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::push_back<u8>(&mut v0, 1);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    public fun dev_wallet(arg0: &Config) : address {
        arg0.dev_wallet
    }

    public fun update_mist_required_per_trade(arg0: &0xf6029703ce9cace8bb0e9fb85fc5c82cb694ae20d40a6368ed9aed7e8d967278::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.mist_required_per_trade = arg2;
    }

    // decompiled from Move bytecode v6
}

