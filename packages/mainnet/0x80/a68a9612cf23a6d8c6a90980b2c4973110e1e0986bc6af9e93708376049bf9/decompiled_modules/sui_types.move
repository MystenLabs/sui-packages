module 0x80a68a9612cf23a6d8c6a90980b2c4973110e1e0986bc6af9e93708376049bf9::sui_types {
    struct GraduationTier has copy, drop, store {
        threshold: u64,
        bc_virtual: u64,
        nav_min_mul_bps: u64,
        nav_max_mul_bps: u64,
        squared_ratio_bps: u64,
    }

    struct ExitFeeTier has copy, drop, store {
        days_held: u64,
        fee_bps: u64,
    }

    struct UserPurchaseInfo has copy, drop, store {
        total_tokens: u64,
        weighted_timestamp: u64,
        last_purchase_time: u64,
    }

    struct EntryRecord has copy, drop, store {
        weighted_entry_nav: u64,
        total_tokens: u64,
    }

    struct PendingSell has copy, drop, store {
        usdc_amount: u64,
        fee_amount: u64,
        timestamp: u64,
    }

    struct ApiWalletInfo has copy, drop, store {
        active: bool,
        expires_at: u64,
        name: vector<u8>,
    }

    struct GlobalSettings has copy, drop, store {
        trading_fee_bps: u64,
        max_premium_bps: u64,
        max_discount_bps: u64,
        min_deposit_usdc: u64,
        max_buy_bps: u64,
        rebalance_low_bps: u64,
        rebalance_high_bps: u64,
        reserve_ratio_bps: u64,
        min_reserve_ratio_bps: u64,
        exit_fee_enabled: bool,
        max_bc_ratio_bps: u64,
        bc_virtual_min_bps: u64,
    }

    struct VaultInfo has copy, drop, store {
        leader: address,
        name: vector<u8>,
        symbol: vector<u8>,
        performance_fee_bps: u64,
        created_at: u64,
        verified: bool,
    }

    public fun api_wallet_active(arg0: &ApiWalletInfo) : bool {
        arg0.active
    }

    public fun api_wallet_expires_at(arg0: &ApiWalletInfo) : u64 {
        arg0.expires_at
    }

    public fun api_wallet_name(arg0: &ApiWalletInfo) : vector<u8> {
        arg0.name
    }

    public fun bps() : u64 {
        10000
    }

    public fun default_global_settings() : GlobalSettings {
        GlobalSettings{
            trading_fee_bps       : 100,
            max_premium_bps       : 10000,
            max_discount_bps      : 5000,
            min_deposit_usdc      : 5000000,
            max_buy_bps           : 100,
            rebalance_low_bps     : 4800,
            rebalance_high_bps    : 5200,
            reserve_ratio_bps     : 5000,
            min_reserve_ratio_bps : 3000,
            exit_fee_enabled      : true,
            max_bc_ratio_bps      : 0,
            bc_virtual_min_bps    : 500,
        }
    }

    public fun default_twap_half_life() : u64 {
        600
    }

    public fun e_already_initialized() : u64 {
        16
    }

    public fun e_api_wallet_expired() : u64 {
        13
    }

    public fun e_fee_too_high() : u64 {
        3
    }

    public fun e_insufficient_liquidity() : u64 {
        9
    }

    public fun e_invalid_amount() : u64 {
        4
    }

    public fun e_invalid_duration() : u64 {
        14
    }

    public fun e_invalid_tier() : u64 {
        12
    }

    public fun e_max_buy_exceeded() : u64 {
        11
    }

    public fun e_min_deposit() : u64 {
        10
    }

    public fun e_no_pending_sell() : u64 {
        7
    }

    public fun e_not_admin() : u64 {
        18
    }

    public fun e_not_authorized() : u64 {
        1
    }

    public fun e_not_leader() : u64 {
        17
    }

    public fun e_paused() : u64 {
        2
    }

    public fun e_pending_sell_exists() : u64 {
        6
    }

    public fun e_slippage_exceeded() : u64 {
        5
    }

    public fun e_vault_not_found() : u64 {
        15
    }

    public fun e_zero_tokens() : u64 {
        8
    }

    public fun entry_total_tokens(arg0: &EntryRecord) : u64 {
        arg0.total_tokens
    }

    public fun entry_weighted_nav(arg0: &EntryRecord) : u64 {
        arg0.weighted_entry_nav
    }

    public fun exit_tier_days_held(arg0: &ExitFeeTier) : u64 {
        arg0.days_held
    }

    public fun exit_tier_fee_bps(arg0: &ExitFeeTier) : u64 {
        arg0.fee_bps
    }

    public fun high_precision() : u64 {
        1000000000000
    }

    public fun l1_init_fee() : u64 {
        1000000
    }

    public fun max_api_wallet_duration() : u64 {
        15552000
    }

    public fun max_exit_fee_bps() : u64 {
        5000
    }

    public fun max_performance_fee_bps() : u64 {
        3000
    }

    public fun min_api_wallet_duration() : u64 {
        5184000
    }

    public fun new_api_wallet_info(arg0: bool, arg1: u64, arg2: vector<u8>) : ApiWalletInfo {
        ApiWalletInfo{
            active     : arg0,
            expires_at : arg1,
            name       : arg2,
        }
    }

    public fun new_entry_record(arg0: u64, arg1: u64) : EntryRecord {
        EntryRecord{
            weighted_entry_nav : arg0,
            total_tokens       : arg1,
        }
    }

    public fun new_exit_fee_tier(arg0: u64, arg1: u64) : ExitFeeTier {
        ExitFeeTier{
            days_held : arg0,
            fee_bps   : arg1,
        }
    }

    public fun new_global_settings_with_max_buy(arg0: &GlobalSettings, arg1: u64) : GlobalSettings {
        GlobalSettings{
            trading_fee_bps       : arg0.trading_fee_bps,
            max_premium_bps       : arg0.max_premium_bps,
            max_discount_bps      : arg0.max_discount_bps,
            min_deposit_usdc      : arg0.min_deposit_usdc,
            max_buy_bps           : arg1,
            rebalance_low_bps     : arg0.rebalance_low_bps,
            rebalance_high_bps    : arg0.rebalance_high_bps,
            reserve_ratio_bps     : arg0.reserve_ratio_bps,
            min_reserve_ratio_bps : arg0.min_reserve_ratio_bps,
            exit_fee_enabled      : arg0.exit_fee_enabled,
            max_bc_ratio_bps      : arg0.max_bc_ratio_bps,
            bc_virtual_min_bps    : arg0.bc_virtual_min_bps,
        }
    }

    public fun new_global_settings_with_min_deposit(arg0: &GlobalSettings, arg1: u64) : GlobalSettings {
        GlobalSettings{
            trading_fee_bps       : arg0.trading_fee_bps,
            max_premium_bps       : arg0.max_premium_bps,
            max_discount_bps      : arg0.max_discount_bps,
            min_deposit_usdc      : arg1,
            max_buy_bps           : arg0.max_buy_bps,
            rebalance_low_bps     : arg0.rebalance_low_bps,
            rebalance_high_bps    : arg0.rebalance_high_bps,
            reserve_ratio_bps     : arg0.reserve_ratio_bps,
            min_reserve_ratio_bps : arg0.min_reserve_ratio_bps,
            exit_fee_enabled      : arg0.exit_fee_enabled,
            max_bc_ratio_bps      : arg0.max_bc_ratio_bps,
            bc_virtual_min_bps    : arg0.bc_virtual_min_bps,
        }
    }

    public fun new_global_settings_with_rebalance(arg0: &GlobalSettings, arg1: u64, arg2: u64, arg3: u64) : GlobalSettings {
        GlobalSettings{
            trading_fee_bps       : arg0.trading_fee_bps,
            max_premium_bps       : arg0.max_premium_bps,
            max_discount_bps      : arg0.max_discount_bps,
            min_deposit_usdc      : arg0.min_deposit_usdc,
            max_buy_bps           : arg0.max_buy_bps,
            rebalance_low_bps     : arg1,
            rebalance_high_bps    : arg2,
            reserve_ratio_bps     : arg3,
            min_reserve_ratio_bps : arg0.min_reserve_ratio_bps,
            exit_fee_enabled      : arg0.exit_fee_enabled,
            max_bc_ratio_bps      : arg0.max_bc_ratio_bps,
            bc_virtual_min_bps    : arg0.bc_virtual_min_bps,
        }
    }

    public fun new_global_settings_with_trading_fee(arg0: &GlobalSettings, arg1: u64) : GlobalSettings {
        GlobalSettings{
            trading_fee_bps       : arg1,
            max_premium_bps       : arg0.max_premium_bps,
            max_discount_bps      : arg0.max_discount_bps,
            min_deposit_usdc      : arg0.min_deposit_usdc,
            max_buy_bps           : arg0.max_buy_bps,
            rebalance_low_bps     : arg0.rebalance_low_bps,
            rebalance_high_bps    : arg0.rebalance_high_bps,
            reserve_ratio_bps     : arg0.reserve_ratio_bps,
            min_reserve_ratio_bps : arg0.min_reserve_ratio_bps,
            exit_fee_enabled      : arg0.exit_fee_enabled,
            max_bc_ratio_bps      : arg0.max_bc_ratio_bps,
            bc_virtual_min_bps    : arg0.bc_virtual_min_bps,
        }
    }

    public fun new_graduation_tier(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : GraduationTier {
        GraduationTier{
            threshold         : arg0,
            bc_virtual        : arg1,
            nav_min_mul_bps   : arg2,
            nav_max_mul_bps   : arg3,
            squared_ratio_bps : arg4,
        }
    }

    public fun new_pending_sell(arg0: u64, arg1: u64, arg2: u64) : PendingSell {
        PendingSell{
            usdc_amount : arg0,
            fee_amount  : arg1,
            timestamp   : arg2,
        }
    }

    public fun new_user_purchase_info(arg0: u64, arg1: u64, arg2: u64) : UserPurchaseInfo {
        UserPurchaseInfo{
            total_tokens       : arg0,
            weighted_timestamp : arg1,
            last_purchase_time : arg2,
        }
    }

    public fun new_vault_info(arg0: address, arg1: vector<u8>, arg2: vector<u8>, arg3: u64, arg4: u64, arg5: bool) : VaultInfo {
        VaultInfo{
            leader              : arg0,
            name                : arg1,
            symbol              : arg2,
            performance_fee_bps : arg3,
            created_at          : arg4,
            verified            : arg5,
        }
    }

    public fun precision() : u64 {
        1000000
    }

    public fun ps_fee_amount(arg0: &PendingSell) : u64 {
        arg0.fee_amount
    }

    public fun ps_timestamp(arg0: &PendingSell) : u64 {
        arg0.timestamp
    }

    public fun ps_usdc_amount(arg0: &PendingSell) : u64 {
        arg0.usdc_amount
    }

    public fun purchase_last_time(arg0: &UserPurchaseInfo) : u64 {
        arg0.last_purchase_time
    }

    public fun purchase_total_tokens(arg0: &UserPurchaseInfo) : u64 {
        arg0.total_tokens
    }

    public fun purchase_weighted_timestamp(arg0: &UserPurchaseInfo) : u64 {
        arg0.weighted_timestamp
    }

    public fun reduce_entry_tokens(arg0: &mut EntryRecord, arg1: u64) {
        assert!(arg0.total_tokens >= arg1, 4);
        arg0.total_tokens = arg0.total_tokens - arg1;
    }

    public fun reduce_purchase_tokens(arg0: &mut UserPurchaseInfo, arg1: u64) {
        assert!(arg0.total_tokens >= arg1, 4);
        arg0.total_tokens = arg0.total_tokens - arg1;
    }

    public fun set_api_wallet_active(arg0: &mut ApiWalletInfo, arg1: bool) {
        arg0.active = arg1;
    }

    public fun set_api_wallet_expires(arg0: &mut ApiWalletInfo, arg1: u64) {
        arg0.expires_at = arg1;
    }

    public fun set_vault_verified(arg0: &mut VaultInfo, arg1: bool) {
        arg0.verified = arg1;
    }

    public fun settings_bc_virtual_min_bps(arg0: &GlobalSettings) : u64 {
        arg0.bc_virtual_min_bps
    }

    public fun settings_exit_fee_enabled(arg0: &GlobalSettings) : bool {
        arg0.exit_fee_enabled
    }

    public fun settings_max_bc_ratio_bps(arg0: &GlobalSettings) : u64 {
        arg0.max_bc_ratio_bps
    }

    public fun settings_max_buy_bps(arg0: &GlobalSettings) : u64 {
        arg0.max_buy_bps
    }

    public fun settings_max_discount_bps(arg0: &GlobalSettings) : u64 {
        arg0.max_discount_bps
    }

    public fun settings_max_premium_bps(arg0: &GlobalSettings) : u64 {
        arg0.max_premium_bps
    }

    public fun settings_min_deposit_usdc(arg0: &GlobalSettings) : u64 {
        arg0.min_deposit_usdc
    }

    public fun settings_min_reserve_ratio_bps(arg0: &GlobalSettings) : u64 {
        arg0.min_reserve_ratio_bps
    }

    public fun settings_rebalance_high_bps(arg0: &GlobalSettings) : u64 {
        arg0.rebalance_high_bps
    }

    public fun settings_rebalance_low_bps(arg0: &GlobalSettings) : u64 {
        arg0.rebalance_low_bps
    }

    public fun settings_reserve_ratio_bps(arg0: &GlobalSettings) : u64 {
        arg0.reserve_ratio_bps
    }

    public fun settings_trading_fee_bps(arg0: &GlobalSettings) : u64 {
        arg0.trading_fee_bps
    }

    public fun tier_bc_virtual(arg0: &GraduationTier) : u64 {
        arg0.bc_virtual
    }

    public fun tier_nav_max_mul_bps(arg0: &GraduationTier) : u64 {
        arg0.nav_max_mul_bps
    }

    public fun tier_nav_min_mul_bps(arg0: &GraduationTier) : u64 {
        arg0.nav_min_mul_bps
    }

    public fun tier_squared_ratio_bps(arg0: &GraduationTier) : u64 {
        arg0.squared_ratio_bps
    }

    public fun tier_threshold(arg0: &GraduationTier) : u64 {
        arg0.threshold
    }

    public fun update_entry_record(arg0: &mut EntryRecord, arg1: u64, arg2: u64) {
        let v0 = arg0.total_tokens;
        let v1 = v0 + arg1;
        if (v1 > 0) {
            arg0.weighted_entry_nav = ((((arg0.weighted_entry_nav as u128) * (v0 as u128) + (arg2 as u128) * (arg1 as u128)) / (v1 as u128)) as u64);
        };
        arg0.total_tokens = v1;
    }

    public fun update_purchase_info(arg0: &mut UserPurchaseInfo, arg1: u64, arg2: u64) {
        let v0 = arg0.total_tokens;
        let v1 = v0 + arg1;
        if (v1 > 0) {
            arg0.weighted_timestamp = ((((arg0.weighted_timestamp as u128) * (v0 as u128) + (arg2 as u128) * (arg1 as u128)) / (v1 as u128)) as u64);
        };
        arg0.total_tokens = v1;
        arg0.last_purchase_time = arg2;
    }

    public fun vault_info_created_at(arg0: &VaultInfo) : u64 {
        arg0.created_at
    }

    public fun vault_info_leader(arg0: &VaultInfo) : address {
        arg0.leader
    }

    public fun vault_info_name(arg0: &VaultInfo) : vector<u8> {
        arg0.name
    }

    public fun vault_info_performance_fee_bps(arg0: &VaultInfo) : u64 {
        arg0.performance_fee_bps
    }

    public fun vault_info_symbol(arg0: &VaultInfo) : vector<u8> {
        arg0.symbol
    }

    public fun vault_info_verified(arg0: &VaultInfo) : bool {
        arg0.verified
    }

    // decompiled from Move bytecode v6
}

