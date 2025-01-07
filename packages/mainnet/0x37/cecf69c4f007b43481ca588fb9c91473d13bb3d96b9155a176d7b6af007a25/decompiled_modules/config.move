module 0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::config {
    struct CONFIG has drop {
        dummy_field: bool,
    }

    struct Config has key {
        id: 0x2::object::UID,
        version: u64,
        trading_manager: address,
    }

    struct TradingManagerCap has store, key {
        id: 0x2::object::UID,
        trading_manager: address,
    }

    public fun assert_address_is_not_trading_manager(arg0: address, arg1: &Config) {
        assert!(arg1.trading_manager != arg0, 2);
    }

    public fun assert_address_is_trading_manager(arg0: &TradingManagerCap, arg1: &Config, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.trading_manager == 0x2::tx_context::sender(arg2), 1);
        assert!(arg1.trading_manager == 0x2::tx_context::sender(arg2), 1);
    }

    public fun assert_interacting_with_most_up_to_date_package(arg0: &Config) {
        assert!(arg0.version == 1, 0);
    }

    public fun assign_trading_manager(arg0: &0x37cecf69c4f007b43481ca588fb9c91473d13bb3d96b9155a176d7b6af007a25::app::AdminCap, arg1: &mut Config, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert_interacting_with_most_up_to_date_package(arg1);
        arg1.trading_manager = arg2;
        let v0 = TradingManagerCap{
            id              : 0x2::object::new(arg3),
            trading_manager : arg2,
        };
        0x2::transfer::transfer<TradingManagerCap>(v0, arg2);
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

    // decompiled from Move bytecode v6
}

