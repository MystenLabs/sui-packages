module 0xce69c367e9f26eb554efbb379776f0f0d213cae6f87803fbfe8b304f925e47cc::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GameConfig has key {
        id: 0x2::object::UID,
        version: u64,
        water_price_dwl: u64,
        dwl_per_sui: u64,
        treasury_address: address,
        drain_rate_normal: u64,
        drain_rate_grace: u64,
        grace_period_ms: u64,
        watering_cooldown_ms: u64,
        health_restore: u64,
        max_health: u64,
        water_per_watering: u64,
        is_paused: bool,
    }

    public fun assert_not_paused(arg0: &GameConfig) {
        assert!(!arg0.is_paused, 1);
    }

    public fun assert_version(arg0: &GameConfig) {
        assert!(arg0.version == 1, 0);
    }

    public(friend) fun drain_rate_grace(arg0: &GameConfig) : u64 {
        arg0.drain_rate_grace
    }

    public(friend) fun drain_rate_normal(arg0: &GameConfig) : u64 {
        arg0.drain_rate_normal
    }

    public(friend) fun dwl_per_sui(arg0: &GameConfig) : u64 {
        arg0.dwl_per_sui
    }

    public(friend) fun grace_period_ms(arg0: &GameConfig) : u64 {
        arg0.grace_period_ms
    }

    public(friend) fun health_restore(arg0: &GameConfig) : u64 {
        arg0.health_restore
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GameConfig{
            id                   : 0x2::object::new(arg0),
            version              : 1,
            water_price_dwl      : 1000000000,
            dwl_per_sui          : 100000000000,
            treasury_address     : 0x2::tx_context::sender(arg0),
            drain_rate_normal    : 1000,
            drain_rate_grace     : 500,
            grace_period_ms      : 604800000,
            watering_cooldown_ms : 43200000,
            health_restore       : 20,
            max_health           : 100,
            water_per_watering   : 1000000000,
            is_paused            : false,
        };
        0x2::transfer::share_object<GameConfig>(v1);
    }

    public(friend) fun max_health(arg0: &GameConfig) : u64 {
        arg0.max_health
    }

    public fun set_drain_rates(arg0: &AdminCap, arg1: &mut GameConfig, arg2: u64, arg3: u64) {
        arg1.drain_rate_normal = arg2;
        arg1.drain_rate_grace = arg3;
    }

    public fun set_dwl_per_sui(arg0: &AdminCap, arg1: &mut GameConfig, arg2: u64) {
        arg1.dwl_per_sui = arg2;
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut GameConfig, arg2: bool) {
        arg1.is_paused = arg2;
    }

    public fun set_treasury_address(arg0: &AdminCap, arg1: &mut GameConfig, arg2: address) {
        arg1.treasury_address = arg2;
    }

    public fun set_water_price(arg0: &AdminCap, arg1: &mut GameConfig, arg2: u64) {
        arg1.water_price_dwl = arg2;
    }

    public(friend) fun treasury_address(arg0: &GameConfig) : address {
        arg0.treasury_address
    }

    public(friend) fun version(arg0: &GameConfig) : u64 {
        arg0.version
    }

    public(friend) fun water_per_watering(arg0: &GameConfig) : u64 {
        arg0.water_per_watering
    }

    public(friend) fun water_price_dwl(arg0: &GameConfig) : u64 {
        arg0.water_price_dwl
    }

    public(friend) fun watering_cooldown_ms(arg0: &GameConfig) : u64 {
        arg0.watering_cooldown_ms
    }

    // decompiled from Move bytecode v6
}

