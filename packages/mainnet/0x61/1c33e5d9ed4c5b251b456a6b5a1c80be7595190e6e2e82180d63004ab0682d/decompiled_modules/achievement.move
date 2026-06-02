module 0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::achievement {
    struct Achievement has key {
        id: 0x2::object::UID,
        name: 0x1::string::String,
        description: 0x1::string::String,
        badge_url: 0x1::string::String,
        requirement_type: u8,
        threshold: u64,
        is_active: bool,
        created_at: u64,
    }

    struct PlayerStats has key {
        id: 0x2::object::UID,
        owner: address,
        unlocked: vector<UnlockedAchievement>,
    }

    struct UnlockedAchievement has copy, drop, store {
        achievement_id: 0x2::object::ID,
        achievement_name: 0x1::string::String,
        requirement_type: u8,
        claimed_at: u64,
    }

    struct AchievementGrant has store, key {
        id: 0x2::object::UID,
        achievement_id: 0x2::object::ID,
        intended_recipient: address,
        granted_by: address,
        granted_at: u64,
    }

    struct AchievementCreated has copy, drop {
        achievement_id: 0x2::object::ID,
        name: 0x1::string::String,
        requirement_type: u8,
        threshold: u64,
        by: address,
        timestamp: u64,
    }

    struct AchievementActivated has copy, drop {
        achievement_id: 0x2::object::ID,
        by: address,
        timestamp: u64,
    }

    struct AchievementDeactivated has copy, drop {
        achievement_id: 0x2::object::ID,
        by: address,
        timestamp: u64,
    }

    struct AchievementUpdated has copy, drop {
        achievement_id: 0x2::object::ID,
        by: address,
        timestamp: u64,
    }

    struct PlayerStatsCreated has copy, drop {
        stats_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct AchievementClaimed has copy, drop {
        achievement_id: 0x2::object::ID,
        achievement_name: 0x1::string::String,
        player: address,
        requirement_type: u8,
        timestamp: u64,
    }

    struct GrantIssued has copy, drop {
        grant_id: 0x2::object::ID,
        achievement_id: 0x2::object::ID,
        recipient: address,
        granted_by: address,
        timestamp: u64,
    }

    struct GrantClaimed has copy, drop {
        grant_id: 0x2::object::ID,
        achievement_id: 0x2::object::ID,
        player: address,
        timestamp: u64,
    }

    struct AchievementBurned has copy, drop {
        achievement_id: 0x2::object::ID,
        by: address,
        timestamp: u64,
    }

    struct PlayerStatsBurned has copy, drop {
        stats_id: 0x2::object::ID,
        owner: address,
        timestamp: u64,
    }

    struct GrantBurned has copy, drop {
        grant_id: 0x2::object::ID,
        achievement_id: 0x2::object::ID,
        by: address,
        timestamp: u64,
    }

    public fun activate_achievement(arg0: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::SuperAdminCap, arg1: &mut Achievement, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_active = true;
        let v0 = AchievementActivated{
            achievement_id : 0x2::object::uid_to_inner(&arg1.id),
            by             : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AchievementActivated>(v0);
    }

    public fun burn_achievement(arg0: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::SuperAdminCap, arg1: Achievement, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(!arg1.is_active, 2);
        let Achievement {
            id               : v0,
            name             : _,
            description      : _,
            badge_url        : _,
            requirement_type : _,
            threshold        : _,
            is_active        : _,
            created_at       : _,
        } = arg1;
        let v8 = v0;
        let v9 = AchievementBurned{
            achievement_id : 0x2::object::uid_to_inner(&v8),
            by             : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AchievementBurned>(v9);
        0x2::object::delete(v8);
    }

    public fun burn_grant(arg0: AchievementGrant, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.intended_recipient == 0x2::tx_context::sender(arg2), 5);
        let AchievementGrant {
            id                 : v0,
            achievement_id     : v1,
            intended_recipient : _,
            granted_by         : _,
            granted_at         : _,
        } = arg0;
        let v5 = v0;
        let v6 = GrantBurned{
            grant_id       : 0x2::object::uid_to_inner(&v5),
            achievement_id : v1,
            by             : 0x2::tx_context::sender(arg2),
            timestamp      : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<GrantBurned>(v6);
        0x2::object::delete(v5);
    }

    public fun burn_player_stats(arg0: PlayerStats, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg2), 5);
        let PlayerStats {
            id       : v0,
            owner    : v1,
            unlocked : _,
        } = arg0;
        let v3 = v0;
        let v4 = PlayerStatsBurned{
            stats_id  : 0x2::object::uid_to_inner(&v3),
            owner     : v1,
            timestamp : 0x2::clock::timestamp_ms(arg1),
        };
        0x2::event::emit<PlayerStatsBurned>(v4);
        0x2::object::delete(v3);
    }

    public fun claim_achievement(arg0: &Achievement, arg1: &mut PlayerStats, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.owner == v0, 5);
        assert!(arg0.is_active, 2);
        assert!(arg0.requirement_type != 3, 4);
        assert!(arg2 >= arg0.threshold, 3);
        let v1 = 0x2::object::uid_to_inner(&arg0.id);
        assert!(!has_unlocked(&arg1.unlocked, v1), 1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = UnlockedAchievement{
            achievement_id   : v1,
            achievement_name : arg0.name,
            requirement_type : arg0.requirement_type,
            claimed_at       : v2,
        };
        0x1::vector::push_back<UnlockedAchievement>(&mut arg1.unlocked, v3);
        let v4 = AchievementClaimed{
            achievement_id   : v1,
            achievement_name : arg0.name,
            player           : v0,
            requirement_type : arg0.requirement_type,
            timestamp        : v2,
        };
        0x2::event::emit<AchievementClaimed>(v4);
    }

    public fun claim_granted_achievement(arg0: AchievementGrant, arg1: &Achievement, arg2: &mut PlayerStats, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg2.owner == v0, 5);
        assert!(arg0.intended_recipient == v0, 5);
        let v1 = 0x2::object::uid_to_inner(&arg1.id);
        assert!(arg0.achievement_id == v1, 6);
        assert!(arg1.is_active, 2);
        assert!(arg1.requirement_type == 3, 4);
        assert!(!has_unlocked(&arg2.unlocked, v1), 1);
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = UnlockedAchievement{
            achievement_id   : v1,
            achievement_name : arg1.name,
            requirement_type : arg1.requirement_type,
            claimed_at       : v2,
        };
        0x1::vector::push_back<UnlockedAchievement>(&mut arg2.unlocked, v3);
        let v4 = AchievementClaimed{
            achievement_id   : v1,
            achievement_name : arg1.name,
            player           : v0,
            requirement_type : arg1.requirement_type,
            timestamp        : v2,
        };
        0x2::event::emit<AchievementClaimed>(v4);
        let v5 = GrantClaimed{
            grant_id       : 0x2::object::uid_to_inner(&arg0.id),
            achievement_id : v1,
            player         : v0,
            timestamp      : v2,
        };
        0x2::event::emit<GrantClaimed>(v5);
        let AchievementGrant {
            id                 : v6,
            achievement_id     : _,
            intended_recipient : _,
            granted_by         : _,
            granted_at         : _,
        } = arg0;
        0x2::object::delete(v6);
    }

    public fun create_achievement(arg0: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::SuperAdminCap, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: u8, arg5: u64, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = if (arg4 == 0) {
            true
        } else if (arg4 == 1) {
            true
        } else if (arg4 == 2) {
            true
        } else {
            arg4 == 3
        };
        assert!(v0, 4);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        let v2 = 0x2::object::new(arg7);
        let v3 = Achievement{
            id               : v2,
            name             : arg1,
            description      : arg2,
            badge_url        : arg3,
            requirement_type : arg4,
            threshold        : arg5,
            is_active        : true,
            created_at       : v1,
        };
        let v4 = AchievementCreated{
            achievement_id   : 0x2::object::uid_to_inner(&v2),
            name             : arg1,
            requirement_type : arg4,
            threshold        : arg5,
            by               : 0x2::tx_context::sender(arg7),
            timestamp        : v1,
        };
        0x2::event::emit<AchievementCreated>(v4);
        0x2::transfer::share_object<Achievement>(v3);
    }

    public fun create_player_stats(arg0: &0x2::clock::Clock, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg1);
        let v1 = 0x2::object::new(arg1);
        let v2 = PlayerStats{
            id       : v1,
            owner    : v0,
            unlocked : 0x1::vector::empty<UnlockedAchievement>(),
        };
        let v3 = PlayerStatsCreated{
            stats_id  : 0x2::object::uid_to_inner(&v1),
            owner     : v0,
            timestamp : 0x2::clock::timestamp_ms(arg0),
        };
        0x2::event::emit<PlayerStatsCreated>(v3);
        0x2::transfer::transfer<PlayerStats>(v2, v0);
    }

    public fun deactivate_achievement(arg0: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::SuperAdminCap, arg1: &mut Achievement, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        arg1.is_active = false;
        let v0 = AchievementDeactivated{
            achievement_id : 0x2::object::uid_to_inner(&arg1.id),
            by             : 0x2::tx_context::sender(arg3),
            timestamp      : 0x2::clock::timestamp_ms(arg2),
        };
        0x2::event::emit<AchievementDeactivated>(v0);
    }

    public fun get_achievement_id(arg0: &Achievement) : 0x2::object::ID {
        0x2::object::uid_to_inner(&arg0.id)
    }

    public fun get_achievement_info(arg0: &Achievement) : (0x1::string::String, 0x1::string::String, 0x1::string::String, u8, u64, bool) {
        (arg0.name, arg0.description, arg0.badge_url, arg0.requirement_type, arg0.threshold, arg0.is_active)
    }

    public fun get_unlocked_at(arg0: &PlayerStats, arg1: u64) : (0x2::object::ID, 0x1::string::String, u8, u64) {
        let v0 = 0x1::vector::borrow<UnlockedAchievement>(&arg0.unlocked, arg1);
        (v0.achievement_id, v0.achievement_name, v0.requirement_type, v0.claimed_at)
    }

    public fun has_achievement(arg0: &PlayerStats, arg1: 0x2::object::ID) : bool {
        has_unlocked(&arg0.unlocked, arg1)
    }

    fun has_unlocked(arg0: &vector<UnlockedAchievement>, arg1: 0x2::object::ID) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<UnlockedAchievement>(arg0)) {
            if (0x1::vector::borrow<UnlockedAchievement>(arg0, v0).achievement_id == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun is_active(arg0: &Achievement) : bool {
        arg0.is_active
    }

    public fun issue_grant(arg0: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::SuperAdminCap, arg1: &Achievement, arg2: address, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.requirement_type == 3, 4);
        assert!(arg1.is_active, 2);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::object::new(arg4);
        let v2 = 0x2::object::uid_to_inner(&arg1.id);
        let v3 = AchievementGrant{
            id                 : v1,
            achievement_id     : v2,
            intended_recipient : arg2,
            granted_by         : 0x2::tx_context::sender(arg4),
            granted_at         : v0,
        };
        let v4 = GrantIssued{
            grant_id       : 0x2::object::uid_to_inner(&v1),
            achievement_id : v2,
            recipient      : arg2,
            granted_by     : 0x2::tx_context::sender(arg4),
            timestamp      : v0,
        };
        0x2::event::emit<GrantIssued>(v4);
        0x2::transfer::transfer<AchievementGrant>(v3, arg2);
    }

    public fun req_admin_granted() : u8 {
        3
    }

    public fun req_best_mmr() : u8 {
        1
    }

    public fun req_total_mmr() : u8 {
        0
    }

    public fun req_total_summons() : u8 {
        2
    }

    public fun stats_owner(arg0: &PlayerStats) : address {
        arg0.owner
    }

    public fun unlocked_count(arg0: &PlayerStats) : u64 {
        0x1::vector::length<UnlockedAchievement>(&arg0.unlocked)
    }

    public fun update_achievement_display(arg0: &0x611c33e5d9ed4c5b251b456a6b5a1c80be7595190e6e2e82180d63004ab0682d::admin::SuperAdminCap, arg1: &mut Achievement, arg2: 0x1::string::String, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) {
        arg1.name = arg2;
        arg1.description = arg3;
        arg1.badge_url = arg4;
        let v0 = AchievementUpdated{
            achievement_id : 0x2::object::uid_to_inner(&arg1.id),
            by             : 0x2::tx_context::sender(arg6),
            timestamp      : 0x2::clock::timestamp_ms(arg5),
        };
        0x2::event::emit<AchievementUpdated>(v0);
    }

    // decompiled from Move bytecode v7
}

