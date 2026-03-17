module 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        liquidity_fee_bps: u64,
        apy_bps: u64,
        min_lock_days: u64,
        max_lock_days: u64,
        reward_wallet: address,
    }

    public fun get_apy(arg0: &GlobalConfig) : u64 {
        arg0.apy_bps
    }

    public fun get_liquidity_fee(arg0: &GlobalConfig) : u64 {
        arg0.liquidity_fee_bps
    }

    public fun get_max_lock_days(arg0: &GlobalConfig) : u64 {
        arg0.max_lock_days
    }

    public fun get_min_lock_days(arg0: &GlobalConfig) : u64 {
        arg0.min_lock_days
    }

    public fun get_reward_wallet(arg0: &GlobalConfig) : address {
        arg0.reward_wallet
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GlobalConfig{
            id                : 0x2::object::new(arg0),
            liquidity_fee_bps : 1000,
            apy_bps           : 1500,
            min_lock_days     : 0,
            max_lock_days     : 3650,
            reward_wallet     : @0x4dabfb497c6a0173e37041e18b4ed3ade4c820681c206f7ba5cce6ca7ae50669,
        };
        0x2::transfer::share_object<GlobalConfig>(v0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::public_transfer<AdminCap>(v1, 0x2::tx_context::sender(arg0));
    }

    public fun update_apy(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 <= 100000, 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::invalid_apy_bps());
        arg1.apy_bps = arg2;
    }

    public fun update_duration_limits(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64, arg3: u64) {
        assert!(arg2 <= arg3, 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::invalid_duration());
        arg1.min_lock_days = arg2;
        arg1.max_lock_days = arg3;
    }

    public fun update_liquidity_fee(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: u64) {
        assert!(arg2 <= 5000, 0xd7ca095524ec25cd3a276506d8045ef4992c82381145dec375a9ede9b34b5b02::errors::invalid_fee_bps());
        arg1.liquidity_fee_bps = arg2;
    }

    public fun update_reward_wallet(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.reward_wallet = arg2;
    }

    // decompiled from Move bytecode v6
}

