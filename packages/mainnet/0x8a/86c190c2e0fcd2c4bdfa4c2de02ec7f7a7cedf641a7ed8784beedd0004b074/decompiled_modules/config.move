module 0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        trading_manager: address,
    }

    public fun assert_address_is_not_trading_manager(arg0: address, arg1: &Config) {
        assert!(arg1.trading_manager != arg0, 2);
    }

    public fun assert_address_is_trading_manager(arg0: address, arg1: &Config) {
        assert!(arg1.trading_manager == arg0, 1);
    }

    public fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun create_config(arg0: &CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::types::is_one_time_witness<CONFIG>(arg0), 3);
        let v0 = Config{
            id              : 0x2::object::new(arg1),
            version         : 1,
            trading_manager : 0x2::tx_context::sender(arg1),
        };
        0x2::transfer::share_object<Config>(v0);
    }

    fun init(arg0: CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        create_config(&arg0, arg1);
    }

    public fun trading_manager_address(arg0: &Config) : address {
        arg0.trading_manager
    }

    public fun update_trading_manager_address(arg0: &0x8a86c190c2e0fcd2c4bdfa4c2de02ec7f7a7cedf641a7ed8784beedd0004b074::app::AdminCap, arg1: &mut Config, arg2: address) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.trading_manager = arg2;
    }

    // decompiled from Move bytecode v6
}

