module 0xb021d967d3f8ddf3d29a0a39a0ea07db1a8a5a6191c1fe15db289caaf568d5cf::config {
    struct GlobalConfig has key {
        id: 0x2::object::UID,
        admin: address,
        platform_treasury: address,
        platform_fee_bps: u64,
        creator_fee_bps: u64,
        liquidity_bps: u64,
        creator_swap_bps: u64,
        nft_holder_swap_bps: u64,
        depositor_alloc_bps: u64,
        liquidity_alloc_bps: u64,
        total_supply: u64,
        bps_denominator: u64,
        total_launches: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct LaunchCreatorCap has store, key {
        id: 0x2::object::UID,
        granted_to: address,
    }

    public fun admin(arg0: &GlobalConfig) : address {
        arg0.admin
    }

    public fun bps_denominator() : u64 {
        10000
    }

    public fun creator_fee_bps() : u64 {
        500
    }

    public fun creator_swap_bps() : u64 {
        2000
    }

    public fun depositor_alloc_bps() : u64 {
        4000
    }

    public entry fun grant_creator_cap(arg0: &AdminCap, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = LaunchCreatorCap{
            id         : 0x2::object::new(arg2),
            granted_to : arg1,
        };
        0x2::transfer::transfer<LaunchCreatorCap>(v0, arg1);
    }

    public fun increment_launches(arg0: &mut GlobalConfig) {
        arg0.total_launches = arg0.total_launches + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = GlobalConfig{
            id                  : 0x2::object::new(arg0),
            admin               : v0,
            platform_treasury   : v0,
            platform_fee_bps    : 500,
            creator_fee_bps     : 500,
            liquidity_bps       : 9000,
            creator_swap_bps    : 2000,
            nft_holder_swap_bps : 8000,
            depositor_alloc_bps : 4000,
            liquidity_alloc_bps : 6000,
            total_supply        : 1000000000000000000,
            bps_denominator     : 10000,
            total_launches      : 0,
        };
        let v2 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::share_object<GlobalConfig>(v1);
        0x2::transfer::transfer<AdminCap>(v2, v0);
    }

    public fun liquidity_alloc_bps() : u64 {
        6000
    }

    public fun liquidity_bps() : u64 {
        9000
    }

    public fun nft_holder_swap_bps() : u64 {
        8000
    }

    public fun platform_fee_bps() : u64 {
        500
    }

    public fun platform_treasury(arg0: &GlobalConfig) : address {
        arg0.platform_treasury
    }

    public fun total_launches(arg0: &GlobalConfig) : u64 {
        arg0.total_launches
    }

    public fun total_supply() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v7
}

