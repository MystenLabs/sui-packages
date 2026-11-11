module 0x2dafd0ae920ffa0644d640317bd9c56afb42bdf0f2f92807ce12a995a00f192e::game_events {
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

