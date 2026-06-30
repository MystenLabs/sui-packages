module 0x7dcf92bed26dcef98a3909fef2391ac8f984a5925723471af23e51f512178a1f::config {
    struct SuiArtAdminCap has store, key {
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

    public fun creator_lp_share_bps() : u64 {
        3750
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

    public fun holder_lp_share_bps() : u64 {
        6250
    }

    public(friend) fun increment_launches(arg0: &mut GlobalConfig) {
        arg0.total_launches = arg0.total_launches + 1;
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        assert!(3750 + 6250 <= 10000, 0);
        let v0 = SuiArtAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<SuiArtAdminCap>(v0, 0x2::tx_context::sender(arg0));
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

    public fun max_wallet_bps() : u64 {
        300
    }

    public fun min_goal_sui() : u64 {
        0
    }

    public fun min_goal_usdc() : u64 {
        0
    }

    public fun min_mint_price_mist() : u64 {
        100000000
    }

    public fun platform_fee_bps() : u64 {
        500
    }

    public fun platform_treasury_addr() : address {
        @0x72fb6101d12f0c4f35374b50d939f836f2878e695bb559679c823a9ae7fc25d5
    }

    public fun quote_coin_sui() : u8 {
        0
    }

    public fun quote_coin_usdc() : u8 {
        1
    }

    entry fun set_paused(arg0: &SuiArtAdminCap, arg1: &mut GlobalConfig, arg2: bool) {
        arg1.paused = arg2;
    }

    entry fun set_platform_treasury(arg0: &SuiArtAdminCap, arg1: &mut GlobalConfig, arg2: address) {
        arg1.platform_treasury = arg2;
    }

    public fun token_split_bps() : u64 {
        4000
    }

    public fun total_supply() : u64 {
        1000000000000000000
    }

    // decompiled from Move bytecode v7
}

