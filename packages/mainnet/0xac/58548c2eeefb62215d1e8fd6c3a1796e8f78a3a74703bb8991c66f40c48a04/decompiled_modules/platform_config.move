module 0xac58548c2eeefb62215d1e8fd6c3a1796e8f78a3a74703bb8991c66f40c48a04::platform_config {
    struct PlatformConfig has key {
        id: 0x2::object::UID,
        treasury_address: address,
        lp_recipient_address: address,
        lp_bot_address: address,
        creation_is_paused: bool,
        first_buyer_fee_mist: u64,
        default_platform_fee_bps: u64,
        default_creator_fee_bps: u64,
        graduation_reward_sui: u64,
        default_m_num: u64,
        default_m_den: u128,
        default_base_price_mist: u64,
        default_graduation_target_mist: u64,
        platform_cut_bps_on_graduation: u64,
        creator_graduation_payout_mist: u64,
        default_cetus_bump_bps: u64,
        team_allocation_tokens: u64,
        ticker_max_lock_ms: u64,
        ticker_early_reuse_base_fee_mist: u64,
        ticker_early_reuse_max_fee_mist: u64,
        cetus_global_config_id: address,
        cetus_burn_manager_id: address,
        referral_fee_bps: u64,
    }

    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct PLATFORM_CONFIG has drop {
        dummy_field: bool,
    }

    public fun get_cetus_burn_manager_id(arg0: &PlatformConfig) : address {
        arg0.cetus_burn_manager_id
    }

    public fun get_cetus_global_config_id(arg0: &PlatformConfig) : address {
        arg0.cetus_global_config_id
    }

    public fun get_creation_is_paused(arg0: &PlatformConfig) : bool {
        arg0.creation_is_paused
    }

    public fun get_creator_graduation_payout_mist(arg0: &PlatformConfig) : u64 {
        arg0.creator_graduation_payout_mist
    }

    public fun get_default_base_price_mist(arg0: &PlatformConfig) : u64 {
        arg0.default_base_price_mist
    }

    public fun get_default_cetus_bump_bps(arg0: &PlatformConfig) : u64 {
        arg0.default_cetus_bump_bps
    }

    public fun get_default_creator_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.default_creator_fee_bps
    }

    public fun get_default_graduation_target_mist(arg0: &PlatformConfig) : u64 {
        arg0.default_graduation_target_mist
    }

    public fun get_default_m_den(arg0: &PlatformConfig) : u128 {
        arg0.default_m_den
    }

    public fun get_default_m_num(arg0: &PlatformConfig) : u64 {
        arg0.default_m_num
    }

    public fun get_default_platform_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.default_platform_fee_bps
    }

    public fun get_first_buyer_fee_mist(arg0: &PlatformConfig) : u64 {
        arg0.first_buyer_fee_mist
    }

    public fun get_graduation_reward_sui(arg0: &PlatformConfig) : u64 {
        arg0.graduation_reward_sui
    }

    public fun get_lp_bot_address(arg0: &PlatformConfig) : address {
        arg0.lp_bot_address
    }

    public fun get_lp_recipient_address(arg0: &PlatformConfig) : address {
        arg0.lp_recipient_address
    }

    public fun get_platform_cut_bps_on_graduation(arg0: &PlatformConfig) : u64 {
        arg0.platform_cut_bps_on_graduation
    }

    public fun get_referral_fee_bps(arg0: &PlatformConfig) : u64 {
        arg0.referral_fee_bps
    }

    public fun get_team_allocation_tokens(arg0: &PlatformConfig) : u64 {
        arg0.team_allocation_tokens
    }

    public fun get_ticker_early_reuse_base_fee_mist(arg0: &PlatformConfig) : u64 {
        arg0.ticker_early_reuse_base_fee_mist
    }

    public fun get_ticker_early_reuse_max_fee_mist(arg0: &PlatformConfig) : u64 {
        arg0.ticker_early_reuse_max_fee_mist
    }

    public fun get_ticker_max_lock_ms(arg0: &PlatformConfig) : u64 {
        arg0.ticker_max_lock_ms
    }

    public fun get_treasury_address(arg0: &PlatformConfig) : address {
        arg0.treasury_address
    }

    fun init(arg0: PLATFORM_CONFIG, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg1)};
        let v1 = PlatformConfig{
            id                               : 0x2::object::new(arg1),
            treasury_address                 : 0x2::tx_context::sender(arg1),
            lp_recipient_address             : 0x2::tx_context::sender(arg1),
            lp_bot_address                   : 0x2::tx_context::sender(arg1),
            creation_is_paused               : false,
            first_buyer_fee_mist             : 1000000000,
            default_platform_fee_bps         : 250,
            default_creator_fee_bps          : 50,
            graduation_reward_sui            : 100000000000,
            default_m_num                    : 1,
            default_m_den                    : 10593721631205,
            default_base_price_mist          : 1000,
            default_graduation_target_mist   : 13333000000000,
            platform_cut_bps_on_graduation   : 1000,
            creator_graduation_payout_mist   : 40000000000,
            default_cetus_bump_bps           : 1000,
            team_allocation_tokens           : 2000000,
            ticker_max_lock_ms               : 604800000,
            ticker_early_reuse_base_fee_mist : 33000000000,
            ticker_early_reuse_max_fee_mist  : 666000000000,
            cetus_global_config_id           : @0x9774e359588ead122af1c7e7f64e14ade261cfeecdb5d0eb4a5b3b4c8ab8bd3e,
            cetus_burn_manager_id            : @0x0,
            referral_fee_bps                 : 10,
        };
        0x2::transfer::share_object<PlatformConfig>(v1);
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg1));
    }

    public entry fun pause_creation(arg0: &AdminCap, arg1: &mut PlatformConfig) {
        arg1.creation_is_paused = true;
    }

    public entry fun resume_creation(arg0: &AdminCap, arg1: &mut PlatformConfig) {
        arg1.creation_is_paused = false;
    }

    public entry fun set_cetus_burn_manager_id(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        arg1.cetus_burn_manager_id = arg2;
    }

    public entry fun set_cetus_global_config_id(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        arg1.cetus_global_config_id = arg2;
    }

    public entry fun set_creator_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.default_creator_fee_bps = arg2;
    }

    public entry fun set_creator_graduation_payout(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.creator_graduation_payout_mist = arg2;
    }

    public entry fun set_default_cetus_bump_bps(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert!(arg2 <= 10000, 1004);
        arg1.default_cetus_bump_bps = arg2;
    }

    public entry fun set_default_m(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64, arg3: u128) {
        assert!(arg3 > 0, 1001);
        assert!(arg2 > 0, 1002);
        arg1.default_m_num = arg2;
        arg1.default_m_den = arg3;
    }

    public entry fun set_first_buyer_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.first_buyer_fee_mist = arg2;
    }

    public entry fun set_graduation_reward(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.graduation_reward_sui = arg2;
    }

    public entry fun set_lp_bot_address(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        arg1.lp_bot_address = arg2;
    }

    public entry fun set_lp_recipient_address(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        arg1.lp_recipient_address = arg2;
    }

    public entry fun set_platform_cut_on_graduation(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert!(arg2 <= 10000, 1003);
        arg1.platform_cut_bps_on_graduation = arg2;
    }

    public entry fun set_platform_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.default_platform_fee_bps = arg2;
    }

    public entry fun set_referral_fee_bps(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        assert!(arg2 <= 10000, 1005);
        arg1.referral_fee_bps = arg2;
    }

    public entry fun set_team_allocation(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.team_allocation_tokens = arg2;
    }

    public entry fun set_ticker_early_reuse_base_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.ticker_early_reuse_base_fee_mist = arg2;
    }

    public entry fun set_ticker_early_reuse_max_fee(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.ticker_early_reuse_max_fee_mist = arg2;
    }

    public entry fun set_ticker_max_lock_ms(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: u64) {
        arg1.ticker_max_lock_ms = arg2;
    }

    public entry fun set_treasury_address(arg0: &AdminCap, arg1: &mut PlatformConfig, arg2: address) {
        arg1.treasury_address = arg2;
    }

    // decompiled from Move bytecode v6
}

