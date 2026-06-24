module 0xef426db10b4a5a21ed510e26e8bbe2a75dadd21edbdc1b58beffb86b55e645f6::config {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GlobalConfig has key {
        id: 0x2::object::UID,
        platform_treasury: address,
        paused: bool,
        total_launches: u64,
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

    public fun increment_launches(arg0: &mut GlobalConfig) {
        arg0.total_launches = arg0.total_launches + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GlobalConfig{
            id                : 0x2::object::new(arg0),
            platform_treasury : @0x72fb6101d12f0c4f35374b50d939f836f2878e695bb559679c823a9ae7fc25d5,
            paused            : false,
            total_launches    : 0,
        };
        0x2::transfer::share_object<GlobalConfig>(v1);
    }

    public fun is_paused(arg0: &GlobalConfig) : bool {
        arg0.paused
    }

    public fun liquidity_alloc_bps() : u64 {
        6000
    }

    public fun max_wallet_bps() : u64 {
        300
    }

    public fun min_goal_sui() : u64 {
        10724638000
    }

    public fun min_goal_usdc() : u64 {
        7400000000
    }

    public fun nft_swap_bps() : u64 {
        8000
    }

    public fun nft_type_dynamic() : u8 {
        1
    }

    public fun nft_type_regular() : u8 {
        0
    }

    public fun platform_fee_bps() : u64 {
        500
    }

    public fun platform_treasury(arg0: &GlobalConfig) : address {
        arg0.platform_treasury
    }

    public fun quote_sui() : u8 {
        0
    }

    public fun quote_usdc() : u8 {
        1
    }

    public fun rarity_common() : u8 {
        2
    }

    public fun rarity_mythic() : u8 {
        0
    }

    public fun rarity_rare() : u8 {
        1
    }

    public fun royalty_creator_bps() : u64 {
        100
    }

    public fun royalty_yield_bps() : u64 {
        100
    }

    public fun set_paused(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    public fun set_platform_treasury(arg0: &AdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.platform_treasury = arg2;
    }

    public fun status_funding() : u8 {
        0
    }

    public fun status_live() : u8 {
        1
    }

    public fun takeover_delay_ms() : u64 {
        7776000000
    }

    public fun total_launches(arg0: &GlobalConfig) : u64 {
        arg0.total_launches
    }

    public fun total_supply() : u64 {
        1000000000000000000
    }

    public fun vault_bps() : u64 {
        9000
    }

    public fun vesting_120() : u64 {
        10368000000
    }

    public fun vesting_30() : u64 {
        2592000000
    }

    public fun vesting_7() : u64 {
        604800000
    }

    public fun vesting_90() : u64 {
        7776000000
    }

    // decompiled from Move bytecode v7
}

