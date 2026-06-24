module 0x638ff555793e8b2cc535c5ed56627bf93e9a2cdb961932a2f4ead23c9d83f138::config {
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

    public fun get_id(arg0: &GlobalConfig) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_platform_treasury(arg0: &GlobalConfig) : address {
        arg0.platform_treasury
    }

    public fun get_total_launches(arg0: &GlobalConfig) : u64 {
        arg0.total_launches
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

    public fun max_supply() : u64 {
        10000
    }

    public fun min_goal_sui() : u64 {
        18787000000000
    }

    public fun min_goal_usdc() : u64 {
        12963000000
    }

    public fun min_mint_price_mist() : u64 {
        2000000000
    }

    public fun nft_swap_bps() : u64 {
        8000
    }

    public fun platform_fee_bps() : u64 {
        500
    }

    public fun platform_treasury_addr() : address {
        @0x72fb6101d12f0c4f35374b50d939f836f2878e695bb559679c823a9ae7fc25d5
    }

    public fun pool_split_bps() : u64 {
        6000
    }

    public fun quote_coin_sui() : u8 {
        0
    }

    public fun quote_coin_usdc() : u8 {
        1
    }

    public fun set_paused(arg0: &mut GlobalConfig, arg1: bool) {
        arg0.paused = arg1;
    }

    public fun set_platform_treasury(arg0: &mut GlobalConfig, arg1: address) {
        arg0.platform_treasury = arg1;
    }

    public fun status_awakened() : u8 {
        1
    }

    public fun status_evolved() : u8 {
        3
    }

    public fun status_genesis() : u8 {
        0
    }

    public fun status_legendary() : u8 {
        4
    }

    public fun status_vesting() : u8 {
        2
    }

    public fun token_split_bps() : u64 {
        4000
    }

    public fun total_supply() : u64 {
        1000000000000000000
    }

    public fun vault_bps() : u64 {
        9000
    }

    // decompiled from Move bytecode v7
}

