module 0xc6333fb9512cd7f21494517ad79b9339662be42f7592b7ecf3fa832cf4d6a33b::admin {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct Config has store, key {
        id: 0x2::object::UID,
        fee_rate: u64,
        treasury: address,
        paused: bool,
        min_deposit: u64,
        max_deposit: u64,
        max_withdraw: u64,
        rate_limit_window: u64,
        rate_limit_count: u64,
        large_tx_threshold_bps: u64,
        timelock_delay: u64,
        pending_fee_rate: u64,
        pending_treasury: address,
        timelock_unlock_time: u64,
    }

    struct ProtocolPaused has copy, drop {
        timestamp: u64,
    }

    struct ProtocolUnpaused has copy, drop {
        timestamp: u64,
    }

    struct FeeRateChangeInitiated has copy, drop {
        new_rate: u64,
        unlock_time: u64,
    }

    struct FeeRateChangeExecuted has copy, drop {
        new_rate: u64,
    }

    struct TreasuryChangeInitiated has copy, drop {
        new_treasury: address,
        unlock_time: u64,
    }

    struct TreasuryChangeExecuted has copy, drop {
        new_treasury: address,
    }

    public fun execute_fee_rate_change(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.timelock_unlock_time, 206);
        arg0.fee_rate = arg0.pending_fee_rate;
        arg0.timelock_unlock_time = 0;
        let v0 = FeeRateChangeExecuted{new_rate: arg0.fee_rate};
        0x2::event::emit<FeeRateChangeExecuted>(v0);
    }

    public fun execute_treasury_change(arg0: &mut Config, arg1: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::epoch_timestamp_ms(arg1) >= arg0.timelock_unlock_time, 206);
        arg0.treasury = arg0.pending_treasury;
        arg0.timelock_unlock_time = 0;
        let v0 = TreasuryChangeExecuted{new_treasury: arg0.treasury};
        0x2::event::emit<TreasuryChangeExecuted>(v0);
    }

    public fun get_fee_rate(arg0: &Config) : u64 {
        arg0.fee_rate
    }

    public fun get_large_tx_threshold(arg0: &Config) : u64 {
        arg0.large_tx_threshold_bps
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

    public fun get_rate_limit_count(arg0: &Config) : u64 {
        arg0.rate_limit_count
    }

    public fun get_rate_limit_window(arg0: &Config) : u64 {
        arg0.rate_limit_window
    }

    public fun get_timelock_delay(arg0: &Config) : u64 {
        arg0.timelock_delay
    }

    public fun get_timelock_unlock_time(arg0: &Config) : u64 {
        arg0.timelock_unlock_time
    }

    public fun get_treasury(arg0: &Config) : address {
        arg0.treasury
    }

    public fun initialize(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = Config{
            id                     : 0x2::object::new(arg0),
            fee_rate               : 100,
            treasury               : 0x2::tx_context::sender(arg0),
            paused                 : false,
            min_deposit            : 1000000,
            max_deposit            : 100000000,
            max_withdraw           : 100000000,
            rate_limit_window      : 3600000,
            rate_limit_count       : 10,
            large_tx_threshold_bps : 1000,
            timelock_delay         : 86400,
            pending_fee_rate       : 100,
            pending_treasury       : 0x2::tx_context::sender(arg0),
            timelock_unlock_time   : 0,
        };
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_share_object<Config>(v0);
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun initiate_fee_rate_change(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg1);
        assert!(arg2 <= 500, 201);
        arg0.pending_fee_rate = arg2;
        arg0.timelock_unlock_time = 0x2::tx_context::epoch_timestamp_ms(arg3) + arg0.timelock_delay * 1000;
        let v0 = FeeRateChangeInitiated{
            new_rate    : arg2,
            unlock_time : arg0.timelock_unlock_time,
        };
        0x2::event::emit<FeeRateChangeInitiated>(v0);
    }

    public fun initiate_treasury_change(arg0: &mut Config, arg1: &AdminCap, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg1);
        arg0.pending_treasury = arg2;
        arg0.timelock_unlock_time = 0x2::tx_context::epoch_timestamp_ms(arg3) + arg0.timelock_delay * 1000;
        let v0 = TreasuryChangeInitiated{
            new_treasury : arg2,
            unlock_time  : arg0.timelock_unlock_time,
        };
        0x2::event::emit<TreasuryChangeInitiated>(v0);
    }

    public fun is_paused(arg0: &Config) : bool {
        arg0.paused
    }

    public fun is_timelock_active(arg0: &Config) : bool {
        arg0.timelock_unlock_time > 0
    }

    public fun pause(arg0: &mut Config, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg1);
        assert!(!arg0.paused, 202);
        arg0.paused = true;
        let v0 = ProtocolPaused{timestamp: 0x2::tx_context::epoch_timestamp_ms(arg2)};
        0x2::event::emit<ProtocolPaused>(v0);
    }

    public fun set_fee_rate(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        verify_admin(arg1);
        assert!(arg2 <= 500, 201);
        arg0.fee_rate = arg2;
    }

    public fun set_large_tx_threshold(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        verify_admin(arg1);
        assert!(arg2 <= 10000, 204);
        arg0.large_tx_threshold_bps = arg2;
    }

    public fun set_max_deposit(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        verify_admin(arg1);
        assert!(arg2 == 0 || arg2 >= arg0.min_deposit, 204);
        arg0.max_deposit = arg2;
    }

    public fun set_max_withdraw(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        verify_admin(arg1);
        arg0.max_withdraw = arg2;
    }

    public fun set_min_deposit(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        verify_admin(arg1);
        arg0.min_deposit = arg2;
    }

    public fun set_rate_limit(arg0: &mut Config, arg1: &AdminCap, arg2: u64, arg3: u64) {
        verify_admin(arg1);
        assert!(arg2 > 0 && arg3 > 0, 207);
        arg0.rate_limit_window = arg2;
        arg0.rate_limit_count = arg3;
    }

    public fun set_timelock_delay(arg0: &mut Config, arg1: &AdminCap, arg2: u64) {
        verify_admin(arg1);
        assert!(arg2 >= 3600 && arg2 <= 604800, 205);
        arg0.timelock_delay = arg2;
    }

    public fun set_treasury(arg0: &mut Config, arg1: &AdminCap, arg2: address) {
        verify_admin(arg1);
        arg0.treasury = arg2;
    }

    public fun unpause(arg0: &mut Config, arg1: &AdminCap, arg2: &mut 0x2::tx_context::TxContext) {
        verify_admin(arg1);
        assert!(arg0.paused, 203);
        arg0.paused = false;
        let v0 = ProtocolUnpaused{timestamp: 0x2::tx_context::epoch_timestamp_ms(arg2)};
        0x2::event::emit<ProtocolUnpaused>(v0);
    }

    public fun verify_admin(arg0: &AdminCap) {
    }

    // decompiled from Move bytecode v6
}

