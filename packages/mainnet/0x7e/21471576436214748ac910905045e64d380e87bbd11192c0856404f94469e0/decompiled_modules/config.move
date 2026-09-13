module 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::config {
    struct ConfigStore has key {
        id: 0x2::object::UID,
        version: u64,
        challenge_fee_bps: u64,
        tournament_fee_bps: u64,
        redemption_fee_bps: u64,
        min_redemption_usdsui: u64,
        redemption_rapid_fee_bps: u64,
        min_challenge_credits: u64,
        cancel_window_ms: u64,
        challenge_dispute_window_ms: u64,
        tournament_dispute_window_ms: u64,
        oracle_signature_age_ms: u64,
        oracle_clock_skew_ms: u64,
        tournament_zenko_ticket_cut_bps: u64,
        created_at: u64,
        updated_at: u64,
    }

    struct ConfigUpdated has copy, drop {
        field: vector<u8>,
        old_value: u64,
        new_value: u64,
        updated_by: address,
    }

    struct AllowedGameTypeKey has copy, drop, store {
        game_type: 0x1::string::String,
    }

    struct AllowedGameTypeCountKey has copy, drop, store {
        dummy_field: bool,
    }

    struct GameTypeAllowlistUpdated has copy, drop {
        game_type: 0x1::string::String,
        allowed: bool,
        updated_by: address,
    }

    fun allowlist_count(arg0: &ConfigStore) : u64 {
        let v0 = AllowedGameTypeCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AllowedGameTypeCountKey>(&arg0.id, v0)) {
            let v2 = AllowedGameTypeCountKey{dummy_field: false};
            *0x2::dynamic_field::borrow<AllowedGameTypeCountKey, u64>(&arg0.id, v2)
        } else {
            0
        }
    }

    public fun assert_game_type_allowed(arg0: &ConfigStore, arg1: &0x1::string::String) {
        assert!(is_game_type_allowed(arg0, arg1), 3);
    }

    public fun assert_version(arg0: &ConfigStore) {
        assert_version_matches(arg0.version);
    }

    public fun assert_version_matches(arg0: u64) {
        assert!(arg0 == 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::current_version(), 1);
    }

    public fun calculate_bps(arg0: u64, arg1: u64) : u64 {
        arg0 * arg1 / 10000
    }

    public fun cancel_window_ms(arg0: &ConfigStore) : u64 {
        arg0.cancel_window_ms
    }

    public fun challenge_dispute_window_ms(arg0: &ConfigStore) : u64 {
        arg0.challenge_dispute_window_ms
    }

    public fun challenge_fee_bps(arg0: &ConfigStore) : u64 {
        arg0.challenge_fee_bps
    }

    public fun credits_per_usdsui() : u64 {
        100
    }

    public fun current_version() : u64 {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::current_version()
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = ConfigStore{
            id                              : 0x2::object::new(arg0),
            version                         : 0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::current_version(),
            challenge_fee_bps               : 500,
            tournament_fee_bps              : 500,
            redemption_fee_bps              : 100,
            min_redemption_usdsui           : 20000000,
            redemption_rapid_fee_bps        : 500,
            min_challenge_credits           : 200,
            cancel_window_ms                : 120000,
            challenge_dispute_window_ms     : 3600000 * 4,
            tournament_dispute_window_ms    : 3600000 * 12,
            oracle_signature_age_ms         : 600000,
            oracle_clock_skew_ms            : 60000,
            tournament_zenko_ticket_cut_bps : 2000,
            created_at                      : 0,
            updated_at                      : 0,
        };
        0x2::transfer::share_object<ConfigStore>(v0);
    }

    public fun is_game_type_allowed(arg0: &ConfigStore, arg1: &0x1::string::String) : bool {
        if (allowlist_count(arg0) == 0) {
            true
        } else {
            let v1 = AllowedGameTypeKey{game_type: *arg1};
            0x2::dynamic_field::exists<AllowedGameTypeKey>(&arg0.id, v1)
        }
    }

    public fun migrate_config_store(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: &0x2::tx_context::TxContext) {
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_super_admin(arg1, arg2);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::version::migrate(&mut arg0.version, 0x2::object::id<ConfigStore>(arg0));
    }

    public fun min_challenge_credits(arg0: &ConfigStore) : u64 {
        arg0.min_challenge_credits
    }

    public fun min_redemption_usdsui(arg0: &ConfigStore) : u64 {
        arg0.min_redemption_usdsui
    }

    public fun network_id() : u8 {
        1
    }

    public fun oracle_clock_skew_ms(arg0: &ConfigStore) : u64 {
        arg0.oracle_clock_skew_ms
    }

    public fun oracle_signature_age_ms(arg0: &ConfigStore) : u64 {
        arg0.oracle_signature_age_ms
    }

    public fun redemption_fee_bps(arg0: &ConfigStore) : u64 {
        arg0.redemption_fee_bps
    }

    public fun redemption_rapid_fee_bps(arg0: &ConfigStore) : u64 {
        arg0.redemption_rapid_fee_bps
    }

    public fun register_game_type(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg1, arg4);
        let v0 = AllowedGameTypeKey{game_type: arg2};
        if (!0x2::dynamic_field::exists<AllowedGameTypeKey>(&arg0.id, v0)) {
            let v1 = allowlist_count(arg0) + 1;
            let v2 = AllowedGameTypeKey{game_type: arg2};
            0x2::dynamic_field::add<AllowedGameTypeKey, bool>(&mut arg0.id, v2, true);
            set_allowlist_count(arg0, v1);
        };
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v3 = GameTypeAllowlistUpdated{
            game_type  : arg2,
            allowed    : true,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<GameTypeAllowlistUpdated>(v3);
    }

    public fun remove_game_type(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_operations(arg1, arg4);
        let v0 = AllowedGameTypeKey{game_type: arg2};
        if (0x2::dynamic_field::exists<AllowedGameTypeKey>(&arg0.id, v0)) {
            let v1 = AllowedGameTypeKey{game_type: arg2};
            0x2::dynamic_field::remove<AllowedGameTypeKey, bool>(&mut arg0.id, v1);
            let v2 = allowlist_count(arg0);
            if (v2 > 0) {
                set_allowlist_count(arg0, v2 - 1);
            };
        };
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v3 = GameTypeAllowlistUpdated{
            game_type  : arg2,
            allowed    : false,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<GameTypeAllowlistUpdated>(v3);
    }

    public fun rep_connect_gaming() : u64 {
        5
    }

    public fun rep_dispute_open() : u64 {
        50
    }

    public fun rep_penalty_cancel_challenge() : u64 {
        1
    }

    public fun rep_penalty_leave_tournament() : u64 {
        1
    }

    public fun rep_play_game() : u64 {
        1
    }

    public fun rep_reward_challenge_completed() : u64 {
        5
    }

    public fun rep_reward_challenge_entered() : u64 {
        1
    }

    public fun rep_reward_challenge_won() : u64 {
        15
    }

    public fun rep_reward_tournament_1st() : u64 {
        40
    }

    public fun rep_reward_tournament_completed() : u64 {
        20
    }

    public fun rep_reward_tournament_entered() : u64 {
        1
    }

    public fun rep_reward_tournament_prize() : u64 {
        10
    }

    public fun rep_reward_tournament_top3() : u64 {
        25
    }

    public fun rep_set_username() : u64 {
        1
    }

    public fun rep_subscribe_standard() : u64 {
        10
    }

    public fun rep_subscribe_vip() : u64 {
        20
    }

    fun set_allowlist_count(arg0: &mut ConfigStore, arg1: u64) {
        let v0 = AllowedGameTypeCountKey{dummy_field: false};
        if (0x2::dynamic_field::exists<AllowedGameTypeCountKey>(&arg0.id, v0)) {
            let v1 = AllowedGameTypeCountKey{dummy_field: false};
            *0x2::dynamic_field::borrow_mut<AllowedGameTypeCountKey, u64>(&mut arg0.id, v1) = arg1;
        } else {
            let v2 = AllowedGameTypeCountKey{dummy_field: false};
            0x2::dynamic_field::add<AllowedGameTypeCountKey, u64>(&mut arg0.id, v2, arg1);
        };
    }

    public fun set_cancel_window_ms(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        arg0.cancel_window_ms = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"cancel_window_ms",
            old_value  : arg0.cancel_window_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_challenge_dispute_window_ms(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        arg0.challenge_dispute_window_ms = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"challenge_dispute_window_ms",
            old_value  : arg0.challenge_dispute_window_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_challenge_fee_bps(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        assert!(arg2 <= 1000, 0);
        arg0.challenge_fee_bps = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"challenge_fee_bps",
            old_value  : arg0.challenge_fee_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_min_challenge_credits(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        arg0.min_challenge_credits = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"min_challenge_credits",
            old_value  : arg0.min_challenge_credits,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_min_redemption_usdsui(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        arg0.min_redemption_usdsui = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"min_redemption_usdsui",
            old_value  : arg0.min_redemption_usdsui,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_oracle_clock_skew_ms(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        arg0.oracle_clock_skew_ms = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"oracle_clock_skew_ms",
            old_value  : arg0.oracle_clock_skew_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_oracle_signature_age_ms(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        arg0.oracle_signature_age_ms = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"oracle_signature_age_ms",
            old_value  : arg0.oracle_signature_age_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_redemption_fee_bps(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        assert!(arg2 <= 1000, 0);
        arg0.redemption_fee_bps = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"redemption_fee_bps",
            old_value  : arg0.redemption_fee_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_redemption_rapid_fee_bps(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        assert!(arg2 <= 2000, 0);
        arg0.redemption_rapid_fee_bps = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"redemption_rapid_fee_bps",
            old_value  : arg0.redemption_rapid_fee_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_tournament_dispute_window_ms(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        arg0.tournament_dispute_window_ms = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"tournament_dispute_window_ms",
            old_value  : arg0.tournament_dispute_window_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_tournament_fee_bps(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        assert!(arg2 <= 1000, 0);
        arg0.tournament_fee_bps = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"tournament_fee_bps",
            old_value  : arg0.tournament_fee_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_tournament_zenko_ticket_cut_bps(arg0: &mut ConfigStore, arg1: &0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::RoleRegistry, arg2: u64, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_version_matches(arg0.version);
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::access::assert_admin(arg1, arg4);
        assert!(arg2 <= 10000, 0);
        arg0.tournament_zenko_ticket_cut_bps = arg2;
        arg0.updated_at = 0x2::clock::timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"tournament_zenko_ticket_cut_bps",
            old_value  : arg0.tournament_zenko_ticket_cut_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg4),
        };
        0x7e6f2598d7d759e281f544894a0fdfd5c1f98c6e7bab9f73c41f0a4a472254f7::events::emit_event<ConfigUpdated>(v0);
    }

    public fun tournament_dispute_window_ms(arg0: &ConfigStore) : u64 {
        arg0.tournament_dispute_window_ms
    }

    public fun tournament_fee_bps(arg0: &ConfigStore) : u64 {
        arg0.tournament_fee_bps
    }

    public fun tournament_max_winners() : u64 {
        25
    }

    public fun tournament_placement1_bps() : u64 {
        4000
    }

    public fun tournament_placement2_bps() : u64 {
        2500
    }

    public fun tournament_placement3_bps() : u64 {
        1000
    }

    public fun tournament_placement4_plus_bps() : u64 {
        100
    }

    public fun tournament_zenko_ticket_cut_bps(arg0: &ConfigStore) : u64 {
        arg0.tournament_zenko_ticket_cut_bps
    }

    // decompiled from Move bytecode v7
}

