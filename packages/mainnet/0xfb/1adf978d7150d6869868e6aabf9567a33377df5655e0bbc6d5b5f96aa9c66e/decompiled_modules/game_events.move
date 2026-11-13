module 0xde3c36d56dab5b3f030dd39e4210d5db14a4858858825a5cded1707cf8aaea3::game_events {
    struct Event<T0: copy + drop> has copy, drop {
        pos0: T0,
    }

    struct RewardMintedEventV1 has copy, drop {
        who: address,
        amount: u64,
        source: u8,
    }

    struct XpGrantedEventV1 has copy, drop {
        who: address,
        amount: u64,
        source: u8,
        all_time: u64,
        season_xp: u64,
        season_id: u64,
    }

    struct TierUpEventV1 has copy, drop {
        who: address,
        from_tier: u8,
        to_tier: u8,
    }

    struct DailyClaimedEventV1 has copy, drop {
        who: address,
        streak: u64,
        amount: u64,
        day: u64,
    }

    struct WinStreakUpdatedEventV1 has copy, drop {
        who: address,
        streak: u64,
    }

    struct AchievementUnlockedEventV1 has copy, drop {
        who: address,
        id: u8,
    }

    struct QuestCompletedEventV1 has copy, drop {
        who: address,
        id: u8,
        xp: u64,
        money: u64,
    }

    struct CosmeticUnlockedEventV1 has copy, drop {
        who: address,
        id: u8,
    }

    struct CrateGrantedEventV1 has copy, drop {
        who: address,
        count: u64,
        unopened: u64,
    }

    struct GameRewardIssuedEventV1 has copy, drop {
        who: address,
        amount: u64,
        day: u64,
        pending: u128,
    }

    struct CrateOpenedEventV1 has copy, drop {
        who: address,
        kind: u8,
        amount: u64,
        cosmetic: u8,
        xp: u64,
        season_xp: u64,
        season_id: u64,
    }

    struct FeeCreditUpdatedEventV1 has copy, drop {
        who: address,
        fee_credit: u64,
        fee_credit_used: u64,
    }

    struct CloseXpEventV1 has copy, drop {
        who: address,
        position_id: u64,
        market_id: 0x2::object::ID,
        volume_basis: u64,
        held_ms: u64,
        wash: bool,
        genuine: bool,
        game_paused: bool,
    }

    struct CountersUpdatedEvent has copy, drop {
        player: address,
        account: 0x1::option::Option<0x2::object::ID>,
        kinds: vector<u8>,
        values: vector<u64>,
    }

    struct ProgressionParamsUpdatedEventV1 has copy, drop {
        fee_xp_per_usdc: u64,
        volume_band_full: u64,
        volume_band_end: u64,
        volume_xp_unit: u64,
        volume_xp_unit_reduced: u64,
        volume_market_day_xp_cap: u64,
        volume_day_xp_cap: u64,
        win_min_profit: u64,
        win_day_xp_cap: u64,
        xp_min_hold_ms: u64,
        crates_per_level: u64,
        xp_per_crate: u64,
    }

    struct LevelCratesGrantedEventV1 has copy, drop {
        who: address,
        from_level: u64,
        to_level: u64,
        count: u64,
        unopened: u64,
    }

    struct SetPayoutCapParamsEventV1 has copy, drop {
        config_id: 0x2::object::ID,
        enabled: bool,
        leverages: vector<u64>,
        multiples_bps: vector<u64>,
        pool_share_bps: u64,
        side_budget_bps: u64,
    }

    struct SetPayoutCapEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        position_id: u64,
        account_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        is_long: bool,
        leverage: u64,
        margin: u64,
        multiple_bps: u64,
        cap: u64,
        pool_cash: u64,
        side_committed: u128,
        side_budget: u128,
    }

    struct HitPayoutCapEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        position_id: u64,
        account_id: 0x2::object::ID,
        market_id: 0x2::object::ID,
        uncapped: u64,
        paid: u64,
        cap_left: u64,
        keeper: bool,
    }

    struct SplitPayoutCapEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        position_id: u64,
        released: u64,
        cap_left: u64,
    }

    struct SetWinCurveEventV1 has copy, drop {
        exchange_id: 0x2::object::ID,
        position_id: u64,
        market_id: 0x2::object::ID,
        c_ppm: u64,
    }

    fun emit<T0: copy + drop>(arg0: T0) {
        let v0 = Event<T0>{pos0: arg0};
        0x2::event::emit<Event<T0>>(v0);
    }

    public(friend) fun emit_achievement_unlocked_event(arg0: address, arg1: u8) {
        let v0 = AchievementUnlockedEventV1{
            who : arg0,
            id  : arg1,
        };
        emit<AchievementUnlockedEventV1>(v0);
    }

    public(friend) fun emit_close_xp_event(arg0: address, arg1: u64, arg2: 0x2::object::ID, arg3: u64, arg4: u64, arg5: bool, arg6: bool, arg7: bool) {
        let v0 = CloseXpEventV1{
            who          : arg0,
            position_id  : arg1,
            market_id    : arg2,
            volume_basis : arg3,
            held_ms      : arg4,
            wash         : arg5,
            genuine      : arg6,
            game_paused  : arg7,
        };
        emit<CloseXpEventV1>(v0);
    }

    public(friend) fun emit_cosmetic_unlocked_event(arg0: address, arg1: u8) {
        let v0 = CosmeticUnlockedEventV1{
            who : arg0,
            id  : arg1,
        };
        emit<CosmeticUnlockedEventV1>(v0);
    }

    public(friend) fun emit_counters_updated_event(arg0: address, arg1: 0x1::option::Option<0x2::object::ID>, arg2: vector<u8>, arg3: vector<u64>) {
        let v0 = CountersUpdatedEvent{
            player  : arg0,
            account : arg1,
            kinds   : arg2,
            values  : arg3,
        };
        emit<CountersUpdatedEvent>(v0);
    }

    public(friend) fun emit_crate_granted_event(arg0: address, arg1: u64, arg2: u64) {
        let v0 = CrateGrantedEventV1{
            who      : arg0,
            count    : arg1,
            unopened : arg2,
        };
        emit<CrateGrantedEventV1>(v0);
    }

    public(friend) fun emit_crate_opened_event(arg0: address, arg1: u8, arg2: u64, arg3: u8, arg4: u64, arg5: u64, arg6: u64) {
        let v0 = CrateOpenedEventV1{
            who       : arg0,
            kind      : arg1,
            amount    : arg2,
            cosmetic  : arg3,
            xp        : arg4,
            season_xp : arg5,
            season_id : arg6,
        };
        emit<CrateOpenedEventV1>(v0);
    }

    public(friend) fun emit_daily_claimed_event(arg0: address, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = DailyClaimedEventV1{
            who    : arg0,
            streak : arg1,
            amount : arg2,
            day    : arg3,
        };
        emit<DailyClaimedEventV1>(v0);
    }

    public(friend) fun emit_fee_credit_event(arg0: address, arg1: u64, arg2: u64) {
        let v0 = FeeCreditUpdatedEventV1{
            who             : arg0,
            fee_credit      : arg1,
            fee_credit_used : arg2,
        };
        emit<FeeCreditUpdatedEventV1>(v0);
    }

    public(friend) fun emit_game_reward_issued_event(arg0: address, arg1: u64, arg2: u64, arg3: u128) {
        let v0 = GameRewardIssuedEventV1{
            who     : arg0,
            amount  : arg1,
            day     : arg2,
            pending : arg3,
        };
        emit<GameRewardIssuedEventV1>(v0);
    }

    public(friend) fun emit_hit_payout_cap_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: u64, arg5: u64, arg6: u64, arg7: bool) {
        let v0 = HitPayoutCapEventV1{
            exchange_id : arg0,
            position_id : arg1,
            account_id  : arg2,
            market_id   : arg3,
            uncapped    : arg4,
            paid        : arg5,
            cap_left    : arg6,
            keeper      : arg7,
        };
        emit<HitPayoutCapEventV1>(v0);
    }

    public(friend) fun emit_level_crates_event(arg0: address, arg1: u64, arg2: u64, arg3: u64, arg4: u64) {
        let v0 = LevelCratesGrantedEventV1{
            who        : arg0,
            from_level : arg1,
            to_level   : arg2,
            count      : arg3,
            unopened   : arg4,
        };
        emit<LevelCratesGrantedEventV1>(v0);
    }

    public(friend) fun emit_progression_params_event(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64) {
        let v0 = ProgressionParamsUpdatedEventV1{
            fee_xp_per_usdc          : arg0,
            volume_band_full         : arg1,
            volume_band_end          : arg2,
            volume_xp_unit           : arg3,
            volume_xp_unit_reduced   : arg4,
            volume_market_day_xp_cap : arg5,
            volume_day_xp_cap        : arg6,
            win_min_profit           : arg7,
            win_day_xp_cap           : arg8,
            xp_min_hold_ms           : arg9,
            crates_per_level         : arg10,
            xp_per_crate             : arg11,
        };
        emit<ProgressionParamsUpdatedEventV1>(v0);
    }

    public(friend) fun emit_quest_completed_event(arg0: address, arg1: u8, arg2: u64, arg3: u64) {
        let v0 = QuestCompletedEventV1{
            who   : arg0,
            id    : arg1,
            xp    : arg2,
            money : arg3,
        };
        emit<QuestCompletedEventV1>(v0);
    }

    public(friend) fun emit_reward_minted_event(arg0: address, arg1: u64, arg2: u8) {
        let v0 = RewardMintedEventV1{
            who    : arg0,
            amount : arg1,
            source : arg2,
        };
        emit<RewardMintedEventV1>(v0);
    }

    public(friend) fun emit_set_payout_cap_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: 0x2::object::ID, arg4: bool, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u128, arg11: u128) {
        let v0 = SetPayoutCapEventV1{
            exchange_id    : arg0,
            position_id    : arg1,
            account_id     : arg2,
            market_id      : arg3,
            is_long        : arg4,
            leverage       : arg5,
            margin         : arg6,
            multiple_bps   : arg7,
            cap            : arg8,
            pool_cash      : arg9,
            side_committed : arg10,
            side_budget    : arg11,
        };
        emit<SetPayoutCapEventV1>(v0);
    }

    public(friend) fun emit_set_payout_cap_params_event(arg0: 0x2::object::ID, arg1: bool, arg2: vector<u64>, arg3: vector<u64>, arg4: u64, arg5: u64) {
        let v0 = SetPayoutCapParamsEventV1{
            config_id       : arg0,
            enabled         : arg1,
            leverages       : arg2,
            multiples_bps   : arg3,
            pool_share_bps  : arg4,
            side_budget_bps : arg5,
        };
        emit<SetPayoutCapParamsEventV1>(v0);
    }

    public(friend) fun emit_set_win_curve_event(arg0: 0x2::object::ID, arg1: u64, arg2: 0x2::object::ID, arg3: u64) {
        let v0 = SetWinCurveEventV1{
            exchange_id : arg0,
            position_id : arg1,
            market_id   : arg2,
            c_ppm       : arg3,
        };
        emit<SetWinCurveEventV1>(v0);
    }

    public(friend) fun emit_split_payout_cap_event(arg0: 0x2::object::ID, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = SplitPayoutCapEventV1{
            exchange_id : arg0,
            position_id : arg1,
            released    : arg2,
            cap_left    : arg3,
        };
        emit<SplitPayoutCapEventV1>(v0);
    }

    public(friend) fun emit_tier_up_event(arg0: address, arg1: u8, arg2: u8) {
        let v0 = TierUpEventV1{
            who       : arg0,
            from_tier : arg1,
            to_tier   : arg2,
        };
        emit<TierUpEventV1>(v0);
    }

    public(friend) fun emit_win_streak_event(arg0: address, arg1: u64) {
        let v0 = WinStreakUpdatedEventV1{
            who    : arg0,
            streak : arg1,
        };
        emit<WinStreakUpdatedEventV1>(v0);
    }

    public(friend) fun emit_xp_granted_event(arg0: address, arg1: u64, arg2: u8, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = XpGrantedEventV1{
            who       : arg0,
            amount    : arg1,
            source    : arg2,
            all_time  : arg3,
            season_xp : arg4,
            season_id : arg5,
        };
        emit<XpGrantedEventV1>(v0);
    }

    // decompiled from Move bytecode v7
}

