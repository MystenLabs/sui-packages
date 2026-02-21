module 0xca27fdb22fd1c6c8ac56de28552e51cf769bf0f61f11f3c9dc25d44c9c18b22a::market {
    struct MarketAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MarketConfig has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        version: u64,
        paused: bool,
        min_task_reward: u64,
        platform_fee_bps: u64,
        total_tasks_created: u64,
        total_tasks_completed: u64,
        total_volume: u64,
    }

    struct MarketPaused has copy, drop {
        paused: bool,
    }

    struct ConfigUpdated has copy, drop {
        field: 0x1::string::String,
        new_value: u64,
    }

    public fun increment_tasks_completed(arg0: &mut MarketConfig, arg1: u64) {
        arg0.total_tasks_completed = arg0.total_tasks_completed + 1;
        arg0.total_volume = arg0.total_volume + arg1;
    }

    public fun increment_tasks_created(arg0: &mut MarketConfig) {
        arg0.total_tasks_created = arg0.total_tasks_created + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = MarketAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MarketAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = MarketConfig{
            id                    : 0x2::object::new(arg0),
            name                  : 0x1::string::utf8(b"AgentUmi Market"),
            version               : 1,
            paused                : false,
            min_task_reward       : 1000000,
            platform_fee_bps      : 500,
            total_tasks_created   : 0,
            total_tasks_completed : 0,
            total_volume          : 0,
        };
        0x2::transfer::share_object<MarketConfig>(v1);
    }

    public fun is_paused(arg0: &MarketConfig) : bool {
        arg0.paused
    }

    public fun min_task_reward(arg0: &MarketConfig) : u64 {
        arg0.min_task_reward
    }

    public fun platform_fee_bps(arg0: &MarketConfig) : u64 {
        arg0.platform_fee_bps
    }

    entry fun set_min_reward(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: u64) {
        arg1.min_task_reward = arg2;
        let v0 = ConfigUpdated{
            field     : 0x1::string::utf8(b"min_task_reward"),
            new_value : arg2,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    entry fun set_paused(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: bool) {
        arg1.paused = arg2;
        let v0 = MarketPaused{paused: arg2};
        0x2::event::emit<MarketPaused>(v0);
    }

    entry fun set_platform_fee(arg0: &MarketAdminCap, arg1: &mut MarketConfig, arg2: u64) {
        arg1.platform_fee_bps = arg2;
        let v0 = ConfigUpdated{
            field     : 0x1::string::utf8(b"platform_fee_bps"),
            new_value : arg2,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public fun total_completed(arg0: &MarketConfig) : u64 {
        arg0.total_tasks_completed
    }

    public fun total_tasks(arg0: &MarketConfig) : u64 {
        arg0.total_tasks_created
    }

    public fun total_volume(arg0: &MarketConfig) : u64 {
        arg0.total_volume
    }

    // decompiled from Move bytecode v6
}

