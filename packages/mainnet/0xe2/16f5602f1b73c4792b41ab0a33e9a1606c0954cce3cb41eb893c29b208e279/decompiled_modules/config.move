module 0xe216f5602f1b73c4792b41ab0a33e9a1606c0954cce3cb41eb893c29b208e279::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        min_deposit: u64,
        max_deposit: u64,
        min_withdraw: u64,
        max_withdraw: u64,
    }

    public(friend) fun create_config(arg0: &CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONFIG>(arg0), 1);
        let v0 = Config{
            id           : 0x2::object::new(arg1),
            min_deposit  : 1000000,
            max_deposit  : 1000000000,
            min_withdraw : 1000000,
            max_withdraw : 1000000000,
        };
        0x2::transfer::share_object<Config>(v0);
    }

    public fun get_max_deposit(arg0: &Config) : u64 {
        arg0.max_deposit
    }

    public fun get_max_withdraw(arg0: &Config) : u64 {
        arg0.max_withdraw
    }

    public fun get_min_deposit(arg0: &Config) : u64 {
        arg0.min_deposit
    }

    public fun get_min_withdraw(arg0: &Config) : u64 {
        arg0.min_withdraw
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
    }

    public fun update_config(arg0: &0xe216f5602f1b73c4792b41ab0a33e9a1606c0954cce3cb41eb893c29b208e279::app::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        arg1.min_deposit = arg2;
        arg1.max_deposit = arg3;
        arg1.min_withdraw = arg4;
        arg1.max_withdraw = arg5;
    }

    // decompiled from Move bytecode v6
}

