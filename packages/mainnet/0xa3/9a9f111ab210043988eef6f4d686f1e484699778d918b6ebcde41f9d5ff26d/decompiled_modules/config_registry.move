module 0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::config_registry {
    struct Config has store, key {
        id: 0x2::object::UID,
        dev_addr: address,
        mint_vault_id: 0x2::object::ID,
        treasury_id: 0x2::object::ID,
        guard_id: 0x2::object::ID,
        daily_mints_id: 0x2::object::ID,
        memory_ledger_id: 0x2::object::ID,
        timate_params_id: 0x2::object::ID,
        emergency_fixed_mode: bool,
        fixed_sui_usd_price_bps: u64,
        pyth_state_id: 0x2::object::ID,
        pyth_sui_price_info_id: 0x2::object::ID,
        today_dev_ratio: u64,
        today_pol_ratio: u64,
        today_buyback_ratio: u64,
        nostalgia_dev_ratio: u64,
        nostalgia_pol_ratio: u64,
        nostalgia_buyback_ratio: u64,
        today_fee_usd: u64,
        nostalgia_fee_usd: u64,
        reward_today_immediate: u64,
        reward_today_deferred: u64,
        reward_nostalgia_base: u64,
        dev_tvyn_ratio_bps: u64,
        lp_threshold_sui: u64,
        registered_pool_id: 0x2::object::ID,
        buyback_floor_price_mist: u64,
        buyback_daily_cap_sui: u64,
        buyback_max_per_run_sui: u64,
        buyback_cooldown_ms: u64,
        buyback_min_burn_bps: u64,
        keeper_reward_sui: u64,
    }

    struct PoolRegistered has copy, drop, store {
        pool_id: 0x2::object::ID,
    }

    struct FeesAndRatiosUpdated has copy, drop, store {
        today_fee_usd: u64,
        nostalgia_fee_usd: u64,
        today_dev_ratio: u64,
        today_pol_ratio: u64,
        today_buyback_ratio: u64,
        nostalgia_dev_ratio: u64,
        nostalgia_pol_ratio: u64,
        nostalgia_buyback_ratio: u64,
    }

    fun assert_ratios(arg0: u64, arg1: u64, arg2: u64) {
        assert!(arg0 + arg1 + arg2 == 10000, 103);
    }

    public fun buyback_cooldown_ms(arg0: &Config) : u64 {
        arg0.buyback_cooldown_ms
    }

    public fun buyback_daily_cap_sui(arg0: &Config) : u64 {
        arg0.buyback_daily_cap_sui
    }

    public fun buyback_floor_price_mist(arg0: &Config) : u64 {
        arg0.buyback_floor_price_mist
    }

    public fun buyback_max_per_run_sui(arg0: &Config) : u64 {
        arg0.buyback_max_per_run_sui
    }

    public fun buyback_min_burn_bps(arg0: &Config) : u64 {
        arg0.buyback_min_burn_bps
    }

    public entry fun create_and_share_default(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::object::id_from_address(@0x0);
        let v1 = Config{
            id                       : 0x2::object::new(arg1),
            dev_addr                 : 0x2::tx_context::sender(arg1),
            mint_vault_id            : v0,
            treasury_id              : v0,
            guard_id                 : v0,
            daily_mints_id           : v0,
            memory_ledger_id         : v0,
            timate_params_id         : v0,
            emergency_fixed_mode     : false,
            fixed_sui_usd_price_bps  : 10000,
            pyth_state_id            : v0,
            pyth_sui_price_info_id   : v0,
            today_dev_ratio          : 6500,
            today_pol_ratio          : 2500,
            today_buyback_ratio      : 1000,
            nostalgia_dev_ratio      : 6500,
            nostalgia_pol_ratio      : 2500,
            nostalgia_buyback_ratio  : 1000,
            today_fee_usd            : 25,
            nostalgia_fee_usd        : 100,
            reward_today_immediate   : 40000000,
            reward_today_deferred    : 20000000,
            reward_nostalgia_base    : 250000000,
            dev_tvyn_ratio_bps       : 100,
            lp_threshold_sui         : 10000000000,
            registered_pool_id       : v0,
            buyback_floor_price_mist : 10000000000,
            buyback_daily_cap_sui    : 5000000000,
            buyback_max_per_run_sui  : 1000000000,
            buyback_cooldown_ms      : 3600000,
            buyback_min_burn_bps     : 9000,
            keeper_reward_sui        : 100000000,
        };
        0x2::transfer::share_object<Config>(v1);
    }

    public(friend) fun daily_mints_id(arg0: &Config) : 0x2::object::ID {
        arg0.daily_mints_id
    }

    public fun default_royalty_bps(arg0: &Config) : u16 {
        500
    }

    public fun dev_addr(arg0: &Config) : address {
        arg0.dev_addr
    }

    public fun dev_tvyn_ratio_bps(arg0: &Config) : u64 {
        arg0.dev_tvyn_ratio_bps
    }

    public fun emergency_fixed_mode(arg0: &Config) : bool {
        arg0.emergency_fixed_mode
    }

    public fun fixed_sui_usd_price_bps(arg0: &Config) : u64 {
        arg0.fixed_sui_usd_price_bps
    }

    public(friend) fun guard_id(arg0: &Config) : 0x2::object::ID {
        arg0.guard_id
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun keeper_reward_sui(arg0: &Config) : u64 {
        arg0.keeper_reward_sui
    }

    public fun lp_threshold_sui(arg0: &Config) : u64 {
        arg0.lp_threshold_sui
    }

    public(friend) fun memory_ledger_id(arg0: &Config) : 0x2::object::ID {
        arg0.memory_ledger_id
    }

    public(friend) fun mint_vault_id(arg0: &Config) : 0x2::object::ID {
        arg0.mint_vault_id
    }

    public fun nostalgia_fee_usd(arg0: &Config) : u64 {
        arg0.nostalgia_fee_usd
    }

    public fun nostalgia_ratios(arg0: &Config) : (u64, u64, u64) {
        (arg0.nostalgia_dev_ratio, arg0.nostalgia_pol_ratio, arg0.nostalgia_buyback_ratio)
    }

    public fun pool_registered(arg0: &Config) : bool {
        arg0.registered_pool_id != 0x2::object::id_from_address(@0x0)
    }

    public(friend) fun pyth_state_id(arg0: &Config) : 0x2::object::ID {
        arg0.pyth_state_id
    }

    public(friend) fun pyth_sui_price_info_id(arg0: &Config) : 0x2::object::ID {
        arg0.pyth_sui_price_info_id
    }

    public(friend) fun registered_pool_id(arg0: &Config) : 0x2::object::ID {
        arg0.registered_pool_id
    }

    public fun reward_nostalgia_base(arg0: &Config) : u64 {
        arg0.reward_nostalgia_base
    }

    public fun reward_today_deferred(arg0: &Config) : u64 {
        arg0.reward_today_deferred
    }

    public fun reward_today_immediate(arg0: &Config) : u64 {
        arg0.reward_today_immediate
    }

    public entry fun set_buyback_params(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        assert!(arg6 <= 10000, 104);
        arg1.buyback_floor_price_mist = arg2;
        arg1.buyback_daily_cap_sui = arg3;
        arg1.buyback_max_per_run_sui = arg4;
        arg1.buyback_cooldown_ms = arg5;
        arg1.buyback_min_burn_bps = arg6;
    }

    public entry fun set_core_object_ids(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: address, arg3: address, arg4: address, arg5: address, arg6: address) {
        arg1.treasury_id = 0x2::object::id_from_address(arg2);
        arg1.guard_id = 0x2::object::id_from_address(arg3);
        arg1.daily_mints_id = 0x2::object::id_from_address(arg4);
        arg1.memory_ledger_id = 0x2::object::id_from_address(arg5);
        arg1.timate_params_id = 0x2::object::id_from_address(arg6);
    }

    public entry fun set_dev_addr(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: address) {
        arg1.dev_addr = arg2;
    }

    public entry fun set_dev_tvyn_ratio(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 200, 104);
        arg1.dev_tvyn_ratio_bps = arg2;
    }

    public entry fun set_emergency_fixed_mode(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: bool) {
        arg1.emergency_fixed_mode = arg2;
    }

    public entry fun set_fees_and_ratios(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg2 <= 1000, 104);
        assert!(arg3 <= 1000, 104);
        assert!(arg4 + arg5 <= 10000, 103);
        assert!(arg6 + arg7 <= 10000, 103);
        let v0 = 10000 - arg4 - arg5;
        let v1 = 10000 - arg6 - arg7;
        assert_ratios(arg4, arg5, v0);
        assert_ratios(arg6, arg7, v1);
        arg1.today_fee_usd = arg2;
        arg1.nostalgia_fee_usd = arg3;
        arg1.today_dev_ratio = arg4;
        arg1.today_pol_ratio = arg5;
        arg1.today_buyback_ratio = v0;
        arg1.nostalgia_dev_ratio = arg6;
        arg1.nostalgia_pol_ratio = arg7;
        arg1.nostalgia_buyback_ratio = v1;
        let v2 = FeesAndRatiosUpdated{
            today_fee_usd           : arg2,
            nostalgia_fee_usd       : arg3,
            today_dev_ratio         : arg4,
            today_pol_ratio         : arg5,
            today_buyback_ratio     : v0,
            nostalgia_dev_ratio     : arg6,
            nostalgia_pol_ratio     : arg7,
            nostalgia_buyback_ratio : v1,
        };
        0x2::event::emit<FeesAndRatiosUpdated>(v2);
    }

    public entry fun set_fixed_price_bps(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 >= 100, 105);
        assert!(arg2 <= 1000000, 104);
        arg1.fixed_sui_usd_price_bps = arg2;
    }

    public entry fun set_keeper_reward(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        assert!(arg2 <= 100000000, 104);
        arg1.keeper_reward_sui = arg2;
    }

    public entry fun set_lp_params(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: u64) {
        arg1.lp_threshold_sui = arg2;
    }

    public(friend) fun set_mint_vault_id(arg0: &mut Config, arg1: 0x2::object::ID) {
        arg0.mint_vault_id = arg1;
    }

    public entry fun set_pyth_objects(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: address, arg3: address) {
        arg1.pyth_state_id = 0x2::object::id_from_address(arg2);
        arg1.pyth_sui_price_info_id = 0x2::object::id_from_address(arg3);
    }

    public(friend) fun set_registered_pool_id(arg0: &mut Config, arg1: 0x2::object::ID) {
        arg0.registered_pool_id = arg1;
        let v0 = PoolRegistered{pool_id: arg1};
        0x2::event::emit<PoolRegistered>(v0);
    }

    public entry fun set_rewards(arg0: &0xa39a9f111ab210043988eef6f4d686f1e484699778d918b6ebcde41f9d5ff26d::admin::AdminCap, arg1: &mut Config, arg2: u64, arg3: u64, arg4: u64) {
        assert!(arg2 <= 500000000, 101);
        assert!(arg3 <= 500000000, 101);
        assert!(arg4 <= 500000000, 101);
        arg1.reward_today_immediate = arg2;
        arg1.reward_today_deferred = arg3;
        arg1.reward_nostalgia_base = arg4;
    }

    public(friend) fun timate_params_id(arg0: &Config) : 0x2::object::ID {
        arg0.timate_params_id
    }

    public fun today_fee_usd(arg0: &Config) : u64 {
        arg0.today_fee_usd
    }

    public fun today_ratios(arg0: &Config) : (u64, u64, u64) {
        (arg0.today_dev_ratio, arg0.today_pol_ratio, arg0.today_buyback_ratio)
    }

    public(friend) fun treasury_id(arg0: &Config) : 0x2::object::ID {
        arg0.treasury_id
    }

    // decompiled from Move bytecode v7
}

