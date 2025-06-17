module 0x9787cd3da373beab20f08330bbb56c727ec576b96c96590cbd83bf211b3363e0::lotus_config {
    struct LOTUS_CONFIG has drop {
        dummy_field: bool,
    }

    struct LotusConfig has key {
        id: 0x2::object::UID,
        current_version: u64,
        protocol_status: u64,
        performance_fee_bps: u64,
        strategy_fee_bps: u64,
        cold_down_ms: u64,
        early_withdrawal_fee_bps: u64,
        max_deep_fee_bps: u64,
        min_pooling_deposit_value: u64,
        configs: 0x2::table::Table<0x1::ascii::String, u64>,
    }

    struct LotusConfigCap has store, key {
        id: 0x2::object::UID,
        lotus_config: 0x2::object::ID,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (LotusConfig, LotusConfigCap) {
        let v0 = LotusConfig{
            id                        : 0x2::object::new(arg0),
            current_version           : 0,
            protocol_status           : 0,
            performance_fee_bps       : 0,
            strategy_fee_bps          : 0,
            cold_down_ms              : 0,
            early_withdrawal_fee_bps  : 0,
            max_deep_fee_bps          : 100,
            min_pooling_deposit_value : 1000000,
            configs                   : 0x2::table::new<0x1::ascii::String, u64>(arg0),
        };
        let v1 = LotusConfigCap{
            id           : 0x2::object::new(arg0),
            lotus_config : 0x2::object::id<LotusConfig>(&v0),
        };
        (v0, v1)
    }

    public fun assert_current_version(arg0: &LotusConfig) {
        assert!(arg0.current_version == 0x9787cd3da373beab20f08330bbb56c727ec576b96c96590cbd83bf211b3363e0::consts::GET_CURRENT_VERSION(), 13906835011862003711);
    }

    public fun assert_lotus_config_cap(arg0: &LotusConfig, arg1: &LotusConfigCap) {
        assert!(0x2::object::id<LotusConfig>(arg0) == arg1.lotus_config, 13906834457811222527);
    }

    public fun assert_protocol_status_ok(arg0: &LotusConfig) {
        assert!(arg0.protocol_status == 0, 13906834986092199935);
    }

    public fun get_cold_down_ms(arg0: &LotusConfig) : u64 {
        arg0.cold_down_ms
    }

    public fun get_config(arg0: &LotusConfig, arg1: 0x1::ascii::String) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, u64>(&arg0.configs, arg1), 13906834930257625087);
        *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.configs, arg1)
    }

    public fun get_current_version(arg0: &LotusConfig) : u64 {
        arg0.current_version
    }

    public fun get_early_withdrawal_fee_bps(arg0: &LotusConfig) : u64 {
        arg0.early_withdrawal_fee_bps
    }

    public fun get_max_deep_fee_bps(arg0: &LotusConfig) : u64 {
        arg0.max_deep_fee_bps
    }

    public fun get_min_pooling_deposit_value(arg0: &LotusConfig) : u64 {
        arg0.min_pooling_deposit_value
    }

    public fun get_performance_fee_bps(arg0: &LotusConfig) : u64 {
        arg0.performance_fee_bps
    }

    public fun get_protocol_status(arg0: &LotusConfig) : u64 {
        arg0.protocol_status
    }

    public fun get_strategy_fee_bps(arg0: &LotusConfig) : u64 {
        arg0.strategy_fee_bps
    }

    fun init(arg0: LOTUS_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = new(arg1);
        0x2::transfer::share_object<LotusConfig>(v0);
        0x2::transfer::transfer<LotusConfigCap>(v1, 0x2::tx_context::sender(arg1));
        0x2::package::claim_and_keep<LOTUS_CONFIG>(arg0, arg1);
    }

    public fun remove_config(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: 0x1::ascii::String) {
        assert_lotus_config_cap(arg0, arg1);
        0x2::table::remove<0x1::ascii::String, u64>(&mut arg0.configs, arg2);
    }

    public fun update_cold_down_ms(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        assert!(arg2 < 86400000, 13906834659674685439);
        arg0.cold_down_ms = arg2;
    }

    public fun update_config(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: 0x1::ascii::String, arg3: u64) {
        assert_lotus_config_cap(arg0, arg1);
        if (!0x2::table::contains<0x1::ascii::String, u64>(&arg0.configs, arg2)) {
            0x2::table::add<0x1::ascii::String, u64>(&mut arg0.configs, arg2, arg3);
        } else {
            *0x2::table::borrow_mut<0x1::ascii::String, u64>(&mut arg0.configs, arg2) = arg3;
        };
    }

    public fun update_current_version(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        arg0.current_version = arg2;
    }

    public fun update_early_withdrawal_fee_bps(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        assert!(arg2 > 0, 13906834702624358399);
        assert!(arg2 < 100, 13906834706919325695);
        arg0.early_withdrawal_fee_bps = arg2;
    }

    public fun update_max_deep_fee_bps(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        assert!(arg2 > 0, 13906834749868998655);
        assert!(arg2 < 100, 13906834754163965951);
        arg0.max_deep_fee_bps = arg2;
    }

    public fun update_min_pooling_deposit_value(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        arg0.min_pooling_deposit_value = arg2;
    }

    public fun update_performance_fee_bps(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        assert!(arg2 + arg0.strategy_fee_bps < 5000, 13906834573775339519);
        arg0.performance_fee_bps = arg2;
    }

    public fun update_protocol_status(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        arg0.protocol_status = arg2;
    }

    public fun update_strategy_fee_bps(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        assert!(arg2 + arg0.performance_fee_bps < 5000, 13906834616725012479);
        arg0.strategy_fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

