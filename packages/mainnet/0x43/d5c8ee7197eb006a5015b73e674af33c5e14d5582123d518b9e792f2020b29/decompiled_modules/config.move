module 0x43d5c8ee7197eb006a5015b73e674af33c5e14d5582123d518b9e792f2020b29::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        version: u64,
        admin: 0x2::object::ID,
        fee_bps: u64,
        executor_reward_per_trade: u64,
        max_orders_per_account: u64,
        min_funding_per_trade: u64,
        default_slippage_bps: u64,
        max_slippage_bps: u64,
        min_interval_seconds: u64,
        treasury: address,
        paused: bool,
    }

    struct FeeTracker has key {
        id: 0x2::object::UID,
        admin: 0x2::object::ID,
        total_sui_collected: u64,
        sui_balance: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ConfigSnapshot has copy, drop, store {
        fee_bps: u64,
        executor_reward_per_trade: u64,
        default_slippage_bps: u64,
        treasury: address,
    }

    struct ConfigCreatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        fee_tracker_id: 0x2::object::ID,
        admin_cap_id: 0x2::object::ID,
        treasury: address,
    }

    struct ConfigUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        fee_bps: u64,
        executor_reward_per_trade: u64,
        max_orders_per_account: u64,
        min_funding_per_trade: u64,
        default_slippage_bps: u64,
        max_slippage_bps: u64,
        min_interval_seconds: u64,
    }

    struct TreasuryUpdatedEvent has copy, drop {
        config_id: 0x2::object::ID,
        old_treasury: address,
        new_treasury: address,
    }

    struct ProtocolPausedEvent has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
    }

    struct FeesWithdrawnEvent has copy, drop {
        fee_tracker_id: 0x2::object::ID,
        amount: u64,
        recipient: address,
    }

    fun assert_admin(arg0: &GlobalConfig, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 0);
    }

    fun assert_fee_tracker_admin(arg0: &FeeTracker, arg1: &AdminCap) {
        assert!(arg0.admin == 0x2::object::id<AdminCap>(arg1), 0);
    }

    public fun assert_not_paused(arg0: &GlobalConfig) {
        assert!(!arg0.paused, 5);
    }

    public fun assert_version(arg0: &GlobalConfig) {
        assert!(arg0.version == 1, 6);
    }

    public fun create_snapshot(arg0: &GlobalConfig) : ConfigSnapshot {
        ConfigSnapshot{
            fee_bps                   : arg0.fee_bps,
            executor_reward_per_trade : arg0.executor_reward_per_trade,
            default_slippage_bps      : arg0.default_slippage_bps,
            treasury                  : arg0.treasury,
        }
    }

    public fun default_slippage_bps(arg0: &GlobalConfig) : u64 {
        arg0.default_slippage_bps
    }

    public(friend) fun deposit_sui(arg0: &mut FeeTracker, arg1: 0x2::balance::Balance<0x2::sui::SUI>) {
        arg0.total_sui_collected = arg0.total_sui_collected + 0x2::balance::value<0x2::sui::SUI>(&arg1);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.sui_balance, arg1);
    }

    fun emit_config_updated(arg0: &GlobalConfig) {
        let v0 = ConfigUpdatedEvent{
            config_id                 : 0x2::object::uid_to_inner(&arg0.id),
            fee_bps                   : arg0.fee_bps,
            executor_reward_per_trade : arg0.executor_reward_per_trade,
            max_orders_per_account    : arg0.max_orders_per_account,
            min_funding_per_trade     : arg0.min_funding_per_trade,
            default_slippage_bps      : arg0.default_slippage_bps,
            max_slippage_bps          : arg0.max_slippage_bps,
            min_interval_seconds      : arg0.min_interval_seconds,
        };
        0x2::event::emit<ConfigUpdatedEvent>(v0);
    }

    public fun executor_reward_per_trade(arg0: &GlobalConfig) : u64 {
        arg0.executor_reward_per_trade
    }

    public fun fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.fee_bps
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        let v1 = 0x2::object::id<AdminCap>(&v0);
        let v2 = 0x2::tx_context::sender(arg0);
        let v3 = 0x2::object::new(arg0);
        let v4 = 0x2::object::new(arg0);
        let v5 = GlobalConfig{
            id                        : v3,
            version                   : 1,
            admin                     : v1,
            fee_bps                   : 30,
            executor_reward_per_trade : 25000000,
            max_orders_per_account    : 25000,
            min_funding_per_trade     : 100000,
            default_slippage_bps      : 100,
            max_slippage_bps          : 1000,
            min_interval_seconds      : 900,
            treasury                  : v2,
            paused                    : false,
        };
        let v6 = FeeTracker{
            id                  : v4,
            admin               : v1,
            total_sui_collected : 0,
            sui_balance         : 0x2::balance::zero<0x2::sui::SUI>(),
        };
        let v7 = ConfigCreatedEvent{
            config_id      : 0x2::object::uid_to_inner(&v3),
            fee_tracker_id : 0x2::object::uid_to_inner(&v4),
            admin_cap_id   : v1,
            treasury       : v2,
        };
        0x2::event::emit<ConfigCreatedEvent>(v7);
        0x2::transfer::transfer<AdminCap>(v0, v2);
        0x2::transfer::share_object<GlobalConfig>(v5);
        0x2::transfer::share_object<FeeTracker>(v6);
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun max_orders_per_account(arg0: &GlobalConfig) : u64 {
        arg0.max_orders_per_account
    }

    public fun max_slippage_bps(arg0: &GlobalConfig) : u64 {
        arg0.max_slippage_bps
    }

    public entry fun migrate(arg0: &mut GlobalConfig, arg1: &AdminCap) {
        assert_admin(arg0, arg1);
        assert!(arg0.version < 1, 7);
        arg0.version = 1;
    }

    public fun min_funding_per_trade(arg0: &GlobalConfig) : u64 {
        arg0.min_funding_per_trade
    }

    public fun min_interval_seconds(arg0: &GlobalConfig) : u64 {
        arg0.min_interval_seconds
    }

    public entry fun set_default_slippage_bps(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        assert!(arg2 > 0 && arg2 <= arg0.max_slippage_bps, 9);
        arg0.default_slippage_bps = arg2;
        emit_config_updated(arg0);
    }

    public entry fun set_executor_reward_per_trade(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        assert!(arg2 >= 10000000 && arg2 <= 100000000, 2);
        arg0.executor_reward_per_trade = arg2;
        emit_config_updated(arg0);
    }

    public entry fun set_fee_bps(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        assert!(arg2 <= 500, 1);
        arg0.fee_bps = arg2;
        emit_config_updated(arg0);
    }

    public entry fun set_max_orders_per_account(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        assert!(arg2 > 0 && arg2 <= 100000, 3);
        arg0.max_orders_per_account = arg2;
        emit_config_updated(arg0);
    }

    public entry fun set_max_slippage_bps(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        assert!(arg2 >= 10 && arg2 <= 5000, 12);
        assert!(arg0.default_slippage_bps <= arg2, 12);
        arg0.max_slippage_bps = arg2;
        emit_config_updated(arg0);
    }

    public entry fun set_min_funding_per_trade(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        assert!(arg2 > 0, 4);
        arg0.min_funding_per_trade = arg2;
        emit_config_updated(arg0);
    }

    public entry fun set_min_interval_seconds(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: u64) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        assert!(arg2 >= 60 && arg2 <= 31536000, 11);
        arg0.min_interval_seconds = arg2;
        emit_config_updated(arg0);
    }

    public entry fun set_paused(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: bool) {
        assert_admin(arg0, arg1);
        arg0.paused = arg2;
        let v0 = ProtocolPausedEvent{
            config_id : 0x2::object::uid_to_inner(&arg0.id),
            paused    : arg2,
        };
        0x2::event::emit<ProtocolPausedEvent>(v0);
    }

    public entry fun set_treasury(arg0: &mut GlobalConfig, arg1: &AdminCap, arg2: address) {
        assert_version(arg0);
        assert_admin(arg0, arg1);
        assert!(arg2 != @0x0, 10);
        arg0.treasury = arg2;
        let v0 = TreasuryUpdatedEvent{
            config_id    : 0x2::object::uid_to_inner(&arg0.id),
            old_treasury : arg0.treasury,
            new_treasury : arg2,
        };
        0x2::event::emit<TreasuryUpdatedEvent>(v0);
    }

    public fun snapshot_executor_reward(arg0: &ConfigSnapshot) : u64 {
        arg0.executor_reward_per_trade
    }

    public fun snapshot_fee_bps(arg0: &ConfigSnapshot) : u64 {
        arg0.fee_bps
    }

    public fun snapshot_slippage_bps(arg0: &ConfigSnapshot) : u64 {
        arg0.default_slippage_bps
    }

    public fun snapshot_treasury(arg0: &ConfigSnapshot) : address {
        arg0.treasury
    }

    public fun sui_balance(arg0: &FeeTracker) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance)
    }

    public fun total_sui_collected(arg0: &FeeTracker) : u64 {
        arg0.total_sui_collected
    }

    public fun treasury(arg0: &GlobalConfig) : address {
        arg0.treasury
    }

    public fun version(arg0: &GlobalConfig) : u64 {
        arg0.version
    }

    public entry fun withdraw_sui(arg0: &mut FeeTracker, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        assert_fee_tracker_admin(arg0, arg1);
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg0.sui_balance);
        assert!(v0 > 0, 8);
        let v1 = FeesWithdrawnEvent{
            fee_tracker_id : 0x2::object::uid_to_inner(&arg0.id),
            amount         : v0,
            recipient      : 0x2::tx_context::sender(arg2),
        };
        0x2::event::emit<FeesWithdrawnEvent>(v1);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::withdraw_all<0x2::sui::SUI>(&mut arg0.sui_balance), arg2), 0x2::tx_context::sender(arg2));
    }

    // decompiled from Move bytecode v6
}

