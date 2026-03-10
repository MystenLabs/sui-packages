module 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        min_cycle_interval_ms: u64,
        min_snapshot_interval_ms: u64,
        cetus_pool_id: address,
        lending_market_id: address,
        perps_market_id: address,
        flashloan_provider_id: address,
        frozen: bool,
    }

    struct ConfigFrozenEvent has copy, drop, store {
        min_cycle_interval_ms: u64,
        min_snapshot_interval_ms: u64,
        cetus_pool_id: address,
        lending_market_id: address,
        perps_market_id: address,
        flashloan_provider_id: address,
    }

    public fun new(arg0: u64, arg1: u64, arg2: &mut 0x2::tx_context::TxContext) : (Config, AdminCap) {
        let v0 = Config{
            id                       : 0x2::object::new(arg2),
            min_cycle_interval_ms    : arg0,
            min_snapshot_interval_ms : arg1,
            cetus_pool_id            : @0x0,
            lending_market_id        : @0x0,
            perps_market_id          : @0x0,
            flashloan_provider_id    : @0x0,
            frozen                   : false,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg2)};
        (v0, v1)
    }

    fun assert_mutable(arg0: &Config) {
        assert!(!arg0.frozen, 0x95246ae1b6095d01225f07cf8d691b92b6c3238f0013a4b4cce3882fa31ec00::errors::e_config_frozen());
    }

    public fun cetus_pool_id(arg0: &Config) : address {
        arg0.cetus_pool_id
    }

    public fun flashloan_provider_id(arg0: &Config) : address {
        arg0.flashloan_provider_id
    }

    public fun is_frozen(arg0: &Config) : bool {
        arg0.frozen
    }

    public fun lending_market_id(arg0: &Config) : address {
        arg0.lending_market_id
    }

    public fun min_cycle_interval_ms(arg0: &Config) : u64 {
        arg0.min_cycle_interval_ms
    }

    public fun min_snapshot_interval_ms(arg0: &Config) : u64 {
        arg0.min_snapshot_interval_ms
    }

    public fun perps_market_id(arg0: &Config) : address {
        arg0.perps_market_id
    }

    public fun seal(arg0: &mut Config, arg1: &AdminCap) {
        assert_mutable(arg0);
        arg0.frozen = true;
        let v0 = ConfigFrozenEvent{
            min_cycle_interval_ms    : arg0.min_cycle_interval_ms,
            min_snapshot_interval_ms : arg0.min_snapshot_interval_ms,
            cetus_pool_id            : arg0.cetus_pool_id,
            lending_market_id        : arg0.lending_market_id,
            perps_market_id          : arg0.perps_market_id,
            flashloan_provider_id    : arg0.flashloan_provider_id,
        };
        0x2::event::emit<ConfigFrozenEvent>(v0);
    }

    public fun set_cetus_pool_id(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        assert_mutable(arg0);
        arg0.cetus_pool_id = arg2;
    }

    public fun set_flashloan_provider_id(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        assert_mutable(arg0);
        arg0.flashloan_provider_id = arg2;
    }

    public fun set_lending_market_id(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        assert_mutable(arg0);
        arg0.lending_market_id = arg2;
    }

    public fun set_min_cycle_interval_ms(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert_mutable(arg0);
        arg0.min_cycle_interval_ms = arg2;
    }

    public fun set_min_snapshot_interval_ms(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        assert_mutable(arg0);
        arg0.min_snapshot_interval_ms = arg2;
    }

    public fun set_perps_market_id(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        assert_mutable(arg0);
        arg0.perps_market_id = arg2;
    }

    // decompiled from Move bytecode v6
}

