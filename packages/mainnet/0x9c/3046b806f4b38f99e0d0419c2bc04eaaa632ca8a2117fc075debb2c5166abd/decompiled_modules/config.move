module 0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::config {
    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        max_performance_fee_bps: u64,
        max_management_fee_bps: u64,
        max_withdrawal_fee_bps: u64,
    }

    public(friend) fun assert_fees_are_valid(arg0: &Config, arg1: u64, arg2: u64, arg3: u64) {
        assert!(arg1 <= arg0.max_performance_fee_bps, 2);
        assert!(arg2 <= arg0.max_management_fee_bps, 2);
        assert!(arg3 <= arg0.max_withdrawal_fee_bps, 2);
    }

    public(friend) fun assert_package_version(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun create_config_and_share<T0: drop>(arg0: &T0, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<T0>(arg0), 1);
        let v0 = Config{
            id                      : 0x2::object::new(arg1),
            version                 : 1,
            max_performance_fee_bps : 2000,
            max_management_fee_bps  : 1000,
            max_withdrawal_fee_bps  : 500,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public(friend) fun current_version() : u64 {
        1
    }

    public fun upgrade_version<T0>(arg0: &0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::AuthorityCap<0x9c3046b806f4b38f99e0d0419c2bc04eaaa632ca8a2117fc075debb2c5166abd::authority::PACKAGE, T0>, arg1: &mut Config) {
        assert!(arg1.version == 1 - 1, 0);
        arg1.version = 1;
    }

    public fun version(arg0: &Config) : u64 {
        arg0.version
    }

    // decompiled from Move bytecode v6
}

