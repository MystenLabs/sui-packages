module 0x83a3afdf23a18e024abdbdbd10dc5b1caad415d412ec94e169b8545b421966f4::suilend_admin {
    struct MarketMigrated<phantom T0> has copy, drop {
        lending_market_id: address,
        from_version: u64,
        version: u64,
    }

    struct ReserveAdded<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        coin_type: 0x1::type_name::TypeName,
        price_identifier: vector<u8>,
        config_bcs: vector<u8>,
        confidence_multiplier_bps: u64,
        min_confidence_ratio: u64,
        max_staleness_seconds: u64,
    }

    struct ReserveConfigUpdated<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        config_bcs: vector<u8>,
        confidence_multiplier_bps: u64,
        min_confidence_ratio: u64,
        max_staleness_seconds: u64,
    }

    struct ReservePriceGuardSet<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        max_price_change_bps: u64,
        min_update_interval_s: u64,
    }

    struct ReservePriceFeedChanged<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        price_identifier: vector<u8>,
    }

    struct PoolRewardAdded<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        is_deposit_reward: bool,
        reward_index: u64,
        pool_reward_id: address,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
        start_time_ms: u64,
        end_time_ms: u64,
    }

    struct PoolRewardCancelled<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        is_deposit_reward: bool,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PoolRewardClosed<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        is_deposit_reward: bool,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct PointsRewardDrained<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        is_deposit_reward: bool,
        reward_index: u64,
        coin_type: 0x1::type_name::TypeName,
        amount: u64,
    }

    struct StakerInitialized<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        staker_type: 0x1::type_name::TypeName,
    }

    struct StakerValidatorSet<phantom T0> has copy, drop {
        lending_market_id: address,
        reserve_id: address,
        validator: address,
    }

    struct RateLimiterConfigUpdated<phantom T0> has copy, drop {
        lending_market_id: address,
        window_duration: u64,
        max_outflow: u64,
    }

    struct FeeReceiversSet<phantom T0> has copy, drop {
        lending_market_id: address,
        receivers: vector<address>,
        weights: vector<u64>,
    }

    struct ObligationOwnerCapMinted<phantom T0> has copy, drop {
        lending_market_id: address,
        obligation_id: address,
        cap_id: address,
    }

    public fun emit_fee_receivers_set<T0: drop>(arg0: T0, arg1: address, arg2: vector<address>, arg3: vector<u64>) {
        let v0 = FeeReceiversSet<T0>{
            lending_market_id : arg1,
            receivers         : arg2,
            weights           : arg3,
        };
        0x2::event::emit<FeeReceiversSet<T0>>(v0);
    }

    public fun emit_market_migrated<T0: drop>(arg0: T0, arg1: address, arg2: u64, arg3: u64) {
        let v0 = MarketMigrated<T0>{
            lending_market_id : arg1,
            from_version      : arg2,
            version           : arg3,
        };
        0x2::event::emit<MarketMigrated<T0>>(v0);
    }

    public fun emit_obligation_owner_cap_minted<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: address) {
        let v0 = ObligationOwnerCapMinted<T0>{
            lending_market_id : arg1,
            obligation_id     : arg2,
            cap_id            : arg3,
        };
        0x2::event::emit<ObligationOwnerCapMinted<T0>>(v0);
    }

    public fun emit_points_reward_drained<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: bool, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: u64) {
        let v0 = PointsRewardDrained<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            is_deposit_reward : arg3,
            reward_index      : arg4,
            coin_type         : arg5,
            amount            : arg6,
        };
        0x2::event::emit<PointsRewardDrained<T0>>(v0);
    }

    public fun emit_pool_reward_added<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: bool, arg4: u64, arg5: address, arg6: 0x1::type_name::TypeName, arg7: u64, arg8: u64, arg9: u64) {
        let v0 = PoolRewardAdded<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            is_deposit_reward : arg3,
            reward_index      : arg4,
            pool_reward_id    : arg5,
            coin_type         : arg6,
            amount            : arg7,
            start_time_ms     : arg8,
            end_time_ms       : arg9,
        };
        0x2::event::emit<PoolRewardAdded<T0>>(v0);
    }

    public fun emit_pool_reward_cancelled<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: bool, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: u64) {
        let v0 = PoolRewardCancelled<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            is_deposit_reward : arg3,
            reward_index      : arg4,
            coin_type         : arg5,
            amount            : arg6,
        };
        0x2::event::emit<PoolRewardCancelled<T0>>(v0);
    }

    public fun emit_pool_reward_closed<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: bool, arg4: u64, arg5: 0x1::type_name::TypeName, arg6: u64) {
        let v0 = PoolRewardClosed<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            is_deposit_reward : arg3,
            reward_index      : arg4,
            coin_type         : arg5,
            amount            : arg6,
        };
        0x2::event::emit<PoolRewardClosed<T0>>(v0);
    }

    public fun emit_rate_limiter_config_updated<T0: drop>(arg0: T0, arg1: address, arg2: u64, arg3: u64) {
        let v0 = RateLimiterConfigUpdated<T0>{
            lending_market_id : arg1,
            window_duration   : arg2,
            max_outflow       : arg3,
        };
        0x2::event::emit<RateLimiterConfigUpdated<T0>>(v0);
    }

    public fun emit_reserve_added<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: 0x1::type_name::TypeName, arg4: vector<u8>, arg5: vector<u8>, arg6: u64, arg7: u64, arg8: u64) {
        let v0 = ReserveAdded<T0>{
            lending_market_id         : arg1,
            reserve_id                : arg2,
            coin_type                 : arg3,
            price_identifier          : arg4,
            config_bcs                : arg5,
            confidence_multiplier_bps : arg6,
            min_confidence_ratio      : arg7,
            max_staleness_seconds     : arg8,
        };
        0x2::event::emit<ReserveAdded<T0>>(v0);
    }

    public fun emit_reserve_config_updated<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = ReserveConfigUpdated<T0>{
            lending_market_id         : arg1,
            reserve_id                : arg2,
            config_bcs                : arg3,
            confidence_multiplier_bps : arg4,
            min_confidence_ratio      : arg5,
            max_staleness_seconds     : arg6,
        };
        0x2::event::emit<ReserveConfigUpdated<T0>>(v0);
    }

    public fun emit_reserve_price_feed_changed<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: vector<u8>) {
        let v0 = ReservePriceFeedChanged<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            price_identifier  : arg3,
        };
        0x2::event::emit<ReservePriceFeedChanged<T0>>(v0);
    }

    public fun emit_reserve_price_guard_set<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: u64, arg4: u64) {
        let v0 = ReservePriceGuardSet<T0>{
            lending_market_id     : arg1,
            reserve_id            : arg2,
            max_price_change_bps  : arg3,
            min_update_interval_s : arg4,
        };
        0x2::event::emit<ReservePriceGuardSet<T0>>(v0);
    }

    public fun emit_staker_initialized<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: 0x1::type_name::TypeName) {
        let v0 = StakerInitialized<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            staker_type       : arg3,
        };
        0x2::event::emit<StakerInitialized<T0>>(v0);
    }

    public fun emit_staker_validator_set<T0: drop>(arg0: T0, arg1: address, arg2: address, arg3: address) {
        let v0 = StakerValidatorSet<T0>{
            lending_market_id : arg1,
            reserve_id        : arg2,
            validator         : arg3,
        };
        0x2::event::emit<StakerValidatorSet<T0>>(v0);
    }

    // decompiled from Move bytecode v7
}

