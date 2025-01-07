module 0x625d518a3cc78899742d76cf785609cd707e15228d4284aa4fee5ca53caa9849::dungeon_event {
    struct RatingLeaderboardEvent has copy, drop {
        resident_ids: vector<0x2::object::ID>,
        ratings: vector<u64>,
        rarity: vector<0x1::string::String>,
        level: vector<u64>,
        identity: vector<0x1::string::String>,
    }

    struct ResidentCountEvent has copy, drop {
        count: vector<u64>,
    }

    struct RarityCountEvent has copy, drop {
        count: vector<u64>,
    }

    struct UserCombatingEvent has copy, drop {
        ids: vector<0x2::object::ID>,
    }

    struct UserBossCaveCombatingEvent has copy, drop {
        ids: vector<0x2::object::ID>,
    }

    struct UserInviteCodeEvent has copy, drop {
        invite_code: vector<0x1::string::String>,
        is_used: vector<bool>,
    }

    struct LevelUpFeeEvent has copy, drop {
        fee: u64,
    }

    public(friend) fun rarity_count_event(arg0: vector<u64>) {
        let v0 = RarityCountEvent{count: arg0};
        0x2::event::emit<RarityCountEvent>(v0);
    }

    public(friend) fun rating_leaderboard_event(arg0: vector<0x2::object::ID>, arg1: vector<u64>, arg2: vector<0x1::string::String>, arg3: vector<u64>, arg4: vector<0x1::string::String>) {
        let v0 = RatingLeaderboardEvent{
            resident_ids : arg0,
            ratings      : arg1,
            rarity       : arg2,
            level        : arg3,
            identity     : arg4,
        };
        0x2::event::emit<RatingLeaderboardEvent>(v0);
    }

    public(friend) fun resident_count_event(arg0: vector<u64>) {
        let v0 = ResidentCountEvent{count: arg0};
        0x2::event::emit<ResidentCountEvent>(v0);
    }

    public(friend) fun upgrade_fee_event(arg0: u64) {
        let v0 = LevelUpFeeEvent{fee: arg0};
        0x2::event::emit<LevelUpFeeEvent>(v0);
    }

    public(friend) fun user_boss_cave_combating_event(arg0: vector<0x2::object::ID>) {
        let v0 = UserBossCaveCombatingEvent{ids: arg0};
        0x2::event::emit<UserBossCaveCombatingEvent>(v0);
    }

    public(friend) fun user_combating_event(arg0: vector<0x2::object::ID>) {
        let v0 = UserCombatingEvent{ids: arg0};
        0x2::event::emit<UserCombatingEvent>(v0);
    }

    public(friend) fun user_invite_code_event(arg0: vector<0x1::string::String>, arg1: vector<bool>) {
        let v0 = UserInviteCodeEvent{
            invite_code : arg0,
            is_used     : arg1,
        };
        0x2::event::emit<UserInviteCodeEvent>(v0);
    }

    // decompiled from Move bytecode v6
}

