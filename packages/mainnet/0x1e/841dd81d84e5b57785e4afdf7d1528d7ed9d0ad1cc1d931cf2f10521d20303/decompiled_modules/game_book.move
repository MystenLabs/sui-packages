module 0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_book {
    struct GameConfigKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GameBookKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GameConfig has store, key {
        id: 0x2::object::UID,
        enabled: bool,
        tier_thresholds: vector<u64>,
        tier_names: vector<vector<u8>>,
        daily_base: u64,
        daily_step: u64,
        daily_max: u64,
        daily_streak_cap: u64,
        win_xp_bonus: u64,
        win_streak_xp_cap: u64,
        crate_xp: u64,
        weight_xp: u64,
        weight_cosmetic: u64,
        xp_per_crate: u64,
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

    struct XpEffects has copy, drop, store {
        xp: u64,
        ms: u64,
        in_season: bool,
        rate: u64,
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
        markets: vector<0x2::object::ID>,
        season_rewarded: u64,
        trades: u64,
        fee_credit: u64,
        fee_credit_used: u64,
        pending_mint: u128,
        issuance_day: u64,
        issued_today: u64,
        fee_xp_basis: u64,
        xp_day: u64,
        day_volume: u64,
        day_volume_xp: u64,
        day_win_xp: u64,
        market_day_xp: vector<MarketXp>,
        genuine_closes: u64,
        genuine_volume: u64,
        realized_gain: u64,
        realized_loss: u64,
        crates_opened: u64,
        quests_completed: u64,
        effects: XpEffects,
    }

    struct MarketXp has copy, drop, store {
        market: 0x2::object::ID,
        xp: u64,
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
        crate_weights: vector<u64>,
        achievement_index: vector<vector<AchievementView>>,
        quest_index: vector<vector<QuestView>>,
        cosmetic_mask: u128,
    }

    struct Rules has copy, drop {
        enabled: bool,
        tier_thresholds: vector<u64>,
        daily_base: u64,
        daily_step: u64,
        daily_max: u64,
        daily_streak_cap: u64,
        win_xp_bonus: u64,
        win_streak_xp_cap: u64,
        xp_per_crate: u64,
        season_id: u64,
        season_start_ms: u64,
        season_end_ms: u64,
        wallet_mint_cap: u64,
        global_mint_cap: u64,
        achievement_mint_fraction_bps: u64,
        defer_effects: bool,
    }

    struct AchievementView has copy, drop, store {
        id: u8,
        param: u64,
        xp: u64,
        mint_amount: u64,
        cosmetic: 0x1::option::Option<u8>,
    }

    struct QuestView has copy, drop, store {
        id: u8,
        param: u64,
        xp: u64,
        cosmetic: 0x1::option::Option<u8>,
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

    struct Progress has copy, drop {
        xp: u64,
        quests_completed: u64,
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

    public fun add_achievement(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: 0x1::option::Option<u8>) : u8 {
        assert!(achievement_count(arg1) < 128, 13835623161310281746);
        assert!(name_ok(&arg2) && param_ok(arg3, arg4), 13835341690628407312);
        assert!(arg5 <= 1000000000, 13835341694923374608);
        assert!(arg6 == 0 || arg3 == 8, 13835341699218341904);
        assert!(cosmetic_known(arg1, &arg7), 13835904653466992660);
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
        let v3 = 0x1::vector::borrow_mut<vector<AchievementView>>(&mut v0.achievement_index, (arg3 as u64));
        let v4 = 0;
        while (v4 < 0x1::vector::length<AchievementView>(v3) && (0x1::vector::borrow<AchievementView>(v3, v4).param < arg4 || 0x1::vector::borrow<AchievementView>(v3, v4).param == arg4 && 0x1::vector::borrow<AchievementView>(v3, v4).id < v1)) {
            v4 = v4 + 1;
        };
        let v5 = AchievementView{
            id          : v1,
            param       : arg4,
            xp          : arg5,
            mint_amount : arg6,
            cosmetic    : arg7,
        };
        0x1::vector::insert<AchievementView>(v3, v5, v4);
        v1
    }

    public fun add_cosmetic(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>) : u8 {
        assert!(cosmetic_count(arg1) < 128, 13835623582217076754);
        assert!(name_ok(&arg2), 13835342111535202320);
        let v0 = book_mut(arg1);
        let v1 = (0x1::vector::length<u8>(&v0.cosmetic_ids) as u8);
        0x1::vector::push_back<u8>(&mut v0.cosmetic_ids, v1);
        let v2 = CosmeticDef{name: arg2};
        0x2::table::add<u8, CosmeticDef>(&mut v0.cosmetics, v1, v2);
        v0.cosmetic_mask = set_bit(v0.cosmetic_mask, v1);
        v1
    }

    public fun add_quest(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>, arg3: u8, arg4: u64, arg5: u64, arg6: 0x1::option::Option<u8>, arg7: u64, arg8: u64, arg9: u64) : u8 {
        assert!(quest_count(arg1) < 128, 13835623414713352210);
        assert!(name_ok(&arg2) && param_ok(arg3, arg4), 13835341944031477776);
        assert!(arg5 <= 1000000000, 13835341948326445072);
        assert!(arg8 == 0 || arg8 > arg7, 13835341952621412368);
        assert!(cosmetic_known(arg1, &arg6), 13835904906870063124);
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
        let v3 = 0x1::vector::borrow_mut<vector<QuestView>>(&mut v0.quest_index, (arg3 as u64));
        let v4 = 0;
        while (v4 < 0x1::vector::length<QuestView>(v3) && (0x1::vector::borrow<QuestView>(v3, v4).param < arg4 || 0x1::vector::borrow<QuestView>(v3, v4).param == arg4 && 0x1::vector::borrow<QuestView>(v3, v4).id < v1)) {
            v4 = v4 + 1;
        };
        let v5 = QuestView{
            id        : v1,
            param     : arg4,
            xp        : arg5,
            cosmetic  : arg6,
            start_ms  : arg7,
            end_ms    : arg8,
            season_id : arg9,
        };
        0x1::vector::insert<QuestView>(v3, v5, v4);
        v1
    }

    public(friend) fun apply_pending_effects(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address) {
        if (!has_player(arg1, arg3)) {
            return
        };
        let v0 = 0x2::table::borrow<address, Player>(&book(arg1).players, arg3);
        if (v0.effects.xp == v0.xp) {
            return
        };
        let v1 = rules(arg2);
        let v2 = take_player(arg1, arg3);
        let v3 = &mut v2;
        settle_deferred(v3, arg3, &v1, book(arg1));
        save_player(arg1, arg3, v2);
    }

    fun apply_xp(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: u64, arg4: u8, arg5: u64) {
        if (arg3 == 0) {
            return
        };
        credit_xp(arg0, arg2, arg3, arg5);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_xp_granted_event(arg1, arg3, arg4, arg0.xp, arg0.season_xp, arg0.season_id);
        if (!arg2.defer_effects) {
            xp_effects(arg0, arg1, arg2);
        };
    }

    public fun attach<T0>(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config, arg2: &mut 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::Exchange<T0>, arg3: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::AuthorityCap<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::PACKAGE, 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::ADMIN>, arg4: &mut 0x2::tx_context::TxContext) {
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::assert_version(arg1);
        0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::authority::assert_admin(0x2::object::id<0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::Config>(arg1), arg3);
        let v0 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::exchange::uid_mut<T0>(arg0, arg2);
        let v1 = GameBookKey{dummy_field: false};
        assert!(!0x2::dynamic_object_field::exists<GameBookKey>(v0, v1), 13835059120434905102);
        attach_book(v0, arg4);
        let v2 = 0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::config::uid_mut(arg0, arg1);
        let v3 = GameConfigKey{dummy_field: false};
        if (!0x2::dynamic_object_field::exists<GameConfigKey>(v2, v3)) {
            attach_config(v2, arg4);
        };
    }

    public fun attach_book(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::empty<vector<AchievementView>>();
        let v1 = 0;
        while (v1 < 14) {
            0x1::vector::push_back<vector<AchievementView>>(&mut v0, 0x1::vector::empty<AchievementView>());
            v1 = v1 + 1;
        };
        let v2 = 0x1::vector::empty<vector<QuestView>>();
        let v3 = 0;
        while (v3 < 14) {
            0x1::vector::push_back<vector<QuestView>>(&mut v2, 0x1::vector::empty<QuestView>());
            v3 = v3 + 1;
        };
        let v4 = GameBookKey{dummy_field: false};
        let v5 = GameBook{
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
            crate_weights       : vector[],
            achievement_index   : v0,
            quest_index         : v2,
            cosmetic_mask       : 0,
        };
        0x2::dynamic_object_field::add<GameBookKey, GameBook>(arg0, v4, v5);
    }

    public fun attach_config(arg0: &mut 0x2::object::UID, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = GameConfigKey{dummy_field: false};
        let v1 = GameConfig{
            id                            : 0x2::object::new(arg1),
            enabled                       : false,
            tier_thresholds               : vector[6000, 661500, 11353500, 58806000, 259584000, 764694000],
            tier_names                    : default_names(),
            daily_base                    : 100,
            daily_step                    : 10,
            daily_max                     : 300,
            daily_streak_cap              : 30,
            win_xp_bonus                  : 500,
            win_streak_xp_cap             : 10,
            crate_xp                      : 2500,
            weight_xp                     : 30,
            weight_cosmetic               : 20,
            xp_per_crate                  : 100000,
            max_season_reward             : 1000000000,
            season_id                     : 0,
            season_start_ms               : 0,
            season_end_ms                 : 0,
            max_xp_grant                  : 100000000,
            wallet_mint_cap               : 5000000000,
            global_mint_cap               : 1000000000000,
            achievement_mint_fraction_bps : 2500,
        };
        0x2::dynamic_object_field::add<GameConfigKey, GameConfig>(arg0, v0, v1);
    }

    public fun award(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u8, arg5: u64) : u8 {
        if (!achievement_exists(arg1, arg4)) {
            return 6
        };
        let v0 = rules(arg2);
        let v1 = *0x2::table::borrow<u8, AchievementDef>(&book(arg1).achievements, arg4);
        if (!v1.active) {
            return 4
        };
        let v2 = take_player(arg1, arg3);
        if (bit_on(v2.achievements, arg4)) {
            return 5
        };
        if (!manual_award_ok(v1.kind, v1.mint_amount)) {
            return 1
        };
        let v3 = &mut v2;
        settle_deferred(v3, arg3, &v0, book(arg1));
        if (bit_on(v2.achievements, arg4)) {
            save_player(arg1, arg3, v2);
            return 0
        };
        v2.achievements = set_bit(v2.achievements, arg4);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_achievement_unlocked_event(arg3, arg4);
        if (v1.xp > 0) {
            let v4 = &mut v2;
            apply_xp(v4, arg3, &v0, v1.xp, 2, arg5);
        };
        let v5 = &mut v2;
        unlock_cosmetic(v5, arg3, &v0, v1.cosmetic, book(arg1).cosmetic_mask);
        let v6 = &mut v2;
        settle(v6, arg3, &v0, book(arg1), trigger_none(), 0, progress(&v2), arg5);
        save_player(arg1, arg3, v2);
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
        arg1 < 128 && arg0 >> arg1 & 1 == 1
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

    public fun claim_quest(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u8, arg5: u64, arg6: bool) : u8 {
        if (!quest_exists(arg1, arg4)) {
            return 6
        };
        let v0 = rules(arg2);
        let v1 = *0x2::table::borrow<u8, QuestDef>(&book(arg1).quests, arg4);
        let v2 = take_player(arg1, arg3);
        if (bit_on(v2.quests_done, arg4)) {
            return 5
        };
        let v3 = &mut v2;
        settle_deferred(v3, arg3, &v0, book(arg1));
        if (bit_on(v2.quests_done, arg4)) {
            save_player(arg1, arg3, v2);
            return 0
        };
        if (!v1.active) {
            return 4
        };
        if (!in_window(v1.start_ms, v1.end_ms, arg5) || !season_ok(v1.season_id, v0.season_id)) {
            return 7
        };
        let v4 = trigger_none();
        let v5 = criteria(&v2, v1.kind, v1.param, &v4) || arg6 && v1.kind == 7;
        if (!v5) {
            return 1
        };
        let v6 = &mut v2;
        complete_quest(v6, arg3, &v0, arg4, v1.xp, v1.cosmetic, book(arg1).cosmetic_mask, arg5);
        let v7 = &mut v2;
        settle(v7, arg3, &v0, book(arg1), trigger_none(), 0, progress(&v2), arg5);
        save_player(arg1, arg3, v2);
        0
    }

    public fun commit_daily(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        let v0 = rules(arg2);
        let v1 = take_player(arg1, arg3);
        let v2 = &mut v1;
        settle_deferred(v2, arg3, &v0, book(arg1));
        v1.streak = arg5;
        v1.last_daily_day = arg4;
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_daily_claimed_event(arg3, arg5, arg6, arg4);
        let v3 = &mut v1;
        apply_xp(v3, arg3, &v0, arg6 * 10, 5, arg7);
        let v4 = &mut v1;
        settle(v4, arg3, &v0, book(arg1), trigger_none(), 64, progress(&v1), arg7);
        save_player(arg1, arg3, v1);
    }

    fun complete_quest(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: u8, arg4: u64, arg5: 0x1::option::Option<u8>, arg6: u128, arg7: u64) {
        arg0.quests_done = set_bit(arg0.quests_done, arg3);
        arg0.quests_completed = sat_add(arg0.quests_completed, 1);
        apply_xp(arg0, arg1, arg2, arg4, 3, arg7);
        unlock_cosmetic(arg0, arg1, arg2, arg5, arg6);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_quest_completed_event(arg1, arg3, arg4, 0);
    }

    public fun cosmetic_count(arg0: &0x2::object::UID) : u64 {
        0x1::vector::length<u8>(&book(arg0).cosmetic_ids)
    }

    public fun cosmetic_exists(arg0: &0x2::object::UID, arg1: u8) : bool {
        0x2::table::contains<u8, CosmeticDef>(&book(arg0).cosmetics, arg1)
    }

    fun cosmetic_known(arg0: &0x2::object::UID, arg1: &0x1::option::Option<u8>) : bool {
        0x1::option::is_none<u8>(arg1) || cosmetic_exists(arg0, *0x1::option::borrow<u8>(arg1))
    }

    public fun crate_outcome(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : (u64, u64) {
        let v0 = ge_bit(arg0, arg1) * arg2 * (1 - arg3);
        (v0, arg4 * (1 - v0))
    }

    public fun crate_pool(arg0: &0x2::object::UID) : (vector<u8>, vector<u64>) {
        let v0 = book(arg0);
        (v0.crate_cosmetics, v0.crate_weights)
    }

    public fun crate_weights(arg0: &0x2::object::UID) : (u64, u64) {
        let v0 = cfg(arg0);
        (v0.weight_xp, v0.weight_cosmetic)
    }

    public fun crate_xp(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).crate_xp
    }

    public fun crate_xp_ok(arg0: u64, arg1: u64) : bool {
        arg1 == 0 || arg0 < arg1
    }

    fun credit_xp(arg0: &mut Player, arg1: &Rules, arg2: u64, arg3: u64) {
        if (arg0.season_id != arg1.season_id) {
            arg0.season_xp = 0;
            arg0.season_id = arg1.season_id;
        };
        arg0.xp = sat_add(arg0.xp, arg2);
        if (in_season(arg1, arg3)) {
            arg0.season_xp = sat_add(arg0.season_xp, arg2);
        };
    }

    fun criteria(arg0: &Player, arg1: u8, arg2: u64, arg3: &Trigger) : bool {
        let v0 = if (arg1 == 2) {
            true
        } else if (arg1 == 3) {
            true
        } else {
            arg1 == 4
        };
        if (v0 && (!arg3.on_close || !0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::genuine_win(arg3.wash, arg3.profit, arg3.loss))) {
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
            arg1 == 4 && arg0.win_streak >= arg2 || arg1 == 5 && (arg0.tier as u64) >= arg2 || arg1 == 8 && arg3.fees_paid && arg0.fee_credit >= arg2 || arg1 == 6 && arg0.streak >= arg2 || arg1 == 9 && arg0.genuine_closes >= arg2 || arg1 == 10 && arg0.genuine_volume >= arg2 || arg1 == 11 && (arg0.realized_gain as u128) >= (arg0.realized_loss as u128) + (arg2 as u128) || arg1 == 12 && arg0.crates_opened >= arg2 || arg1 == 13 && arg0.quests_completed >= arg2
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
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Folio");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Sealed");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Gilded");
        0x1::vector::push_back<vector<u8>>(&mut v0, b"Illuminated");
        v0
    }

    fun draw_below(arg0: &mut 0x2::random::RandomGenerator, arg1: u64) : u64 {
        ((0x2::random::generate_u128(arg0) % (arg1 as u128)) as u64)
    }

    fun empty_player() : Player {
        let v0 = XpEffects{
            xp        : 0,
            ms        : 0,
            in_season : false,
            rate      : 0,
        };
        Player{
            xp               : 0,
            season_xp        : 0,
            season_id        : 0,
            tier             : 0,
            last_daily_day   : 0,
            streak           : 0,
            win_streak       : 0,
            achievements     : 0,
            quests_done      : 0,
            cosmetics        : 0,
            crates           : 0,
            markets          : 0x1::vector::empty<0x2::object::ID>(),
            season_rewarded  : 0,
            trades           : 0,
            fee_credit       : 0,
            fee_credit_used  : 0,
            pending_mint     : 0,
            issuance_day     : 0,
            issued_today     : 0,
            fee_xp_basis     : 0,
            xp_day           : 0,
            day_volume       : 0,
            day_volume_xp    : 0,
            day_win_xp       : 0,
            market_day_xp    : 0x1::vector::empty<MarketXp>(),
            genuine_closes   : 0,
            genuine_volume   : 0,
            realized_gain    : 0,
            realized_loss    : 0,
            crates_opened    : 0,
            quests_completed : 0,
            effects          : v0,
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
        } else if (arg2 == 7) {
            v0.genuine_closes
        } else if (arg2 == 8) {
            v0.genuine_volume
        } else if (arg2 == 10) {
            v0.season_rewarded
        } else if (arg2 == 11) {
            v0.realized_gain
        } else if (arg2 == 12) {
            v0.realized_loss
        } else if (arg2 == 13) {
            v0.crates_opened
        } else if (arg2 == 14) {
            v0.quests_completed
        } else if (arg2 == 15) {
            v0.season_id
        } else {
            0
        }
    }

    public fun ge_bit(arg0: u64, arg1: u64) : u64 {
        (((arg0 as u128) + 18446744073709551616 - (arg1 as u128) >> 64) as u64)
    }

    public fun genuine_close(arg0: bool, arg1: bool, arg2: u64, arg3: u64) : bool {
        if (arg0) {
            if (!arg1) {
                if (arg2 >= 60000) {
                    arg3 > 0
                } else {
                    false
                }
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun global_mint_cap(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).global_mint_cap
    }

    public fun global_minted(arg0: &0x2::object::UID) : u64 {
        book(arg0).global_issued
    }

    fun grant_fee_xp(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: u64) {
        let v0 = 100;
        let v1 = arg0.fee_credit / v0 - arg0.fee_xp_basis / v0;
        arg0.fee_xp_basis = arg0.fee_credit;
        apply_xp(arg0, arg1, arg2, v1, 6, arg3);
    }

    fun grant_volume_xp(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: 0x2::object::ID, arg4: u64, arg5: u64) {
        let v0 = arg0.day_volume;
        arg0.day_volume = sat_add(v0, arg4);
        let v1 = volume_band_xp(arg0.day_volume) - volume_band_xp(v0);
        let v2 = 0;
        let v3 = 0x1::vector::length<MarketXp>(&arg0.market_day_xp);
        while (v2 < v3 && 0x1::vector::borrow<MarketXp>(&arg0.market_day_xp, v2).market != arg3) {
            v2 = v2 + 1;
        };
        if (v2 == v3) {
            let v4 = MarketXp{
                market : arg3,
                xp     : 0,
            };
            0x1::vector::push_back<MarketXp>(&mut arg0.market_day_xp, v4);
        };
        let v5 = 40000 - 0x1::vector::borrow<MarketXp>(&arg0.market_day_xp, v2).xp;
        let v6 = 100000 - arg0.day_volume_xp;
        let v7 = if (v1 < v5) {
            v1
        } else {
            v5
        };
        let v8 = v7;
        if (v7 > v6) {
            v8 = v6;
        };
        let v9 = 0x1::vector::borrow_mut<MarketXp>(&mut arg0.market_day_xp, v2);
        v9.xp = v9.xp + v8;
        arg0.day_volume_xp = arg0.day_volume_xp + v8;
        apply_xp(arg0, arg1, arg2, v8, 0, arg5);
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

    public fun indexed_achievements(arg0: &0x2::object::UID, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::borrow<vector<AchievementView>>(&book(arg0).achievement_index, (arg1 as u64));
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<AchievementView>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, 0x1::vector::borrow<AchievementView>(v0, v2).id);
            v2 = v2 + 1;
        };
        v1
    }

    public fun indexed_quests(arg0: &0x2::object::UID, arg1: u8) : vector<u8> {
        let v0 = 0x1::vector::borrow<vector<QuestView>>(&book(arg0).quest_index, (arg1 as u64));
        let v1 = b"";
        let v2 = 0;
        while (v2 < 0x1::vector::length<QuestView>(v0)) {
            0x1::vector::push_back<u8>(&mut v1, 0x1::vector::borrow<QuestView>(v0, v2).id);
            v2 = v2 + 1;
        };
        v1
    }

    public fun issue(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u64, arg5: u64, arg6: u64) : u64 {
        let v0 = rules(arg2);
        let v1 = 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::utc_day(arg5);
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
        let v4 = 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::take_capped(arg4, v2.issued_today, v0.wallet_mint_cap, v3.global_issued, v0.global_mint_cap);
        let v5 = if (v4 < arg6) {
            v4
        } else {
            arg6
        };
        v2.issued_today = v2.issued_today + v5;
        v3.global_issued = v3.global_issued + v5;
        v2.pending_mint = v2.pending_mint + ((arg4 - v5) as u128);
        save_player(arg1, arg3, v2);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_game_reward_issued_event(arg3, v5, v1, v2.pending_mint);
        v5
    }

    public fun manual_award_ok(arg0: u8, arg1: u64) : bool {
        if (arg1 == 0) {
            if (arg0 != 2) {
                if (arg0 != 3) {
                    if (arg0 != 4) {
                        if (arg0 != 9) {
                            if (arg0 != 10) {
                                if (arg0 != 11) {
                                    if (arg0 != 12) {
                                        arg0 != 13
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
                        }
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
        }
    }

    public fun mark_season_rewarded(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64) {
        assert!(arg3 != 0, 13835344151644667920);
        let v0 = take_player(arg1, arg2);
        v0.season_rewarded = arg3;
        save_player(arg1, arg2, v0);
    }

    public fun max_season_reward(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).max_season_reward
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

    fun name_ok(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) >= 1 && 0x1::vector::length<u8>(arg0) <= 32
    }

    public fun note_close(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: 0x1::option::Option<0x2::object::ID>, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: u64, arg12: bool, arg13: u64, arg14: u64) {
        let v0 = rules(arg2);
        let v1 = take_player(arg1, arg3);
        if (v0.enabled) {
            let v2 = &mut v1;
            settle_deferred(v2, arg3, &v0, book(arg1));
        };
        v1.fee_credit = sat_add(v1.fee_credit, arg13);
        if (arg13 > 0) {
            0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_fee_credit_event(arg3, v1.fee_credit, v1.fee_credit_used);
        };
        let v3 = genuine_close(0x1::option::is_some<0x2::object::ID>(&arg4), arg12, arg6, arg5);
        if (v3) {
            v1.genuine_closes = sat_add(v1.genuine_closes, 1);
            v1.genuine_volume = sat_add(v1.genuine_volume, arg5);
        };
        if (v0.enabled) {
            let v4 = &mut v1;
            roll_xp_day(v4, 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::utc_day(arg14));
            let v5 = &mut v1;
            grant_fee_xp(v5, arg3, &v0, arg14);
            if (v3) {
                let v6 = &mut v1;
                grant_volume_xp(v6, arg3, &v0, *0x1::option::borrow<0x2::object::ID>(&arg4), arg5, arg14);
            };
            if (arg7 > 0 && v1.win_streak != 0) {
                v1.win_streak = 0;
                0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_win_streak_event(arg3, 0);
            };
            if (0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::genuine_win(arg12, arg8, arg7)) {
                v1.win_streak = sat_add(v1.win_streak, 1);
                0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_win_streak_event(arg3, v1.win_streak);
                if (arg9 >= 10000000) {
                    let v7 = if (v1.win_streak > v0.win_streak_xp_cap) {
                        v0.win_streak_xp_cap
                    } else {
                        v1.win_streak
                    };
                    let v8 = 20000 - v1.day_win_xp;
                    let v9 = v7 * v0.win_xp_bonus;
                    let v10 = if (v9 > v8) {
                        v8
                    } else {
                        v9
                    };
                    v1.day_win_xp = v1.day_win_xp + v10;
                    let v11 = &mut v1;
                    apply_xp(v11, arg3, &v0, v10, 1, arg14);
                };
            };
            let v12 = Trigger{
                on_close  : true,
                loss      : arg7,
                profit    : arg8,
                leverage  : arg10,
                margin    : arg11,
                wash      : arg12,
                fees_paid : arg13 > 0,
            };
            let v13 = if (0x1::option::is_some<0x2::object::ID>(&arg4)) {
                3868
            } else {
                2304
            };
            let v14 = &mut v1;
            settle(v14, arg3, &v0, book(arg1), v12, v13, progress(&v1), arg14);
        };
        if (v1.fee_credit_used != v1.fee_credit_used) {
            0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_fee_credit_event(arg3, v1.fee_credit, v1.fee_credit_used);
        };
        save_player(arg1, arg3, v1);
    }

    public fun note_fee_credit(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64) {
        if (arg3 == 0) {
            return
        };
        let v0 = take_player(arg1, arg2);
        v0.fee_credit = sat_add(v0.fee_credit, arg3);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_fee_credit_event(arg2, v0.fee_credit, v0.fee_credit_used);
        save_player(arg1, arg2, v0);
    }

    public fun note_harvest_gain(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u64, arg5: bool, arg6: u64) {
        note_pnl(arg1, arg3, arg4, 0);
        if (arg4 == 0 || !arg5) {
            return
        };
        let v0 = rules(arg2);
        if (!v0.enabled) {
            return
        };
        let v1 = take_player(arg1, arg3);
        let v2 = &mut v1;
        settle_deferred(v2, arg3, &v0, book(arg1));
        let v3 = &mut v1;
        settle(v3, arg3, &v0, book(arg1), trigger_none(), 2048, progress(&v1), arg6);
        save_player(arg1, arg3, v1);
    }

    public fun note_liquidation_loss(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64) {
        note_pnl(arg1, arg2, 0, arg3);
    }

    public fun note_open(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: 0x2::object::ID, arg5: u64) {
        let v0 = rules(arg2);
        let v1 = take_player(arg1, arg3);
        let v2 = &mut v1;
        settle_deferred(v2, arg3, &v0, book(arg1));
        v1.trades = sat_add(v1.trades, 1);
        let v3 = &mut v1;
        remember_market(v3, arg4);
        let v4 = &mut v1;
        settle(v4, arg3, &v0, book(arg1), trigger_none(), 3, progress(&v1), arg5);
        save_player(arg1, arg3, v1);
    }

    public fun note_open_fee(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64) {
        note_pnl(arg1, arg2, 0, arg3);
    }

    fun note_pnl(arg0: &mut 0x2::object::UID, arg1: address, arg2: u64, arg3: u64) {
        if (arg2 == 0 && arg3 == 0) {
            return
        };
        let v0 = take_player(arg0, arg1);
        v0.realized_gain = sat_add(v0.realized_gain, arg2);
        v0.realized_loss = sat_add(v0.realized_loss, arg3);
        save_player(arg0, arg1, v0);
    }

    public fun note_trade_close(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: address, arg3: u64, arg4: 0x2::object::ID, arg5: u64, arg6: u64, arg7: bool, arg8: bool, arg9: u64, arg10: u64) {
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_close_xp_event(arg2, arg3, arg4, arg5, arg6, arg7, genuine_close(true, arg7, arg6, arg5), arg8);
        note_pnl(arg1, arg2, arg9, arg10);
    }

    public(friend) fun open_crates(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u64, arg5: &mut 0x2::random::RandomGenerator, arg6: u64) {
        let v0 = rules(arg2);
        v0.defer_effects = true;
        let (v1, v2) = crate_weights(arg2);
        let v3 = take_player(arg1, arg3);
        let v4 = book(arg1);
        let v5 = &v4.crate_cosmetics;
        let v6 = &v4.crate_weights;
        let v7 = 0x1::vector::length<u8>(v5);
        let v8 = 0;
        let v9 = 0;
        while (v9 < 0x1::vector::length<u64>(v6)) {
            v8 = v8 + *0x1::vector::borrow<u64>(v6, v9);
            v9 = v9 + 1;
        };
        let v10 = ge_bit(v7, 1);
        let v11 = 0;
        while (v11 < arg4) {
            let v12 = draw_below(arg5, v1 + v2);
            let v13 = if (v7 == 0) {
                0
            } else {
                *0x1::vector::borrow<u8>(v5, weighted_index(v6, draw_below(arg5, v8 + 1 - v10)))
            };
            let (v14, v15) = crate_outcome(v12, v1, v10, ((v3.cosmetics >> v13 & 1) as u64), crate_xp(arg2));
            v3.crates = v3.crates - 1;
            v3.crates_opened = sat_add(v3.crates_opened, 1);
            let v16 = &mut v3;
            credit_xp(v16, &v0, v15, arg6);
            v3.cosmetics = v3.cosmetics | ((v14 * ((v4.cosmetic_mask >> v13 & 1) as u64)) as u128) << v13;
            0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_crate_opened_event(arg3, ((1 + v14) as u8), v15, (((v13 as u64) * v14) as u8), v3.xp, v3.season_xp, v3.season_id);
            let v17 = &mut v3;
            settle(v17, arg3, &v0, v4, trigger_none(), 4096 | 1 << 5, progress(&v3), arg6);
            v11 = v11 + 1;
        };
        v3.effects.ms = arg6;
        v3.effects.in_season = in_season(&v0, arg6);
        v3.effects.rate = v0.xp_per_crate;
        save_player(arg1, arg3, v3);
    }

    public fun owns_cosmetic(arg0: &0x2::object::UID, arg1: address, arg2: u8) : bool {
        has_player(arg0, arg1) && bit_on(0x2::table::borrow<address, Player>(&book(arg0).players, arg1).cosmetics, arg2)
    }

    public fun param_ok(arg0: u8, arg1: u64) : bool {
        arg0 == 0 || arg0 == 7 || arg0 == 1 && arg1 >= 1 && arg1 <= 16 || arg0 == 2 && arg1 >= 1 && arg1 <= 10000 || arg0 == 3 && arg1 >= 1 && arg1 <= 1000000 || (arg0 == 4 || arg0 == 6) && arg1 >= 1 && arg1 <= 10000 || arg0 == 8 && arg1 > 0 || arg0 == 5 && arg1 >= 1 && arg1 <= 32 || arg0 == 9 && arg1 >= 1 && arg1 <= 1000000000 || (arg0 == 10 || arg0 == 11) && arg1 >= 1 || arg0 == 12 && arg1 >= 10 && arg1 <= 10000 || arg0 == 13 && arg1 >= 10 && arg1 <= 128
    }

    fun pass_achievements(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: &GameBook, arg4: u64, arg5: Trigger, arg6: u64) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 14) {
            if (arg4 >> (v1 as u8) & 1 == 1) {
                let v2 = 0x1::vector::borrow<vector<AchievementView>>(&arg3.achievement_index, v1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<AchievementView>(v2)) {
                    let v4 = 0x1::vector::borrow<AchievementView>(v2, v3);
                    v3 = v3 + 1;
                    if (bit_on(arg0.achievements, v4.id)) {
                        continue
                    };
                    if (!criteria(arg0, (v1 as u8), v4.param, &arg5)) {
                        break
                    };
                    let v5 = if (v1 == 8) {
                        if (v4.mint_amount > 0) {
                            arg2.achievement_mint_fraction_bps == 0
                        } else {
                            false
                        }
                    } else {
                        false
                    };
                    if (v5) {
                        continue
                    };
                    if (v1 == 8 && v4.mint_amount > 0) {
                        let v6 = v4.mint_amount;
                        if (0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::achievement_mint_allowance(arg0.fee_credit - arg0.fee_credit_used, arg2.achievement_mint_fraction_bps, v6) < v6) {
                            continue
                        };
                        arg0.fee_credit_used = arg0.fee_credit_used + 0x2817956d7c935e4b4e6ee09688d40889ad78b2b7303a572ccff2a49476eb07de::safety::achievement_credit_cost(v6, arg2.achievement_mint_fraction_bps);
                        arg0.pending_mint = arg0.pending_mint + (v6 as u128);
                        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_reward_minted_event(arg1, v6, 4);
                    };
                    arg0.achievements = set_bit(arg0.achievements, v4.id);
                    0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_achievement_unlocked_event(arg1, v4.id);
                    if (v4.xp > 0) {
                        apply_xp(arg0, arg1, arg2, v4.xp, 2, arg6);
                    };
                    unlock_cosmetic(arg0, arg1, arg2, v4.cosmetic, arg3.cosmetic_mask);
                    v0 = true;
                };
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun pass_quests(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: &GameBook, arg4: u64, arg5: Trigger, arg6: u64) : bool {
        let v0 = false;
        let v1 = 0;
        while (v1 < 14) {
            if (arg4 >> (v1 as u8) & 1 == 1) {
                let v2 = 0x1::vector::borrow<vector<QuestView>>(&arg3.quest_index, v1);
                let v3 = 0;
                while (v3 < 0x1::vector::length<QuestView>(v2)) {
                    let v4 = 0x1::vector::borrow<QuestView>(v2, v3);
                    v3 = v3 + 1;
                    if (bit_on(arg0.quests_done, v4.id)) {
                        continue
                    };
                    if (!in_window(v4.start_ms, v4.end_ms, arg6) || !season_ok(v4.season_id, arg2.season_id)) {
                        continue
                    };
                    if (!criteria(arg0, (v1 as u8), v4.param, &arg5)) {
                        break
                    };
                    complete_quest(arg0, arg1, arg2, v4.id, v4.xp, v4.cosmetic, arg3.cosmetic_mask, arg6);
                    v0 = true;
                };
            };
            v1 = v1 + 1;
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

    public fun player_crates_opened(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 13)
    }

    public fun player_current_season_xp(arg0: &0x2::object::UID, arg1: &0x2::object::UID, arg2: address) : u64 {
        let (v0, _, _) = season(arg0);
        if (player_season_id(arg1, arg2) == v0) {
            player_season_xp(arg1, arg2)
        } else {
            0
        }
    }

    public fun player_genuine_closes(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 7)
    }

    public fun player_genuine_volume(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 8)
    }

    public fun player_quests_completed(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 14)
    }

    public fun player_realized_gain(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 11)
    }

    public fun player_realized_loss(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 12)
    }

    public fun player_season_id(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 15)
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

    public fun player_trades(arg0: &0x2::object::UID, arg1: address) : u64 {
        field_u64(arg0, arg1, 6)
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

    fun progress(arg0: &Player) : Progress {
        Progress{
            xp               : arg0.xp,
            quests_completed : arg0.quests_completed,
        }
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

    fun remember_market(arg0: &mut Player, arg1: 0x2::object::ID) {
        if (0x1::vector::contains<0x2::object::ID>(&arg0.markets, &arg1)) {
            return
        };
        if (0x1::vector::length<0x2::object::ID>(&arg0.markets) < 16) {
            0x1::vector::push_back<0x2::object::ID>(&mut arg0.markets, arg1);
        };
    }

    public fun roll_season(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) : u64 {
        assert!(arg3 > arg2 && arg3 - arg2 <= 31622400000, 13835341441520304144);
        assert!(cfg(arg1).season_id < 18446744073709551615, 13835341445815271440);
        let v0 = cfg_mut(arg1);
        let v1 = v0.season_id + 1;
        v0.season_id = v1;
        v0.season_start_ms = arg2;
        v0.season_end_ms = arg3;
        v1
    }

    fun roll_xp_day(arg0: &mut Player, arg1: u64) {
        if (arg0.xp_day == arg1) {
            return
        };
        arg0.xp_day = arg1;
        arg0.day_volume = 0;
        arg0.day_volume_xp = 0;
        arg0.day_win_xp = 0;
        arg0.market_day_xp = 0x1::vector::empty<MarketXp>();
    }

    fun rules(arg0: &0x2::object::UID) : Rules {
        let v0 = cfg(arg0);
        Rules{
            enabled                       : v0.enabled,
            tier_thresholds               : v0.tier_thresholds,
            daily_base                    : v0.daily_base,
            daily_step                    : v0.daily_step,
            daily_max                     : v0.daily_max,
            daily_streak_cap              : v0.daily_streak_cap,
            win_xp_bonus                  : v0.win_xp_bonus,
            win_streak_xp_cap             : v0.win_streak_xp_cap,
            xp_per_crate                  : v0.xp_per_crate,
            season_id                     : v0.season_id,
            season_start_ms               : v0.season_start_ms,
            season_end_ms                 : v0.season_end_ms,
            wallet_mint_cap               : v0.wallet_mint_cap,
            global_mint_cap               : v0.global_mint_cap,
            achievement_mint_fraction_bps : v0.achievement_mint_fraction_bps,
            defer_effects                 : false,
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

    fun scan_mask(arg0: &Player, arg1: u64, arg2: &Progress) : u64 {
        arg1 | 1 - ge_bit(arg2.xp, arg0.xp) << 5 | 1 - ge_bit(arg2.quests_completed, arg0.quests_completed) << 13
    }

    public fun season(arg0: &0x2::object::UID) : (u64, u64, u64) {
        let v0 = cfg(arg0);
        (v0.season_id, v0.season_start_ms, v0.season_end_ms)
    }

    fun season_ok(arg0: u64, arg1: u64) : bool {
        arg0 == 0 || arg0 == arg1
    }

    public fun set_achievement_active(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u8, arg3: bool) {
        let v0 = book_mut(arg1);
        let v1 = 0x2::table::borrow_mut<u8, AchievementDef>(&mut v0.achievements, arg2);
        if (v1.active == arg3) {
            return
        };
        v1.active = arg3;
        let v2 = *v1;
        let v3 = 0x1::vector::borrow_mut<vector<AchievementView>>(&mut v0.achievement_index, (v2.kind as u64));
        if (arg3) {
            let v4 = v2.param;
            let v5 = 0;
            while (v5 < 0x1::vector::length<AchievementView>(v3) && (0x1::vector::borrow<AchievementView>(v3, v5).param < v4 || 0x1::vector::borrow<AchievementView>(v3, v5).param == v4 && 0x1::vector::borrow<AchievementView>(v3, v5).id < arg2)) {
                v5 = v5 + 1;
            };
            let v6 = AchievementView{
                id          : arg2,
                param       : v2.param,
                xp          : v2.xp,
                mint_amount : v2.mint_amount,
                cosmetic    : v2.cosmetic,
            };
            0x1::vector::insert<AchievementView>(v3, v6, v5);
        } else {
            let v7 = 0;
            /* label 18 */
            while (v7 < 0x1::vector::length<AchievementView>(v3)) {
                if (0x1::vector::borrow<AchievementView>(v3, v7).id == arg2) {
                    /* label 21 */
                    0x1::vector::remove<AchievementView>(v3, 0x1::option::destroy_some<u64>(0x1::option::some<u64>(v7)));
                    return
                } else {
                    /* goto 23 */
                };
            };
        };
        return
        /* label 23 */
        /* goto 18 */
        continue;
        /* goto 21 */
    }

    public fun set_achievement_mint_fraction_bps(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64) {
        assert!(arg2 <= 10000, 13835340917534294032);
        cfg_mut(arg1).achievement_mint_fraction_bps = arg2;
    }

    fun set_bit(arg0: u128, arg1: u8) : u128 {
        if (arg1 < 128) {
            arg0 | 1 << arg1
        } else {
            arg0
        }
    }

    public fun set_crate_params(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) {
        assert!(arg2 <= cfg(arg1).max_xp_grant, 13835341286901481488);
        assert!(arg3 <= 1000000000000000, 13835341291196448784);
        assert!(crate_xp_ok(arg2, arg3), 13835341295491416080);
        let v0 = cfg_mut(arg1);
        v0.crate_xp = arg2;
        v0.xp_per_crate = arg3;
    }

    public fun set_crate_pool(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u8>, arg3: vector<u64>) {
        assert!(0x1::vector::length<u8>(&arg2) == 0x1::vector::length<u64>(&arg3) && 0x1::vector::length<u8>(&arg2) <= 128, 13835342206024482832);
        let v0 = &arg3;
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            let v2 = 0x1::vector::borrow<u64>(v0, v1);
            assert!(*v2 >= 1 && *v2 <= 1000000, 13835342210319450128);
            v1 = v1 + 1;
        };
        let v3 = &arg2;
        let v4 = 0;
        while (v4 < 0x1::vector::length<u8>(v3)) {
            assert!(bit_on(book(arg1).cosmetic_mask, *0x1::vector::borrow<u8>(v3, v4)), 13835905177453002772);
            v4 = v4 + 1;
        };
        let v5 = book_mut(arg1);
        v5.crate_cosmetics = arg2;
        v5.crate_weights = arg3;
    }

    public fun set_daily(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = if (arg3 <= 100000000000) {
            if (arg4 <= 100000000000) {
                arg2 <= arg4
            } else {
                false
            }
        } else {
            false
        };
        assert!(v0, 13835341162347429904);
        assert!(arg5 >= 1 && arg5 <= 10000, 13835341166642397200);
        let v1 = cfg_mut(arg1);
        v1.daily_base = arg2;
        v1.daily_step = arg3;
        v1.daily_max = arg4;
        v1.daily_streak_cap = arg5;
    }

    public fun set_enabled(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: bool) {
        cfg_mut(arg1).enabled = arg2;
    }

    public fun set_mint_caps(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) {
        assert!(arg2 <= 1000000000000000 && arg3 <= 1000000000000000, 13835341209592070160);
        let v0 = cfg_mut(arg1);
        v0.wallet_mint_cap = arg2;
        v0.global_mint_cap = arg3;
    }

    public fun set_quest_active(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u8, arg3: bool) {
        let v0 = book_mut(arg1);
        let v1 = 0x2::table::borrow_mut<u8, QuestDef>(&mut v0.quests, arg2);
        if (v1.active == arg3) {
            return
        };
        v1.active = arg3;
        let v2 = *v1;
        let v3 = 0x1::vector::borrow_mut<vector<QuestView>>(&mut v0.quest_index, (v2.kind as u64));
        if (arg3) {
            let v4 = v2.param;
            let v5 = 0;
            while (v5 < 0x1::vector::length<QuestView>(v3) && (0x1::vector::borrow<QuestView>(v3, v5).param < v4 || 0x1::vector::borrow<QuestView>(v3, v5).param == v4 && 0x1::vector::borrow<QuestView>(v3, v5).id < arg2)) {
                v5 = v5 + 1;
            };
            let v6 = QuestView{
                id        : arg2,
                param     : v2.param,
                xp        : v2.xp,
                cosmetic  : v2.cosmetic,
                start_ms  : v2.start_ms,
                end_ms    : v2.end_ms,
                season_id : v2.season_id,
            };
            0x1::vector::insert<QuestView>(v3, v6, v5);
        } else {
            let v7 = 0;
            /* label 17 */
            while (v7 < 0x1::vector::length<QuestView>(v3)) {
                if (0x1::vector::borrow<QuestView>(v3, v7).id == arg2) {
                    /* label 20 */
                    0x1::vector::remove<QuestView>(v3, 0x1::option::destroy_some<u64>(0x1::option::some<u64>(v7)));
                    return
                } else {
                    /* goto 22 */
                };
            };
        };
        return
        /* label 22 */
        /* goto 17 */
        continue;
        /* goto 20 */
    }

    public fun set_quest_bounds(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64) {
        assert!(arg2 >= 1 && arg2 <= 1000000000, 13835341389980696592);
        cfg_mut(arg1).max_xp_grant = arg2;
    }

    public fun set_season_ceiling(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64) {
        assert!(arg2 >= 1 && arg2 <= 100000000000, 13835341415750500368);
        cfg_mut(arg1).max_season_reward = arg2;
    }

    public fun set_tier_name(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: vector<u8>) {
        assert!(name_ok(&arg3), 13835341127987691536);
        *0x1::vector::borrow_mut<vector<u8>>(&mut cfg_mut(arg1).tier_names, arg2) = arg3;
    }

    public fun set_tier_thresholds(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: vector<u64>) {
        let v0 = 0x1::vector::length<u64>(&arg2);
        assert!(v0 >= 1 && v0 <= 32, 13835341063563182096);
        let v1 = 0;
        let v2 = &arg2;
        let v3 = 0;
        while (v3 < 0x1::vector::length<u64>(v2)) {
            let v4 = 0x1::vector::borrow<u64>(v2, v3);
            assert!(*v4 > v1 && *v4 <= 1000000000000000, 13835341076448083984);
            v1 = *v4;
            v3 = v3 + 1;
        };
        let v5 = cfg_mut(arg1);
        let v6 = 0x1::vector::length<u64>(&arg2) + 1;
        v5.tier_thresholds = arg2;
        while (0x1::vector::length<vector<u8>>(&v5.tier_names) < v6) {
            0x1::vector::push_back<vector<u8>>(&mut v5.tier_names, b"");
        };
        while (0x1::vector::length<vector<u8>>(&v5.tier_names) > v6) {
            0x1::vector::pop_back<vector<u8>>(&mut v5.tier_names);
        };
    }

    public fun set_weights(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) {
        assert!(arg2 <= 1000000 && arg3 <= 1000000, 13835341351325990928);
        assert!(arg2 + arg3 > 0, 13835341355620958224);
        let v0 = cfg_mut(arg1);
        v0.weight_xp = arg2;
        v0.weight_cosmetic = arg3;
    }

    public fun set_win_xp(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: u64, arg3: u64) {
        assert!(arg2 <= 1000000, 13835341243951808528);
        assert!(arg3 >= 1 && arg3 <= 100, 13835341248246775824);
        let v0 = cfg_mut(arg1);
        v0.win_xp_bonus = arg2;
        v0.win_streak_xp_cap = arg3;
    }

    fun settle(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: &GameBook, arg4: Trigger, arg5: u64, arg6: Progress, arg7: u64) {
        let v0 = 0;
        while (v0 < 64) {
            let v1 = scan_mask(arg0, arg5, &arg6);
            let v2 = pass_achievements(arg0, arg1, arg2, arg3, v1, arg4, arg7);
            let v3 = scan_mask(arg0, arg5, &arg6);
            if (!v2 && !pass_quests(arg0, arg1, arg2, arg3, v3, arg4, arg7)) {
                break
            };
            v0 = v0 + 1;
        };
    }

    fun settle_deferred(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: &GameBook) {
        if (arg0.effects.xp == arg0.xp) {
            return
        };
        let v0 = progress(arg0);
        let v1 = *arg2;
        v1.xp_per_crate = arg0.effects.rate;
        xp_effects(arg0, arg1, &v1);
        v1.season_id = arg0.season_id;
        let v2 = arg0.effects.ms;
        v1.season_start_ms = v2;
        let v3 = if (arg0.effects.in_season) {
            v2 + 1
        } else {
            v2
        };
        v1.season_end_ms = v3;
        settle(arg0, arg1, &v1, arg3, trigger_none(), 1 << 5, v0, v2);
    }

    public fun settle_fee_achievement(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: &0x2::object::UID, arg3: address, arg4: u64) {
        let v0 = rules(arg2);
        if (!v0.enabled) {
            return
        };
        let v1 = take_player(arg1, arg3);
        let v2 = &mut v1;
        settle_deferred(v2, arg3, &v0, book(arg1));
        let v3 = &mut v1;
        grant_fee_xp(v3, arg3, &v0, arg4);
        let v4 = &mut v1;
        let v5 = Trigger{
            on_close  : false,
            loss      : 0,
            profit    : 0,
            leverage  : 0,
            margin    : 0,
            wash      : false,
            fees_paid : true,
        };
        settle(v4, arg3, &v0, book(arg1), v5, 256, progress(&v1), arg4);
        if (v1.fee_credit_used != v1.fee_credit_used) {
            0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_fee_credit_event(arg3, v1.fee_credit, v1.fee_credit_used);
        };
        save_player(arg1, arg3, v1);
    }

    public fun take_pending(arg0: &0x820acae66600bbac98b09cc892ab56e50eac4b9fa5ec130ac348f9068860b095::access::Auth, arg1: &mut 0x2::object::UID, arg2: address) : u64 {
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

    public fun tier_threshold_count(arg0: &0x2::object::UID) : u64 {
        0x1::vector::length<u64>(&cfg(arg0).tier_thresholds)
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

    fun unlock_cosmetic(arg0: &mut Player, arg1: address, arg2: &Rules, arg3: 0x1::option::Option<u8>, arg4: u128) {
        if (0x1::option::is_none<u8>(&arg3)) {
            return
        };
        let v0 = *0x1::option::borrow<u8>(&arg3);
        if (!bit_on(arg4, v0) || !arg2.defer_effects && bit_on(arg0.cosmetics, v0)) {
            return
        };
        arg0.cosmetics = set_bit(arg0.cosmetics, v0);
        0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_cosmetic_unlocked_event(arg1, v0);
    }

    public fun volume_band_xp(arg0: u64) : u64 {
        let v0 = 50000000000;
        let v1 = if (arg0 < v0) {
            arg0
        } else {
            v0
        };
        let v2 = if (arg0 <= v0) {
            0
        } else if (arg0 < 250000000000) {
            arg0 - v0
        } else {
            250000000000 - v0
        };
        v1 / 1000000 + v2 / 4000000
    }

    public fun wallet_mint_cap(arg0: &0x2::object::UID) : u64 {
        cfg(arg0).wallet_mint_cap
    }

    public fun weighted_index(arg0: &vector<u64>, arg1: u64) : u64 {
        let v0 = 0;
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(arg0)) {
            v0 = v0 + *0x1::vector::borrow<u64>(arg0, v2);
            v1 = v1 + ge_bit(arg1, v0);
            v2 = v2 + 1;
        };
        let v3 = 0x1::vector::length<u64>(arg0);
        if (v1 < v3) {
            v1
        } else {
            v3 - 1
        }
    }

    fun xp_effects(arg0: &mut Player, arg1: address, arg2: &Rules) {
        let v0 = tier_of(arg0.xp, &arg2.tier_thresholds);
        if (v0 > arg0.tier) {
            arg0.tier = v0;
            0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_tier_up_event(arg1, arg0.tier, v0);
        };
        if (arg2.xp_per_crate > 0) {
            let v1 = arg0.effects.xp / arg2.xp_per_crate;
            let v2 = arg0.xp / arg2.xp_per_crate;
            if (v2 > v1) {
                let v3 = sat_add(arg0.crates, v2 - v1);
                let v4 = v3 - arg0.crates;
                arg0.crates = v3;
                if (v4 > 0) {
                    0x1e841dd81d84e5b57785e4afdf7d1528d7ed9d0ad1cc1d931cf2f10521d20303::game_events::emit_crate_granted_event(arg1, v4, v3);
                };
            };
        };
        arg0.effects.xp = arg0.xp;
    }

    // decompiled from Move bytecode v7
}

