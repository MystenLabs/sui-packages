module 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_book {
    struct GameConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GameBookKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GameConfig has store, key {
        id: 0x2::object::UID,
        enabled: bool,
        xp_per_notional_bps: u64,
        tier_thresholds: vector<u64>,
        tier_names: vector<vector<u8>>,
        daily_base: u64,
        daily_step: u64,
        daily_max: u64,
        daily_streak_cap: u64,
        win_xp_bonus: u64,
        win_streak_xp_cap: u64,
        crate_cooldown_ms: u64,
        crate_xp: u64,
        weight_xp: u64,
        weight_cosmetic: u64,
        xp_per_crate: u64,
        max_unopened_crates: u64,
        max_season_reward: u64,
        season_id: u64,
        season_start_ms: u64,
        season_end_ms: u64,
        max_xp_grant: u64,
        wallet_mint_cap: u64,
        global_mint_cap: u64,
        achievement_mint_fraction_bps: u64,
    }

    struct AchievementDef has copy, drop, store {
        name: vector<u8>,
        kind: u8,
        param: u64,
        xp: u64,
        mint_amount: u64,
        cosmetic: 0x1::option::Option<u8>,
        active: bool,
    }

    struct QuestDef has copy, drop, store {
        name: vector<u8>,
        kind: u8,
        param: u64,
        xp: u64,
        cosmetic: 0x1::option::Option<u8>,
        active: bool,
        start_ms: u64,
        end_ms: u64,
        season_id: u64,
    }

    struct CosmeticDef has copy, drop, store {
        name: vector<u8>,
    }

    struct Player has copy, drop, store {
        xp: u64,
        season_xp: u64,
        season_id: u64,
        tier: u8,
        last_daily_day: u64,
        streak: u64,
        win_streak: u64,
        achievements: u128,
        quests_done: u128,
        cosmetics: u128,
        crates: u64,
        last_crate_ms: u64,
        markets: vector<0x2::object::ID>,
        season_rewarded: u64,
        trades: u64,
        fee_credit: u64,
        fee_credit_used: u64,
        pending_mint: u128,
        issuance_day: u64,
        issued_today: u64,
    }

    struct GameBook has store, key {
        id: 0x2::object::UID,
        players: 0x2::table::Table<address, Player>,
        achievements: 0x2::table::Table<u8, AchievementDef>,
        achievement_ids: vector<u8>,
        quests: 0x2::table::Table<u8, QuestDef>,
        quest_ids: vector<u8>,
        cosmetics: 0x2::table::Table<u8, CosmeticDef>,
        cosmetic_ids: vector<u8>,
        crate_cosmetics: vector<u8>,
        global_issuance_day: u64,
        global_issued: u64,
    }

    struct Rules has drop {
        enabled: bool,
        xp_per_notional_bps: u64,
        tier_thresholds: vector<u64>,
        daily_base: u64,
        daily_step: u64,
        daily_max: u64,
        daily_streak_cap: u64,
        win_xp_bonus: u64,
        win_streak_xp_cap: u64,
        xp_per_crate: u64,
        max_unopened_crates: u64,
        season_id: u64,
        season_start_ms: u64,
        season_end_ms: u64,
        wallet_mint_cap: u64,
        global_mint_cap: u64,
        achievement_mint_fraction_bps: u64,
    }

    struct AchievementView has copy, drop {
        id: u8,
        kind: u8,
        param: u64,
        xp: u64,
        mint_amount: u64,
        cosmetic: 0x1::option::Option<u8>,
        active: bool,
    }

    struct QuestView has copy, drop {
        id: u8,
        kind: u8,
        param: u64,
        xp: u64,
        cosmetic: 0x1::option::Option<u8>,
        active: bool,
        start_ms: u64,
        end_ms: u64,
        season_id: u64,
    }

    struct Trigger has copy, drop {
        on_close: bool,
        loss: u64,
        profit: u64,
        leverage: u64,
        margin: u64,
        wash: bool,
        fees_paid: bool,
    }

    public fun issue(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = rules(arg2);
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::utc_day(arg5);
        let v2 = take_player(arg1, arg3);
        if (v2.issuance_day != v1) {
            v2.issuance_day = v1;
            v2.issued_today = 0;
        };
        let v3 = book_mut(arg1);
        if (v3.global_issuance_day != v1) {
            v3.global_issuance_day = v1;
            v3.global_issued = 0;
        };
        let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::take_capped(arg4, v2.issued_today, v0.wallet_mint_cap, v3.global_issued, v0.global_mint_cap);
        let v5 = if (v4 < arg6) {
            v4
        } else {
            arg6
        };
        v2.issued_today = v2.issued_today + v5;
        v3.global_issued = v3.global_issued + v5;
        v2.pending_mint = v2.pending_mint + ((arg4 - v5) as u128);
        save_player(arg1, arg3, v2);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_game_reward_issued_event(arg3, v5, v1, v2.pending_mint);
        v5
    }

    fun achievement_at(arg0: &vector<AchievementView>, arg1: u64) : AchievementView {
        *0x1::vector::borrow<AchievementView>(arg0, arg1)
    }

    fun achievement_by_id(arg0: &vector<AchievementView>, arg1: u8) : AchievementView {
        let v0 = 0;
        while (v0 < 0x1::vector::length<AchievementView>(arg0)) {
            let v1 = achievement_at(arg0, v0);
            if (v1.id == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        achievement_at(arg0, 0)
    }

    public fun achievement_count(arg0: &0x2::object::UID) : u64 {
        0x1::vector::length<u8>(&book(arg0).achievement_ids)
    }

    public fun achievement_exists(arg0: &0x2::object::UID, arg1: u8) : bool {
        0x2::table::contains<u8, AchievementDef>(&book(arg0).achievements, arg1)
    }

    public fun achievement_mint_fraction_bps(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).achievement_mint_fraction_bps
    }

    public fun achievement_on(arg0: &0x2::object::UID, arg1: address, arg2: u8) : bool {
        bit_field(arg0, arg1, arg2, 0)
    }

    fun achievement_views(arg0: &0x2::object::UID) : vector<AchievementView> {
        let v0 = book(arg0);
        let v1 = 0x1::vector::empty<AchievementView>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0.achievement_ids)) {
            let v3 = *0x1::vector::borrow<u8>(&v0.achievement_ids, v2);
            let v4 = *0x2::table::borrow<u8, AchievementDef>(&v0.achievements, v3);
            let v5 = AchievementView{
                id          : v3,
                kind        : v4.kind,
                param       : v4.param,
                xp          : v4.xp,
                mint_amount : v4.mint_amount,
                cosmetic    : v4.cosmetic,
                active      : v4.active,
            };
            0x1::vector::push_back<AchievementView>(&mut v1, v5);
            v2 = v2 + 1;
        };
        v1
    }

    public fun add_achievement(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u8>) : u8 {
        let v0 = book_mut(arg1);
        let v1 = (0x1::vector::length<u8>(&v0.achievement_ids) as u8);
        0x1::vector::push_back<u8>(&mut v0.achievement_ids, v1);
        let v2 = AchievementDef{
            name        : arg2,
            kind        : arg3,
            param       : arg4,
            xp          : arg5,
            mint_amount : arg6,
            cosmetic    : arg7,
            active      : true,
        };
        0x2::table::add<u8, AchievementDef>(&mut v0.achievements, v1, v2);
        v1
    }

    public fun add_cosmetic(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>) : u8 {
        let v0 = book_mut(arg1);
        let v1 = (0x1::vector::length<u8>(&v0.cosmetic_ids) as u8);
        0x1::vector::push_back<u8>(&mut v0.cosmetic_ids, v1);
        let v2 = CosmeticDef{name: arg2};
        0x2::table::add<u8, CosmeticDef>(&mut v0.cosmetics, v1, v2);
        v1
    }

    public fun add_quest(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u8>, arg7: u64, arg8: u64, arg9: u64) : u8 {
        let v0 = book_mut(arg1);
        let v1 = (0x1::vector::length<u8>(&v0.quest_ids) as u8);
        0x1::vector::push_back<u8>(&mut v0.quest_ids, v1);
        let v2 = QuestDef{
            name      : arg2,
            kind      : arg3,
            param     : arg4,
            xp        : arg5,
            cosmetic  : arg6,
            active    : true,
            start_ms  : arg7,
            end_ms    : arg8,
            season_id : arg9,
        };
        0x2::table::add<u8, QuestDef>(&mut v0.quests, v1, v2);
        v1
    }

    fun apply_xp(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: u64, arg4: u8, arg5: u64) {
        if (arg3 == 0) {
            return
        };
        if (arg0.season_id != arg2.season_id) {
            arg0.season_xp = 0;
            arg0.season_id = arg2.season_id;
        };
        let v0 = arg0.xp;
        arg0.xp = sat_add(v0, arg3);
        if (in_season(arg2, arg5)) {
            arg0.season_xp = sat_add(arg0.season_xp, arg3);
        };
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_xp_granted_event(arg1, arg3, arg4, arg0.xp, arg0.season_xp);
        let v1 = tier_of(arg0.xp, &arg2.tier_thresholds);
        if (v1 > arg0.tier) {
            arg0.tier = v1;
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_tier_up_event(arg1, arg0.tier, v1);
        };
        if (arg2.xp_per_crate > 0) {
            let v2 = v0 / arg2.xp_per_crate;
            let v3 = arg0.xp / arg2.xp_per_crate;
            if (v3 > v2) {
                let v4 = v3 - v2;
                let v5 = if (arg0.crates >= arg2.max_unopened_crates) {
                    0
                } else {
                    arg2.max_unopened_crates - arg0.crates
                };
                let v6 = if (v4 > v5) {
                    v5
                } else {
                    v4
                };
                if (v6 > 0) {
                    arg0.crates = arg0.crates + v6;
                    0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_crate_granted_event(arg1, v6, arg0.crates);
                };
            };
        };
    }

    public fun attach<T0>(arg0: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config, arg1: &mut 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::Exchange<T0>, arg2: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::AuthorityCap<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::PACKAGE, 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::ADMIN>, arg3: &mut 0x2::tx_context::TxContext) {
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::assert_version(arg0);
        0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::authority::assert_admin(0x2::object::id<0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::Config>(arg0), arg2);
        let v0 = 0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::auth::issue(0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid(arg0));
        let v1 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::exchange::uid_mut<T0>(&v0, arg1);
        let v2 = GameBookKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<GameBookKey>(v1, v2), 13835058824081702919);
        attach_book(v1, arg3);
        let v3 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::config::uid_mut(&v0, arg0);
        let v4 = GameConfigKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists<GameConfigKey>(v3, v4)) {
            attach_config(v3, arg3);
        };
    }

    public(friend) fun attach_book(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameBookKey{dummy_field: false};
        let v1 = GameBook{
            id                  : 0x2::object::new(arg1),
            players             : 0x2::table::new<address, Player>(arg1),
            achievements        : 0x2::table::new<u8, AchievementDef>(arg1),
            achievement_ids     : b"",
            quests              : 0x2::table::new<u8, QuestDef>(arg1),
            quest_ids           : b"",
            cosmetics           : 0x2::table::new<u8, CosmeticDef>(arg1),
            cosmetic_ids        : b"",
            crate_cosmetics     : b"",
            global_issuance_day : 0,
            global_issued       : 0,
        };
        0x2::dynamic_object_field::add<GameBookKey, GameBook>(arg0, v0, v1);
    }

    public(friend) fun attach_config(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameConfigKey{dummy_field: false};
        let v1 = GameConfig{
            id                            : 0x2::object::new(arg1),
            enabled                       : false,
            xp_per_notional_bps           : 1,
            tier_thresholds               : vector[1000, 10000, 100000, 1000000],
            tier_names                    : default_names(),
            daily_base                    : 100,
            daily_step                    : 10,
            daily_max                     : 300,
            daily_streak_cap              : 30,
            win_xp_bonus                  : 10,
            win_streak_xp_cap             : 10,
            crate_cooldown_ms             : 86400000,
            crate_xp                      : 100,
            weight_xp                     : 30,
            weight_cosmetic               : 20,
            xp_per_crate                  : 10000,
            max_unopened_crates           : 5,
            max_season_reward             : 1000000000,
            season_id                     : 0,
            season_start_ms               : 0,
            season_end_ms                 : 0,
            max_xp_grant                  : 1000000,
            wallet_mint_cap               : 5000000000,
            global_mint_cap               : 1000000000000,
            achievement_mint_fraction_bps : 2500,
        };
        0x2::dynamic_object_field::add<GameConfigKey, GameConfig>(arg0, v0, v1);
    }

    public fun award(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u8, arg5: u64) : u8 {
        if (!achievement_exists(arg1, arg4)) {
            return 6
        };
        let (v0, v1, v2, v3) = load(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let v7 = achievement_by_id(&v5, arg4);
        if (!v7.active) {
            return 4
        };
        let v8 = take_player(arg1, arg3);
        if (bit_on(v8.achievements, arg4)) {
            return 5
        };
        let v9 = if (v7.mint_amount > 0) {
            true
        } else if (v7.kind == 3) {
            true
        } else {
            v7.kind == 4
        };
        if (v9) {
            return 1
        };
        v8.achievements = set_bit(v8.achievements, arg4);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_achievement_unlocked_event(arg3, arg4);
        if (v7.xp > 0) {
            let v10 = &mut v8;
            apply_xp(v10, arg3, &v6, v7.xp, 2, arg5);
        };
        let v11 = &mut v8;
        unlock_cosmetic(v11, arg3, v7.cosmetic, v3);
        let v12 = &mut v8;
        settle(v12, arg3, &v6, &v5, &v4, v3, trigger_none(), arg5);
        save_player(arg1, arg3, v8);
        0
    }

    fun bit_field(arg0: &0x2::object::UID, arg1: address, arg2: u8, arg3: u8) : bool {
        if (!has_player(arg0, arg1)) {
            return false
        };
        let v0 = if (arg3 == 0) {
            0x2::table::borrow<address, Player>(&book(arg0).players, arg1).achievements
        } else if (arg3 == 1) {
            0x2::table::borrow<address, Player>(&book(arg0).players, arg1).quests_done
        } else {
            0x2::table::borrow<address, Player>(&book(arg0).players, arg1).cosmetics
        };
        bit_on(v0, arg2)
    }

    fun bit_on(arg0: u128, arg1: u8) : bool {
        arg0 & 1 << arg1 > 0
    }

    fun book(arg0: &0x2::object::UID) : &GameBook {
        let v0 = GameBookKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<GameBookKey, GameBook>(arg0, v0)
    }

    fun book_mut(arg0: &mut 0x2::object::UID) : &mut GameBook {
        let v0 = GameBookKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<GameBookKey, GameBook>(arg0, v0)
    }

    fun cfg(arg0: &0x2::object::UID) : &GameConfig {
        let v0 = GameConfigKey{dummy_field: false};
        0x2::dynamic_object_field::borrow<GameConfigKey, GameConfig>(arg0, v0)
    }

    fun cfg_mut(arg0: &mut 0x2::object::UID) : &mut GameConfig {
        let v0 = GameConfigKey{dummy_field: false};
        0x2::dynamic_object_field::borrow_mut<GameConfigKey, GameConfig>(arg0, v0)
    }

    public fun claim_quest(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u8, arg5: u64, arg6: bool) : u8 {
        if (!quest_exists(arg1, arg4)) {
            return 6
        };
        let (v0, v1, v2, v3) = load(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let v7 = quest_by_id(&v4, arg4);
        let v8 = take_player(arg1, arg3);
        if (bit_on(v8.quests_done, arg4)) {
            return 5
        };
        if (!v7.active) {
            return 4
        };
        if (!in_window(v7.start_ms, v7.end_ms, arg5) || !season_ok(v7.season_id, v6.season_id)) {
            return 7
        };
        let v9 = trigger_none();
        let v10 = criteria(&v8, v7.kind, v7.param, &v9) || arg6 && v7.kind == 7;
        if (!v10) {
            return 1
        };
        v8.quests_done = set_bit(v8.quests_done, arg4);
        if (v7.xp > 0) {
            let v11 = &mut v8;
            apply_xp(v11, arg3, &v6, v7.xp, 3, arg5);
        };
        let v12 = &mut v8;
        unlock_cosmetic(v12, arg3, v7.cosmetic, v3);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_quest_completed_event(arg3, arg4, v7.xp, 0);
        let v13 = &mut v8;
        settle(v13, arg3, &v6, &v5, &v4, v3, trigger_none(), arg5);
        save_player(arg1, arg3, v8);
        0
    }

    public fun commit_crate(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u8, arg5: u64, arg6: 0x1::option::Option<u8>, arg7: u64) {
        let (v0, v1, v2, v3) = load(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let v7 = take_player(arg1, arg3);
        v7.crates = v7.crates - 1;
        v7.last_crate_ms = arg7;
        if (arg4 == 1) {
            let v8 = &mut v7;
            apply_xp(v8, arg3, &v6, arg5, 4, arg7);
        };
        if (arg4 == 2) {
            let v9 = &mut v7;
            unlock_cosmetic(v9, arg3, arg6, v3);
        };
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_crate_opened_event(arg3, arg4, arg5, arg6);
        let v10 = &mut v7;
        settle(v10, arg3, &v6, &v5, &v4, v3, trigger_none(), arg7);
        save_player(arg1, arg3, v7);
    }

    public fun commit_daily(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let (v0, v1, v2, v3) = load(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let v7 = take_player(arg1, arg3);
        v7.streak = arg5;
        v7.last_daily_day = arg4;
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_daily_claimed_event(arg3, arg5, arg6, arg4);
        let v8 = &mut v7;
        apply_xp(v8, arg3, &v6, arg6, 5, arg7);
        let v9 = &mut v7;
        settle(v9, arg3, &v6, &v5, &v4, v3, trigger_none(), arg7);
        save_player(arg1, arg3, v7);
    }

    public fun cooling_down(arg0: u64, arg1: u64, arg2: u64) : bool {
        if (arg1 > 0) {
            if (arg0 != 0) {
                (arg2 as u128) < (arg0 as u128) + (arg1 as u128)
            } else {
                false
            }
        } else {
            false
        }
    }

    fun cosmetic_bits(arg0: &0x2::object::UID) : u128 {
        let v0 = book(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0.cosmetic_ids)) {
            v1 = set_bit(v1, *0x1::vector::borrow<u8>(&v0.cosmetic_ids, v2));
            v2 = v2 + 1;
        };
        v1
    }

    public fun cosmetic_count(arg0: &0x2::object::UID) : u64 {
        0x1::vector::length<u8>(&book(arg0).cosmetic_ids)
    }

    public fun cosmetic_exists(arg0: &0x2::object::UID, arg1: u8) : bool {
        0x2::table::contains<u8, CosmeticDef>(&book(arg0).cosmetics, arg1)
    }

    public fun crate_bounds(arg0: &0x2::object::UID) : (u64, u64) {
        let v0 = cfg(arg0);
        (v0.crate_xp, v0.crate_cooldown_ms)
    }

    public fun crate_pool(arg0: &0x2::object::UID) : vector<u8> {
        book(arg0).crate_cosmetics
    }

    public fun crate_status(arg0: &0x2::object::UID, arg1: address) : (u64, u64) {
        if (!has_player(arg0, arg1)) {
            (0, 0)
        } else {
            let v2 = 0x2::table::borrow<address, Player>(&book(arg0).players, arg1);
            (v2.crates, v2.last_crate_ms)
        }
    }

    public fun crate_weights(arg0: &0x2::object::UID) : (u64, u64) {
        let v0 = cfg(arg0);
        (v0.weight_xp, v0.weight_cosmetic)
    }

    fun criteria(arg0: &Player, arg1: u8, arg2: u64, arg3: &Trigger) : bool {
        if ((arg1 == 3 || arg1 == 4) && (!arg3.on_close || !0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::genuine_win(arg3.wash, arg3.profit, arg3.loss))) {
            return false
        };
        if (arg1 == 0) {
            arg0.trades >= 1
        } else if (arg1 == 1) {
            0x1::vector::length<0x2::object::ID>(&arg0.markets) >= arg2
        } else if (arg1 == 2) {
            if (arg3.on_close) {
                if (arg3.loss == 0) {
                    arg3.leverage >= arg2
                } else {
                    false
                }
            } else {
                false
            }
        } else if (arg1 == 3) {
            if (arg3.on_close) {
                if (arg3.loss == 0) {
                    if (arg3.margin > 0) {
                        (arg3.profit as u128) * 10000 / (arg3.margin as u128) >= (arg2 as u128)
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            arg1 == 4 && arg0.win_streak >= arg2 || arg1 == 5 && (arg0.tier as u64) >= arg2 || arg1 == 8 && arg3.fees_paid && arg0.fee_credit >= arg2 || arg1 == 6 && arg0.streak >= arg2
        }
    }

    fun daily_amount(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        let v0 = if (arg4 > arg3) {
            arg3
        } else {
            arg4
        };
        let v1 = if (v0 == 0) {
            0
        } else {
            v0 - 1
        };
        let v2 = (arg0 as u128) + (v1 as u128) * (arg1 as u128);
        if (v2 > (arg2 as u128)) {
            arg2
        } else {
            (v2 as u64)
        }
    }

    public fun daily_base(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).daily_base
    }

    fun daily_progress(arg0: &0x2::object::UID, arg1: address) : (u64, u64) {
        if (!has_player(arg0, arg1)) {
            (0, 0)
        } else {
            let v2 = 0x2::table::borrow<address, Player>(&book(arg0).players, arg1);
            (v2.last_daily_day, v2.streak)
        }
    }

    fun default_names() : vector<vector<u8>> {
        let v0 = vector[];
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Scrap");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Draft");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Ledger");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Sealed");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Gilded");
        v0
    }

    fun empty_player() : Player {
        Player{
            xp              : 0,
            season_xp       : 0,
            season_id       : 0,
            tier            : 0,
            last_daily_day  : 0,
            streak          : 0,
            win_streak      : 0,
            achievements    : 0,
            quests_done     : 0,
            cosmetics       : 0,
            crates          : 0,
            last_crate_ms   : 0,
            markets         : 0x1::vector::empty<0x2::object::ID>(),
            season_rewarded : 0,
            trades          : 0,
            fee_credit      : 0,
            fee_credit_used : 0,
            pending_mint    : 0,
            issuance_day    : 0,
            issued_today    : 0,
        }
    }

    public fun enabled(arg0: &0x2::object::UID) : bool {
        cfg(arg0).enabled
    }

    public fun fee_credit(arg0: &0x2::object::UID, arg1: address) : u64 {
        if (has_player(arg0, arg1)) {
            0x2::table::borrow<address, Player>(&book(arg0).players, arg1).fee_credit
        } else {
            0
        }
    }

    public fun fee_credit_used(arg0: &0x2::object::UID, arg1: address) : u64 {
        if (has_player(arg0, arg1)) {
            0x2::table::borrow<address, Player>(&book(arg0).players, arg1).fee_credit_used
        } else {
            0
        }
    }

    fun field_u64(arg0: &0x2::object::UID, arg1: address, arg2: u8) : u64 {
        if (!has_player(arg0, arg1)) {
            return 0
        };
        let v0 = 0x2::table::borrow<address, Player>(&book(arg0).players, arg1);
        if (arg2 == 0) {
            v0.xp
        } else if (arg2 == 1) {
            v0.season_xp
        } else if (arg2 == 2) {
            (v0.tier as u64)
        } else if (arg2 == 3) {
            v0.streak
        } else if (arg2 == 4) {
            v0.win_streak
        } else if (arg2 == 5) {
            v0.crates
        } else if (arg2 == 6) {
            v0.trades
        } else if (arg2 == 10) {
            v0.season_rewarded
        } else {
            0
        }
    }

    public fun global_mint_cap(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).global_mint_cap
    }

    public fun global_minted(arg0: &0x2::object::UID) : u64 {
        book(arg0).global_issued
    }

    fun has_player(arg0: &0x2::object::UID, arg1: address) : bool {
        0x2::table::contains<address, Player>(&book(arg0).players, arg1)
    }

    fun in_season(arg0: &Rules, arg1: u64) : bool {
        if (arg0.season_id != 0) {
            if (arg1 >= arg0.season_start_ms) {
                arg1 < arg0.season_end_ms
            } else {
                false
            }
        } else {
            false
        }
    }

    fun in_window(arg0: u64, arg1: u64, arg2: u64) : bool {
        arg2 >= arg0 && (arg1 == 0 || arg2 < arg1)
    }

    fun load(arg0: &0x2::object::UID, arg1: &0x2::object::UID) : (Rules, vector<AchievementView>, vector<QuestView>, u128) {
        (rules(arg1), achievement_views(arg0), quest_views(arg0), cosmetic_bits(arg0))
    }

    public fun mark_season_rewarded(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64) {
        let v0 = take_player(arg1, arg2);
        v0.season_rewarded = arg3;
        save_player(arg1, arg2, v0);
    }

    public fun max_season_reward(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).max_season_reward
    }

    public(friend) fun max_unopened(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).max_unopened_crates
    }

    public fun max_xp_grant(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).max_xp_grant
    }

    public fun minted_today(arg0: &0x2::object::UID, arg1: address) : u64 {
        if (has_player(arg0, arg1)) {
            0x2::table::borrow<address, Player>(&book(arg0).players, arg1).issued_today
        } else {
            0
        }
    }

    public fun note_close(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64, arg8: bool, arg9: u64, arg10: u64) {
        let (v0, v1, v2, v3) = load(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let v7 = take_player(arg1, arg3);
        v7.fee_credit = sat_add(v7.fee_credit, arg9);
        if (arg9 > 0) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_fee_credit_event(arg3, v7.fee_credit, v7.fee_credit_used);
        };
        if (v6.enabled) {
            if (arg4 > 0 && v7.win_streak != 0) {
                v7.win_streak = 0;
                0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_win_streak_event(arg3, 0);
            };
            if (0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::genuine_win(arg8, arg5, arg4)) {
                v7.win_streak = sat_add(v7.win_streak, 1);
                0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_win_streak_event(arg3, v7.win_streak);
                let v8 = if (v7.win_streak > v6.win_streak_xp_cap) {
                    v6.win_streak_xp_cap
                } else {
                    v7.win_streak
                };
                let v9 = &mut v7;
                apply_xp(v9, arg3, &v6, v8 * v6.win_xp_bonus, 1, arg10);
            };
            let v10 = Trigger{
                on_close  : true,
                loss      : arg4,
                profit    : arg5,
                leverage  : arg6,
                margin    : arg7,
                wash      : arg8,
                fees_paid : arg9 > 0,
            };
            let v11 = &mut v7;
            settle(v11, arg3, &v6, &v5, &v4, v3, v10, arg10);
        };
        if (v7.fee_credit_used != v7.fee_credit_used) {
            0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_fee_credit_event(arg3, v7.fee_credit, v7.fee_credit_used);
        };
        save_player(arg1, arg3, v7);
    }

    public fun note_open(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: 0x2::object::ID, arg5: u64, arg6: u64) {
        let (v0, v1, v2, v3) = load(arg1, arg2);
        let v4 = v2;
        let v5 = v1;
        let v6 = v0;
        let v7 = take_player(arg1, arg3);
        v7.trades = sat_add(v7.trades, 1);
        let v8 = &mut v7;
        remember_market(v8, arg4);
        if (arg5 > 0) {
            let v9 = &mut v7;
            apply_xp(v9, arg3, &v6, arg5, 0, arg6);
        };
        let v10 = &mut v7;
        settle(v10, arg3, &v6, &v5, &v4, v3, trigger_none(), arg6);
        save_player(arg1, arg3, v7);
    }

    public fun owns_cosmetic(arg0: &0x2::object::UID, arg1: address, arg2: u8) : bool {
        has_player(arg0, arg1) && bit_on(0x2::table::borrow<address, Player>(&book(arg0).players, arg1).cosmetics, arg2)
    }

    fun pass_achievements(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: &vector<AchievementView>, arg4: u128, arg5: Trigger, arg6: u64) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<AchievementView>(arg3)) {
            let v2 = achievement_at(arg3, v1);
            v1 = v1 + 1;
            let v3 = if (v2.active) {
                if (!bit_on(arg0.achievements, v2.id)) {
                    criteria(arg0, v2.kind, v2.param, &arg5)
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                if (v2.kind == 8 && v2.mint_amount > 0) {
                    let v4 = 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::achievement_mint_allowance(arg0.fee_credit - arg0.fee_credit_used, arg2.achievement_mint_fraction_bps, v2.mint_amount);
                    arg0.fee_credit_used = arg0.fee_credit_used + 0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::safety::achievement_credit_cost(v4, arg2.achievement_mint_fraction_bps);
                    arg0.pending_mint = arg0.pending_mint + (v4 as u128);
                    0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_reward_minted_event(arg1, v4, 4);
                };
                arg0.achievements = set_bit(arg0.achievements, v2.id);
                0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_achievement_unlocked_event(arg1, v2.id);
                if (v2.xp > 0) {
                    apply_xp(arg0, arg1, arg2, v2.xp, 2, arg6);
                };
                unlock_cosmetic(arg0, arg1, v2.cosmetic, arg4);
                v0 = true;
            };
        };
        v0
    }

    fun pass_quests(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: &vector<QuestView>, arg4: u128, arg5: Trigger, arg6: u64) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 0x1::vector::length<QuestView>(arg3)) {
            let v2 = quest_at(arg3, v1);
            v1 = v1 + 1;
            let v3 = if (v2.active) {
                if (!bit_on(arg0.quests_done, v2.id)) {
                    if (in_window(v2.start_ms, v2.end_ms, arg6)) {
                        if (season_ok(v2.season_id, arg2.season_id)) {
                            criteria(arg0, v2.kind, v2.param, &arg5)
                        } else {
                            false
                        }
                    } else {
                        false
                    }
                } else {
                    false
                }
            } else {
                false
            };
            if (v3) {
                arg0.quests_done = set_bit(arg0.quests_done, v2.id);
                apply_xp(arg0, arg1, arg2, v2.xp, 3, arg6);
                unlock_cosmetic(arg0, arg1, v2.cosmetic, arg4);
                0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_quest_completed_event(arg1, v2.id, v2.xp, 0);
                v0 = true;
            };
        };
        v0
    }

    public fun pending_mint(arg0: &0x2::object::UID, arg1: address) : u128 {
        if (has_player(arg0, arg1)) {
            0x2::table::borrow<address, Player>(&book(arg0).players, arg1).pending_mint
        } else {
            0
        }
    }

    public fun player_crates(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 5)
    }

    public fun player_season_rewarded(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 10)
    }

    public fun player_season_xp(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 1)
    }

    public fun player_streak(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 3)
    }

    public fun player_tier(arg0: &0x2::object::UID, arg1: address) : u8 {
        (field_u64(arg0, arg1, 2) as u8)
    }

    public fun player_win_streak(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 4)
    }

    public fun player_xp(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 0)
    }

    public fun preview_daily(arg0: &0x2::object::UID, arg1: &0x2::object::UID, arg2: address, arg3: u64) : (u8, u64, u64, u64) {
        let v0 = rules(arg0);
        if (!v0.enabled) {
            return (1, 0, 0, 0)
        };
        let v1 = arg3 / 86400000;
        let (v2, v3) = daily_progress(arg1, arg2);
        if (v2 != 0 && v1 <= v2) {
            return (2, 0, 0, v1)
        };
        let v4 = if (v2 != 0 && v1 == v2 + 1) {
            sat_add(v3, 1)
        } else {
            1
        };
        (0, v4, daily_amount(v0.daily_base, v0.daily_step, v0.daily_max, v0.daily_streak_cap, v4), v1)
    }

    fun quest_at(arg0: &vector<QuestView>, arg1: u64) : QuestView {
        *0x1::vector::borrow<QuestView>(arg0, arg1)
    }

    fun quest_by_id(arg0: &vector<QuestView>, arg1: u8) : QuestView {
        let v0 = 0;
        while (v0 < 0x1::vector::length<QuestView>(arg0)) {
            let v1 = quest_at(arg0, v0);
            if (v1.id == arg1) {
                return v1
            };
            v0 = v0 + 1;
        };
        quest_at(arg0, 0)
    }

    public fun quest_count(arg0: &0x2::object::UID) : u64 {
        0x1::vector::length<u8>(&book(arg0).quest_ids)
    }

    public fun quest_done(arg0: &0x2::object::UID, arg1: address, arg2: u8) : bool {
        bit_field(arg0, arg1, arg2, 1)
    }

    public fun quest_exists(arg0: &0x2::object::UID, arg1: u8) : bool {
        0x2::table::contains<u8, QuestDef>(&book(arg0).quests, arg1)
    }

    public fun quest_ready(arg0: &0x2::object::UID, arg1: address, arg2: u8) : bool {
        false
    }

    fun quest_views(arg0: &0x2::object::UID) : vector<QuestView> {
        let v0 = book(arg0);
        let v1 = 0x1::vector::empty<QuestView>();
        let v2 = 0;
        while (v2 < 0x1::vector::length<u8>(&v0.quest_ids)) {
            let v3 = *0x1::vector::borrow<u8>(&v0.quest_ids, v2);
            let v4 = *0x2::table::borrow<u8, QuestDef>(&v0.quests, v3);
            let v5 = QuestView{
                id        : v3,
                kind      : v4.kind,
                param     : v4.param,
                xp        : v4.xp,
                cosmetic  : v4.cosmetic,
                active    : v4.active,
                start_ms  : v4.start_ms,
                end_ms    : v4.end_ms,
                season_id : v4.season_id,
            };
            0x1::vector::push_back<QuestView>(&mut v1, v5);
            v2 = v2 + 1;
        };
        v1
    }

    fun remember_market(arg0: &mut Player, arg1: 0x2::object::ID) {
        if (0x1::vector::contains<0x2::object::ID>(&arg0.markets, &arg1)) {
            return
        };
        if (0x1::vector::length<0x2::object::ID>(&arg0.markets) < 16) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.markets, arg1);
        };
    }

    public fun roll_season(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) : u64 {
        let v0 = cfg_mut(arg1);
        let v1 = v0.season_id + 1;
        v0.season_id = v1;
        v0.season_start_ms = arg2;
        v0.season_end_ms = arg3;
        v1
    }

    fun rules(arg0: &0x2::object::UID) : Rules {
        let v0 = cfg(arg0);
        Rules{
            enabled                       : v0.enabled,
            xp_per_notional_bps           : v0.xp_per_notional_bps,
            tier_thresholds               : v0.tier_thresholds,
            daily_base                    : v0.daily_base,
            daily_step                    : v0.daily_step,
            daily_max                     : v0.daily_max,
            daily_streak_cap              : v0.daily_streak_cap,
            win_xp_bonus                  : v0.win_xp_bonus,
            win_streak_xp_cap             : v0.win_streak_xp_cap,
            xp_per_crate                  : v0.xp_per_crate,
            max_unopened_crates           : v0.max_unopened_crates,
            season_id                     : v0.season_id,
            season_start_ms               : v0.season_start_ms,
            season_end_ms                 : v0.season_end_ms,
            wallet_mint_cap               : v0.wallet_mint_cap,
            global_mint_cap               : v0.global_mint_cap,
            achievement_mint_fraction_bps : v0.achievement_mint_fraction_bps,
        }
    }

    fun sat_add(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg0 as u128) + (arg1 as u128);
        if (v0 > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0 as u64)
        }
    }

    fun save_player(arg0: &mut 0x2::object::UID, arg1: address, arg2: Player) {
        let v0 = book_mut(arg0);
        if (!0x2::table::contains<address, Player>(&v0.players, arg1)) {
            0x2::table::add<address, Player>(&mut v0.players, arg1, arg2);
        } else {
            *0x2::table::borrow_mut<address, Player>(&mut v0.players, arg1) = arg2;
        };
    }

    public fun season(arg0: &0x2::object::UID) : (u64, u64, u64) {
        let v0 = cfg(arg0);
        (v0.season_id, v0.season_start_ms, v0.season_end_ms)
    }

    fun season_ok(arg0: u64, arg1: u64) : bool {
        arg0 == 0 || arg0 == arg1
    }

    public fun set_achievement_active(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u8, arg3: bool) {
        0x2::table::borrow_mut<u8, AchievementDef>(&mut book_mut(arg1).achievements, arg2).active = arg3;
    }

    public fun set_achievement_mint_fraction_bps(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64) {
        cfg_mut(arg1).achievement_mint_fraction_bps = arg2;
    }

    fun set_bit(arg0: u128, arg1: u8) : u128 {
        arg0 | 1 << arg1
    }

    public fun set_crate_params(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = cfg_mut(arg1);
        v0.crate_cooldown_ms = arg2;
        v0.crate_xp = arg3;
        v0.xp_per_crate = arg4;
        v0.max_unopened_crates = arg5;
    }

    public fun set_crate_pool(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>) {
        book_mut(arg1).crate_cosmetics = arg2;
    }

    public fun set_daily(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = cfg_mut(arg1);
        v0.daily_base = arg2;
        v0.daily_step = arg3;
        v0.daily_max = arg4;
        v0.daily_streak_cap = arg5;
    }

    public fun set_enabled(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: bool) {
        cfg_mut(arg1).enabled = arg2;
    }

    public fun set_mint_caps(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) {
        let v0 = cfg_mut(arg1);
        v0.wallet_mint_cap = arg2;
        v0.global_mint_cap = arg3;
    }

    public fun set_quest_active(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u8, arg3: bool) {
        0x2::table::borrow_mut<u8, QuestDef>(&mut book_mut(arg1).quests, arg2).active = arg3;
    }

    public fun set_quest_bounds(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64) {
        cfg_mut(arg1).max_xp_grant = arg2;
    }

    public fun set_season_ceiling(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64) {
        cfg_mut(arg1).max_season_reward = arg2;
    }

    public fun set_tier_name(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: vector<u8>) {
        *0x1::vector::borrow_mut<vector<u8>>(&mut cfg_mut(arg1).tier_names, arg2) = arg3;
    }

    public fun set_tier_thresholds(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u64>) {
        cfg_mut(arg1).tier_thresholds = arg2;
    }

    public fun set_weights(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) {
        let v0 = cfg_mut(arg1);
        v0.weight_xp = arg2;
        v0.weight_cosmetic = arg3;
    }

    public fun set_win_xp(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) {
        let v0 = cfg_mut(arg1);
        v0.win_xp_bonus = arg2;
        v0.win_streak_xp_cap = arg3;
    }

    public fun set_xp_rate(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64) {
        cfg_mut(arg1).xp_per_notional_bps = arg2;
    }

    fun settle(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: &vector<AchievementView>, arg4: &vector<QuestView>, arg5: u128, arg6: Trigger, arg7: u64) {
        let v0 = 0;
        while (v0 < 64) {
            let v1 = pass_achievements(arg0, arg1, arg2, arg3, arg5, arg6, arg7);
            if (!v1 && !pass_quests(arg0, arg1, arg2, arg4, arg5, arg6, arg7)) {
                break
            };
            v0 = v0 + 1;
        };
    }

    public fun take_pending(arg0: &0xc6b4f259687618fc8b1d197d372c1e209d5368f598da04216c5ddb74055095bb::access::Auth, arg1: &mut 0x2::object::UID, arg2: address) : u64 {
        let v0 = take_player(arg1, arg2);
        let v1 = if (v0.pending_mint > 18446744073709551615) {
            18446744073709551615
        } else {
            (v0.pending_mint as u64)
        };
        v0.pending_mint = v0.pending_mint - (v1 as u128);
        save_player(arg1, arg2, v0);
        v1
    }

    fun take_player(arg0: &mut 0x2::object::UID, arg1: address) : Player {
        let v0 = book_mut(arg0);
        if (!0x2::table::contains<address, Player>(&v0.players, arg1)) {
            empty_player()
        } else {
            *0x2::table::borrow<address, Player>(&v0.players, arg1)
        }
    }

    public fun tier_name(arg0: &0x2::object::UID, arg1: u64) : vector<u8> {
        *0x1::vector::borrow<vector<u8>>(&cfg(arg0).tier_names, arg1)
    }

    fun tier_of(arg0: u64, arg1: &vector<u64>) : u8 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg1)) {
            if (arg0 >= *0x1::vector::borrow<u64>(arg1, v1)) {
                v0 = (v1 as u8) + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    public fun tier_threshold(arg0: &0x2::object::UID, arg1: u64) : u64 {
        *0x1::vector::borrow<u64>(&cfg(arg0).tier_thresholds, arg1)
    }

    fun trigger_none() : Trigger {
        Trigger{
            on_close  : false,
            loss      : 0,
            profit    : 0,
            leverage  : 0,
            margin    : 0,
            wash      : false,
            fees_paid : false,
        }
    }

    fun unlock_cosmetic(arg0: &mut Player, arg1: address, arg2: 0x1::option::Option<u8>, arg3: u128) {
        if (0x1::option::is_none<u8>(&arg2)) {
            return
        };
        let v0 = *0x1::option::borrow<u8>(&arg2);
        if (!bit_on(arg3, v0) || bit_on(arg0.cosmetics, v0)) {
            return
        };
        arg0.cosmetics = set_bit(arg0.cosmetics, v0);
        0xeefb072be28e54d2fa35b350557d3238bf3016811569500c1fdc59fccd22953e::game_events::emit_cosmetic_unlocked_event(arg1, v0);
    }

    public fun wallet_mint_cap(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).wallet_mint_cap
    }

    public fun win_mint(arg0: &0x2::object::UID) : u64 {
        0
    }

    public fun xp_per_notional_bps(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).xp_per_notional_bps
    }

    // decompiled from Move bytecode v7
}

