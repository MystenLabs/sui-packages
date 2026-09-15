module 0x1914927baefaf7cccfe02f6567b7e24e28d33e3cb153f9628829b818954a0769::events {
    struct PlatformInitialized has copy, drop {
        config_id: 0x2::object::ID,
        admin: address,
    }

    struct ConfigChangeProposed has copy, drop {
        config_id: 0x2::object::ID,
        treasury: address,
        creation_fee_mist: u64,
        creator_lp_fee_share_bps: u64,
        executable_at_ms: u64,
    }

    struct ConfigChangeCancelled has copy, drop {
        config_id: 0x2::object::ID,
    }

    struct ConfigUpdated has copy, drop {
        config_id: 0x2::object::ID,
        treasury: address,
        creation_fee_mist: u64,
        creator_lp_fee_share_bps: u64,
        max_creator_allocation_bps: u64,
        timelock_ms: u64,
    }

    struct QuoteDecisionUpdated has copy, drop {
        config_id: 0x2::object::ID,
        quote_type: 0x1::ascii::String,
        decision: u8,
    }

    struct OpenQuotesUpdated has copy, drop {
        config_id: 0x2::object::ID,
        open: bool,
    }

    struct TickSpacingUpdated has copy, drop {
        config_id: 0x2::object::ID,
        tick_spacing: u32,
        allowed: bool,
    }

    struct LaunchesPaused has copy, drop {
        config_id: 0x2::object::ID,
        paused: bool,
    }

    struct LaunchCreated has copy, drop {
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        creator: address,
        token_type: 0x1::ascii::String,
        quote_type: 0x1::ascii::String,
        token_is_a: bool,
        total_supply: u64,
        supply_policy: u8,
        metadata_cap_deleted: bool,
        treasury_cap_id: 0x2::object::ID,
        creator_allocation: u64,
        vesting_id: 0x1::option::Option<0x2::object::ID>,
        liquidity_tokens: u64,
        initial_market_cap: u64,
        initial_sqrt_price: u128,
        tick_spacing: u32,
        tick_lower: u32,
        tick_upper: u32,
        liquidity: u128,
        creator_lp_fee_share_bps: u64,
        creation_fee_paid: u64,
        dev_buy_quote: u64,
        dev_buy_tokens: u64,
        fee_route: u8,
        timestamp_ms: u64,
    }

    struct CurrencyVerified has copy, drop {
        launch_id: 0x2::object::ID,
        regulated: bool,
    }

    struct LpFeesCollected has copy, drop {
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        creator: address,
        creator_amount_a: u64,
        creator_amount_b: u64,
        platform_amount_a: u64,
        platform_amount_b: u64,
        timestamp_ms: u64,
    }

    struct FeeRecipientChanged has copy, drop {
        launch_id: 0x2::object::ID,
        recipient: address,
    }

    struct FeeRouteChanged has copy, drop {
        launch_id: 0x2::object::ID,
        route: u8,
    }

    struct FeesBurned has copy, drop {
        launch_id: 0x2::object::ID,
        amount: u64,
        total_burned: u64,
    }

    struct BoughtBack has copy, drop {
        launch_id: 0x2::object::ID,
        spent: u64,
        bought: u64,
    }

    struct RewardsAccrued has copy, drop {
        launch_id: 0x2::object::ID,
        amount: u64,
        balance: u64,
    }

    struct RewardRoundStarted has copy, drop {
        round_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        index: u64,
        root: vector<u8>,
        total: u64,
        holders: u64,
        snapshot_ms: u64,
        claim_end_ms: u64,
    }

    struct RewardClaimed has copy, drop {
        round_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        wallet: address,
        amount: u64,
    }

    struct RewardRoundClosed has copy, drop {
        round_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        returned: u64,
    }

    struct VestingCreated has copy, drop {
        vesting_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        start_ms: u64,
        cliff_ms: u64,
        duration_ms: u64,
    }

    struct VestingClaimed has copy, drop {
        vesting_id: 0x2::object::ID,
        beneficiary: address,
        amount: u64,
        total_claimed: u64,
    }

    struct FeesHeld has copy, drop {
        launch_id: 0x2::object::ID,
        creator_amount: u64,
        platform_amount: u64,
        creator_held: u64,
        platform_held: u64,
    }

    struct HeldFeesConverted has copy, drop {
        launch_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        sold: u64,
        creator_sold: u64,
        received: u64,
        creator_received: u64,
        fee_recipient: address,
        creator_held: u64,
        platform_held: u64,
    }

    struct HeldFeesClaimed has copy, drop {
        launch_id: 0x2::object::ID,
        recipient: address,
        amount: u64,
    }

    struct FeeSellerChanged has copy, drop {
        config_id: 0x2::object::ID,
        cap_id: 0x1::option::Option<0x2::object::ID>,
    }

    struct RevenueDeposited has copy, drop {
        vault_id: 0x2::object::ID,
        coin_type: 0x1::ascii::String,
        amount: u64,
    }

    struct RevenueSwapped has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        from_type: 0x1::ascii::String,
        to_type: 0x1::ascii::String,
        spent: u64,
        received: u64,
    }

    struct ProtocolBuyback has copy, drop {
        vault_id: 0x2::object::ID,
        launch_id: 0x2::object::ID,
        spent: u64,
        bought: u64,
        burned: u64,
        total_burned: u64,
    }

    struct BuybackConfigUpdated has copy, drop {
        vault_id: 0x2::object::ID,
        buyback_bps: u64,
        protocol_launch: 0x1::option::Option<0x2::object::ID>,
    }

    struct RevenuePoolAllowed has copy, drop {
        vault_id: 0x2::object::ID,
        pool_id: 0x2::object::ID,
        allowed: bool,
    }

    public(friend) fun emit_bought_back(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = BoughtBack{
            launch_id : arg0,
            spent     : arg1,
            bought    : arg2,
        };
        0x2::event::emit<BoughtBack>(v0);
    }

    public(friend) fun emit_buyback_config_updated(arg0: 0x2::object::ID, arg1: u64, arg2: 0x1::option::Option<0x2::object::ID>) {
        let v0 = BuybackConfigUpdated{
            vault_id        : arg0,
            buyback_bps     : arg1,
            protocol_launch : arg2,
        };
        0x2::event::emit<BuybackConfigUpdated>(v0);
    }

    public(friend) fun emit_config_change_cancelled(arg0: 0x2::object::ID) {
        let v0 = ConfigChangeCancelled{config_id: arg0};
        0x2::event::emit<ConfigChangeCancelled>(v0);
    }

    public(friend) fun emit_config_change_proposed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = ConfigChangeProposed{
            config_id                : arg0,
            treasury                 : arg1,
            creation_fee_mist        : arg2,
            creator_lp_fee_share_bps : arg3,
            executable_at_ms         : arg4,
        };
        0x2::event::emit<ConfigChangeProposed>(v0);
    }

    public(friend) fun emit_config_updated(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ConfigUpdated{
            config_id                  : arg0,
            treasury                   : arg1,
            creation_fee_mist          : arg2,
            creator_lp_fee_share_bps   : arg3,
            max_creator_allocation_bps : arg4,
            timelock_ms                : arg5,
        };
        0x2::event::emit<ConfigUpdated>(v0);
    }

    public(friend) fun emit_currency_verified(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = CurrencyVerified{
            launch_id : arg0,
            regulated : arg1,
        };
        0x2::event::emit<CurrencyVerified>(v0);
    }

    public(friend) fun emit_fee_recipient_changed(arg0: 0x2::object::ID, arg1: address) {
        let v0 = FeeRecipientChanged{
            launch_id : arg0,
            recipient : arg1,
        };
        0x2::event::emit<FeeRecipientChanged>(v0);
    }

    public(friend) fun emit_fee_route_changed(arg0: 0x2::object::ID, arg1: u8) {
        let v0 = FeeRouteChanged{
            launch_id : arg0,
            route     : arg1,
        };
        0x2::event::emit<FeeRouteChanged>(v0);
    }

    public(friend) fun emit_fee_seller_changed(arg0: 0x2::object::ID, arg1: 0x1::option::Option<0x2::object::ID>) {
        let v0 = FeeSellerChanged{
            config_id : arg0,
            cap_id    : arg1,
        };
        0x2::event::emit<FeeSellerChanged>(v0);
    }

    public(friend) fun emit_fees_burned(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = FeesBurned{
            launch_id    : arg0,
            amount       : arg1,
            total_burned : arg2,
        };
        0x2::event::emit<FeesBurned>(v0);
    }

    public(friend) fun emit_fees_held(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = FeesHeld{
            launch_id       : arg0,
            creator_amount  : arg1,
            platform_amount : arg2,
            creator_held    : arg3,
            platform_held   : arg4,
        };
        0x2::event::emit<FeesHeld>(v0);
    }

    public(friend) fun emit_held_fees_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64) {
        let v0 = HeldFeesClaimed{
            launch_id : arg0,
            recipient : arg1,
            amount    : arg2,
        };
        0x2::event::emit<HeldFeesClaimed>(v0);
    }

    public(friend) fun emit_held_fees_converted(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: address, arg7: u64, arg8: u64) {
        let v0 = HeldFeesConverted{
            launch_id        : arg0,
            pool_id          : arg1,
            sold             : arg2,
            creator_sold     : arg3,
            received         : arg4,
            creator_received : arg5,
            fee_recipient    : arg6,
            creator_held     : arg7,
            platform_held    : arg8,
        };
        0x2::event::emit<HeldFeesConverted>(v0);
    }

    public(friend) fun emit_launch_created(arg0: LaunchCreated) {
        0x2::event::emit<LaunchCreated>(arg0);
    }

    public(friend) fun emit_launches_paused(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = LaunchesPaused{
            config_id : arg0,
            paused    : arg1,
        };
        0x2::event::emit<LaunchesPaused>(v0);
    }

    public(friend) fun emit_lp_fees_collected(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = LpFeesCollected{
            launch_id         : arg0,
            pool_id           : arg1,
            creator           : arg2,
            creator_amount_a  : arg3,
            creator_amount_b  : arg4,
            platform_amount_a : arg5,
            platform_amount_b : arg6,
            timestamp_ms      : arg7,
        };
        0x2::event::emit<LpFeesCollected>(v0);
    }

    public(friend) fun emit_open_quotes_updated(arg0: 0x2::object::ID, arg1: bool) {
        let v0 = OpenQuotesUpdated{
            config_id : arg0,
            open      : arg1,
        };
        0x2::event::emit<OpenQuotesUpdated>(v0);
    }

    public(friend) fun emit_platform_initialized(arg0: 0x2::object::ID, arg1: address) {
        let v0 = PlatformInitialized{
            config_id : arg0,
            admin     : arg1,
        };
        0x2::event::emit<PlatformInitialized>(v0);
    }

    public(friend) fun emit_protocol_buyback(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = ProtocolBuyback{
            vault_id     : arg0,
            launch_id    : arg1,
            spent        : arg2,
            bought       : arg3,
            burned       : arg4,
            total_burned : arg5,
        };
        0x2::event::emit<ProtocolBuyback>(v0);
    }

    public(friend) fun emit_quote_decision_updated(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u8) {
        let v0 = QuoteDecisionUpdated{
            config_id  : arg0,
            quote_type : arg1,
            decision   : arg2,
        };
        0x2::event::emit<QuoteDecisionUpdated>(v0);
    }

    public(friend) fun emit_revenue_deposited(arg0: 0x2::object::ID, arg1: 0x1::ascii::String, arg2: u64) {
        let v0 = RevenueDeposited{
            vault_id  : arg0,
            coin_type : arg1,
            amount    : arg2,
        };
        0x2::event::emit<RevenueDeposited>(v0);
    }

    public(friend) fun emit_revenue_pool_allowed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: bool) {
        let v0 = RevenuePoolAllowed{
            vault_id : arg0,
            pool_id  : arg1,
            allowed  : arg2,
        };
        0x2::event::emit<RevenuePoolAllowed>(v0);
    }

    public(friend) fun emit_revenue_swapped(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: 0x1::ascii::String, arg3: 0x1::ascii::String, arg4: u64, arg5: u64) {
        let v0 = RevenueSwapped{
            vault_id  : arg0,
            pool_id   : arg1,
            from_type : arg2,
            to_type   : arg3,
            spent     : arg4,
            received  : arg5,
        };
        0x2::event::emit<RevenueSwapped>(v0);
    }

    public(friend) fun emit_reward_claimed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64) {
        let v0 = RewardClaimed{
            round_id  : arg0,
            launch_id : arg1,
            wallet    : arg2,
            amount    : arg3,
        };
        0x2::event::emit<RewardClaimed>(v0);
    }

    public(friend) fun emit_reward_round_closed(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64) {
        let v0 = RewardRoundClosed{
            round_id  : arg0,
            launch_id : arg1,
            returned  : arg2,
        };
        0x2::event::emit<RewardRoundClosed>(v0);
    }

    public(friend) fun emit_reward_round_started(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: u64, arg3: vector<u8>, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = RewardRoundStarted{
            round_id     : arg0,
            launch_id    : arg1,
            index        : arg2,
            root         : arg3,
            total        : arg4,
            holders      : arg5,
            snapshot_ms  : arg6,
            claim_end_ms : arg7,
        };
        0x2::event::emit<RewardRoundStarted>(v0);
    }

    public(friend) fun emit_rewards_accrued(arg0: 0x2::object::ID, arg1: u64, arg2: u64) {
        let v0 = RewardsAccrued{
            launch_id : arg0,
            amount    : arg1,
            balance   : arg2,
        };
        0x2::event::emit<RewardsAccrued>(v0);
    }

    public(friend) fun emit_tick_spacing_updated(arg0: 0x2::object::ID, arg1: u32, arg2: bool) {
        let v0 = TickSpacingUpdated{
            config_id    : arg0,
            tick_spacing : arg1,
            allowed      : arg2,
        };
        0x2::event::emit<TickSpacingUpdated>(v0);
    }

    public(friend) fun emit_vesting_claimed(arg0: 0x2::object::ID, arg1: address, arg2: u64, arg3: u64) {
        let v0 = VestingClaimed{
            vesting_id    : arg0,
            beneficiary   : arg1,
            amount        : arg2,
            total_claimed : arg3,
        };
        0x2::event::emit<VestingClaimed>(v0);
    }

    public(friend) fun emit_vesting_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = VestingCreated{
            vesting_id  : arg0,
            launch_id   : arg1,
            beneficiary : arg2,
            amount      : arg3,
            start_ms    : arg4,
            cliff_ms    : arg5,
            duration_ms : arg6,
        };
        0x2::event::emit<VestingCreated>(v0);
    }

    public(friend) fun new_launch_created(arg0: 0x2::object::ID, arg1: 0x2::object::ID, arg2: address, arg3: 0x1::ascii::String, arg4: 0x1::ascii::String, arg5: bool, arg6: u64, arg7: u8, arg8: bool, arg9: 0x2::object::ID, arg10: u64, arg11: 0x1::option::Option<0x2::object::ID>, arg12: u64, arg13: u64, arg14: u128, arg15: u32, arg16: u32, arg17: u32, arg18: u128, arg19: u64, arg20: u64, arg21: u64, arg22: u64, arg23: u8, arg24: u64) : LaunchCreated {
        LaunchCreated{
            launch_id                : arg0,
            pool_id                  : arg1,
            creator                  : arg2,
            token_type               : arg3,
            quote_type               : arg4,
            token_is_a               : arg5,
            total_supply             : arg6,
            supply_policy            : arg7,
            metadata_cap_deleted     : arg8,
            treasury_cap_id          : arg9,
            creator_allocation       : arg10,
            vesting_id               : arg11,
            liquidity_tokens         : arg12,
            initial_market_cap       : arg13,
            initial_sqrt_price       : arg14,
            tick_spacing             : arg15,
            tick_lower               : arg16,
            tick_upper               : arg17,
            liquidity                : arg18,
            creator_lp_fee_share_bps : arg19,
            creation_fee_paid        : arg20,
            dev_buy_quote            : arg21,
            dev_buy_tokens           : arg22,
            fee_route                : arg23,
            timestamp_ms             : arg24,
        }
    }

    // decompiled from Move bytecode v7
}

