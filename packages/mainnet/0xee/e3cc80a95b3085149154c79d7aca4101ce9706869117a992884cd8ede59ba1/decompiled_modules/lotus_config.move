module 0xeee3cc80a95b3085149154c79d7aca4101ce9706869117a992884cd8ede59ba1::lotus_config {
    struct LOTUS_CONFIG has drop {
        dummy_field: bool,
    }

    struct LotusConfig has key {
        id: 0x2::object::UID,
        protocol_status: u64,
        performance_fee_bps: u64,
        strategy_fee_bps: u64,
        cold_down_ms: u64,
        configs: 0x2::table::Table<0x1::ascii::String, u64>,
    }

    struct LotusConfigCap has store, key {
        id: 0x2::object::UID,
        lotus_config: 0x2::object::ID,
    }

    fun new(arg0: &mut 0x2::tx_context::TxContext) : (LotusConfig, LotusConfigCap) {
        let v0 = LotusConfig{
            id                  : 0x2::object::new(arg0),
            protocol_status     : 0,
            performance_fee_bps : 0,
            strategy_fee_bps    : 0,
            cold_down_ms        : 0,
            configs             : 0x2::table::new<0x1::ascii::String, u64>(arg0),
        };
        let v1 = LotusConfigCap{
            id           : 0x2::object::new(arg0),
            lotus_config : 0x2::object::id<LotusConfig>(&v0),
        };
        (v0, v1)
    }

    public fun assert_lotus_config_cap(arg0: &LotusConfig, arg1: &LotusConfigCap) {
        assert!(0x2::object::id<LotusConfig>(arg0) == arg1.lotus_config, 9223372281667911679);
    }

    public fun assert_protocol_status_ok(arg0: &LotusConfig) {
        assert!(arg0.protocol_status == 0, 9223372638150197247);
    }

    public fun get_cold_down_ms(arg0: &LotusConfig) : u64 {
        arg0.cold_down_ms
    }

    public fun get_config(arg0: &LotusConfig, arg1: 0x1::ascii::String) : u64 {
        assert!(0x2::table::contains<0x1::ascii::String, u64>(&arg0.configs, arg1), 9223372582315622399);
        *0x2::table::borrow<0x1::ascii::String, u64>(&arg0.configs, arg1)
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
        assert!(arg2 < 86400000, 9223372444876668927);
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

    public fun update_performance_fee_bps(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        assert!(arg2 + arg0.strategy_fee_bps < 5000, 9223372358977323007);
        arg0.performance_fee_bps = arg2;
    }

    public fun update_protocol_status(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        arg0.protocol_status = arg2;
    }

    public fun update_strategy_fee_bps(arg0: &mut LotusConfig, arg1: &LotusConfigCap, arg2: u64) {
        assert_lotus_config_cap(arg0, arg1);
        assert!(arg2 + arg0.performance_fee_bps < 5000, 9223372401926995967);
        arg0.strategy_fee_bps = arg2;
    }

    // decompiled from Move bytecode v6
}

