module 0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::config {
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
        timestamp: u64,
    }

    public fun basis_points_precision() : u64 {
        10000
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
        1
    }

    public fun day_ms() : u64 {
        86400000
    }

    public fun hour_ms() : u64 {
        3600000
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::epoch_timestamp_ms(arg0);
        let v1 = ConfigStore{
            id                              : 0x2::object::new(arg0),
            version                         : 1,
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
            created_at                      : v0,
            updated_at                      : v0,
        };
        0x2::transfer::share_object<ConfigStore>(v1);
    }

    public fun min_challenge_credits(arg0: &ConfigStore) : u64 {
        arg0.min_challenge_credits
    }

    public fun min_redemption_usdsui(arg0: &ConfigStore) : u64 {
        arg0.min_redemption_usdsui
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

    public fun set_cancel_window_ms(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.cancel_window_ms = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"cancel_window_ms",
            old_value  : arg0.cancel_window_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_challenge_dispute_window_ms(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.challenge_dispute_window_ms = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"challenge_dispute_window_ms",
            old_value  : arg0.challenge_dispute_window_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_challenge_fee_bps(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 1000, 0);
        arg0.challenge_fee_bps = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"challenge_fee_bps",
            old_value  : arg0.challenge_fee_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_min_challenge_credits(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.min_challenge_credits = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"min_challenge_credits",
            old_value  : arg0.min_challenge_credits,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_min_redemption_usdsui(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.min_redemption_usdsui = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"min_redemption_usdsui",
            old_value  : arg0.min_redemption_usdsui,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_oracle_clock_skew_ms(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.oracle_clock_skew_ms = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"oracle_clock_skew_ms",
            old_value  : arg0.oracle_clock_skew_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_oracle_signature_age_ms(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.oracle_signature_age_ms = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"oracle_signature_age_ms",
            old_value  : arg0.oracle_signature_age_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_redemption_fee_bps(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 1000, 0);
        arg0.redemption_fee_bps = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"redemption_fee_bps",
            old_value  : arg0.redemption_fee_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_redemption_rapid_fee_bps(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 2000, 0);
        arg0.redemption_rapid_fee_bps = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"redemption_rapid_fee_bps",
            old_value  : arg0.redemption_rapid_fee_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_tournament_dispute_window_ms(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        arg0.tournament_dispute_window_ms = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"tournament_dispute_window_ms",
            old_value  : arg0.tournament_dispute_window_ms,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_tournament_fee_bps(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 1000, 0);
        arg0.tournament_fee_bps = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"tournament_fee_bps",
            old_value  : arg0.tournament_fee_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun set_tournament_zenko_ticket_cut_bps(arg0: &mut ConfigStore, arg1: &0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::RoleRegistry, arg2: u64, arg3: &0x2::tx_context::TxContext) {
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::access::assert_admin(arg1, arg3);
        assert!(arg2 <= 10000, 0);
        arg0.tournament_zenko_ticket_cut_bps = arg2;
        arg0.updated_at = 0x2::tx_context::epoch_timestamp_ms(arg3);
        let v0 = ConfigUpdated{
            field      : b"tournament_zenko_ticket_cut_bps",
            old_value  : arg0.tournament_zenko_ticket_cut_bps,
            new_value  : arg2,
            updated_by : 0x2::tx_context::sender(arg3),
            timestamp  : arg0.updated_at,
        };
        0x32d37a55b4edf4f70f994ceab721f5e929845c597255e56bc436a583a45e7ea1::events::emit_event<ConfigUpdated>(v0);
    }

    public fun share_price_precision() : u64 {
        1000000
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

