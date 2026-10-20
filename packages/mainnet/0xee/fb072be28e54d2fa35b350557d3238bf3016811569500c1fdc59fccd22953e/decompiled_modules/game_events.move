module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events {
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
        cosmetic: 0x1::option::Option<u8>,
    }

    struct FeeCreditUpdatedEventV1 has copy, drop {
        who: address,
        fee_credit: u64,
        fee_credit_used: u64,
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

    public(friend) fun emit_cosmetic_unlocked_event(arg0: address, arg1: u8) {
        let v0 = CosmeticUnlockedEventV1{
            who : arg0,
            id  : arg1,
        };
        emit<CosmeticUnlockedEventV1>(v0);
    }

    public(friend) fun emit_crate_granted_event(arg0: address, arg1: u64, arg2: u64) {
        let v0 = CrateGrantedEventV1{
            who      : arg0,
            count    : arg1,
            unopened : arg2,
        };
        emit<CrateGrantedEventV1>(v0);
    }

    public(friend) fun emit_crate_opened_event(arg0: address, arg1: u8, arg2: u64, arg3: 0x1::option::Option<u8>) {
        let v0 = CrateOpenedEventV1{
            who      : arg0,
            kind     : arg1,
            amount   : arg2,
            cosmetic : arg3,
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

    public(friend) fun emit_xp_granted_event(arg0: address, arg1: u64, arg2: u8, arg3: u64, arg4: u64) {
        let v0 = XpGrantedEventV1{
            who       : arg0,
            amount    : arg1,
            source    : arg2,
            all_time  : arg3,
            season_xp : arg4,
        };
        emit<XpGrantedEventV1>(v0);
    }

    // decompiled from Move bytecode v7
}

