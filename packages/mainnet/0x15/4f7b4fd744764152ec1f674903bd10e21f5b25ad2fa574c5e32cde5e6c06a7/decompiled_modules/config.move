module 0x154f7b4fd744764152ec1f674903bd10e21f5b25ad2fa574c5e32cde5e6c06a7::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        admin: address,
        platform_treasury: address,
        platform_fee_bps: u64,
        project_fee_bps: u64,
        pool_bps: u64,
        launch_count: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchCreatorCap has store, key {
        id: 0x2::object::UID,
        authorized_creator: address,
    }

    public fun activation_delay_ms() : u64 {
        3900000
    }

    public fun admin(arg0: &GlobalConfig) : address {
        arg0.admin
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun crank_delay_ms() : u64 {
        300000
    }

    public fun creator_cap_creator(arg0: &LaunchCreatorCap) : address {
        arg0.authorized_creator
    }

    public fun deposit_duration_ms() : u64 {
        86400000
    }

    public entry fun grant_launch_creator(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchCreatorCap{
            id                 : 0x2::object::new(arg2),
            authorized_creator : arg1,
        };
        0x2::transfer::transfer<LaunchCreatorCap>(v0, arg1);
    }

    public fun increment_launch_count(arg0: &mut GlobalConfig) {
        arg0.launch_count = arg0.launch_count + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = AdminCap{id: 0x2::object::new(arg0)};
        let v2 = GlobalConfig{
            id                : 0x2::object::new(arg0),
            admin             : v0,
            platform_treasury : v0,
            platform_fee_bps  : 500,
            project_fee_bps   : 500,
            pool_bps          : 9000,
            launch_count      : 0,
        };
        0x2::transfer::share_object<GlobalConfig>(v2);
        0x2::transfer::transfer<AdminCap>(v1, v0);
    }

    public fun launch_count(arg0: &GlobalConfig) : u64 {
        arg0.launch_count
    }

    public fun platform_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.platform_fee_bps
    }

    public fun platform_fee_bps_const() : u64 {
        500
    }

    public fun platform_treasury(arg0: &GlobalConfig) : address {
        arg0.platform_treasury
    }

    public fun pool_bps(arg0: &GlobalConfig) : u64 {
        arg0.pool_bps
    }

    public fun pool_bps_const() : u64 {
        9000
    }

    public fun project_fee_bps(arg0: &GlobalConfig) : u64 {
        arg0.project_fee_bps
    }

    public fun project_fee_bps_const() : u64 {
        500
    }

    public fun status_closed() : u8 {
        3
    }

    public fun status_cranking() : u8 {
        1
    }

    public fun status_funding() : u8 {
        0
    }

    public fun status_live() : u8 {
        2
    }

    public fun total_supply_const() : u64 {
        1000000000000000000
    }

    public entry fun update_platform_treasury(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.platform_treasury = arg2;
    }

    public fun vesting_duration_ms() : u64 {
        604800000
    }

    // decompiled from Move bytecode v7
}

