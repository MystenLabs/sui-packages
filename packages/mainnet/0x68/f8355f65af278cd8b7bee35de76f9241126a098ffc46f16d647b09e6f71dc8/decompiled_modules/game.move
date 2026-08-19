module 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::game {
    struct FeverActivated has copy, drop {
        utc_day: u64,
        level: u8,
        tracked_supply_raw: u128,
    }

    struct FeverState has store {
        activated: bool,
        current_day: u64,
        current_level: u8,
        tracked_supply_raw: u128,
        has_closed_day: bool,
        last_closed_day: u64,
    }

    struct Economy has key {
        id: 0x2::object::UID,
        marketing_wallet: address,
        total_enhancement_fees_raw: u64,
        total_burned_raw: u64,
        total_rank_rewards_reserved_raw: u64,
        total_marketing_paid_raw: u64,
        fever_state: FeverState,
    }

    struct SettlementBook has key {
        id: 0x2::object::UID,
        authority: address,
        player_count: u64,
    }

    struct PlayerState has key {
        id: 0x2::object::UID,
        owner: address,
        created_ms: u64,
        level: u8,
        pending_enhancement: bool,
        pending_target_level: u8,
        pending_started_ms: u64,
        pending_attempt_day: u64,
        pending_fever_level: u8,
        pending_fever_constant_scaled: u64,
        pending_base_success_units: u64,
        pending_success_units: u64,
        lifetime_enhancement_attempts: u64,
        lifetime_attempt_achieved_ms: u64,
        lifetime_enhancement_successes: u64,
        lifetime_success_achieved_ms: u64,
        daily_success_day: u64,
        daily_success_count: u64,
        daily_success_achieved_ms: u64,
    }

    struct PlayerKey has copy, drop, store {
        owner: address,
    }

    struct ProtocolDailyMintCapKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolDailyMintBudgetVersionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct ProtocolRewardExclusionKey has copy, drop, store {
        wallet: address,
    }

    struct ProtocolRewardExclusionVersionKey has copy, drop, store {
        dummy_field: bool,
    }

    struct SettlementAuthorityEpochKey has copy, drop, store {
        dummy_field: bool,
    }

    struct FeeDayKey has copy, drop, store {
        day: u64,
    }

    struct FeeDayPool has store {
        marketing_wallet: address,
        burn_pool: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        holding_reward_pool: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        daily_success_reward_pool: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        lifetime_success_reward_pool: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        lifetime_attempt_reward_pool: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        marketing_pool: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        base_burn_finalized: bool,
        base_burned_raw: u64,
    }

    struct ActivitySnapshotKey has copy, drop, store {
        use_day: u64,
    }

    struct ActivitySnapshotRecord has copy, drop, store {
        root: address,
        policy_version: u8,
        month_id: u32,
        month_start_day: u64,
        cutoff_checkpoint: u64,
        exclusion_version: u64,
        eligible_count: u64,
        status: u8,
        proposed_ms: u64,
        activates_ms: u64,
        revision: u64,
        authority_epoch: u64,
    }

    struct MiningRootKey has copy, drop, store {
        day: u64,
    }

    struct MiningRootRecord has copy, drop, store {
        root: address,
        total_mint_raw: u64,
        claimed_mint_raw: u64,
    }

    struct MiningClaimKey has copy, drop, store {
        day: u64,
        wallet: address,
    }

    struct MiningV2RootKey has copy, drop, store {
        day: u64,
    }

    struct MiningV2RootRecord has copy, drop, store {
        root: address,
        total_mint_raw: u64,
        claimed_mint_raw: u64,
        activity_root: address,
        policy_version: u8,
        month_id: u32,
        month_start_day: u64,
        activity_revision: u64,
        status: u8,
        proposed_ms: u64,
        activates_ms: u64,
        revision: u64,
        authority_epoch: u64,
        budget_version: u64,
    }

    struct RewardSnapshotKey has copy, drop, store {
        day: u64,
    }

    struct RewardSnapshotRecord has store {
        holding_top_raw: u64,
        holding_winner_count: u64,
        holding_root: address,
        holding_representative: address,
        daily_success_top: u64,
        daily_success_winner_count: u64,
        daily_success_root: address,
        daily_success_representative: address,
        lifetime_success_top: u64,
        lifetime_success_winner_count: u64,
        lifetime_success_root: address,
        lifetime_success_representative: address,
        lifetime_attempt_top: u64,
        lifetime_attempt_winner_count: u64,
        lifetime_attempt_root: address,
        lifetime_attempt_representative: address,
    }

    struct RewardPayoutDay has key {
        id: 0x2::object::UID,
        day: u64,
        holding_root: address,
        holding_winner_count: u64,
        holding_total_raw: u64,
        holding_remaining: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        daily_success_root: address,
        daily_success_winner_count: u64,
        daily_success_total_raw: u64,
        daily_success_remaining: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        lifetime_success_root: address,
        lifetime_success_winner_count: u64,
        lifetime_success_total_raw: u64,
        lifetime_success_remaining: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
        lifetime_attempt_root: address,
        lifetime_attempt_winner_count: u64,
        lifetime_attempt_total_raw: u64,
        lifetime_attempt_remaining: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>,
    }

    struct RewardClaimKey has copy, drop, store {
        category: u8,
        wallet: address,
    }

    struct ProtocolInitialized has copy, drop {
        publisher: address,
        marketing_wallet: address,
        settlement_authority: address,
    }

    struct MarketingWalletChanged has copy, drop {
        old_wallet: address,
        new_wallet: address,
    }

    struct SettlementAuthorityChanged has copy, drop {
        old_authority: address,
        new_authority: address,
        authority_epoch: u64,
    }

    struct ActivitySnapshotProposed has copy, drop {
        use_day: u64,
        root: address,
        policy_version: u8,
        month_id: u32,
        month_start_day: u64,
        cutoff_checkpoint: u64,
        exclusion_version: u64,
        eligible_count: u64,
        proposed_ms: u64,
        activates_ms: u64,
        revision: u64,
        authority_epoch: u64,
    }

    struct ActivitySnapshotActivated has copy, drop {
        use_day: u64,
        root: address,
        activated_ms: u64,
        revision: u64,
    }

    struct ActivitySnapshotCancelled has copy, drop {
        use_day: u64,
        root: address,
        cancelled_ms: u64,
        revision: u64,
    }

    struct ProtocolDailyMintCapChanged has copy, drop {
        old_max_raw: u64,
        new_max_raw: u64,
        budget_version: u64,
    }

    struct ProtocolRewardExclusionChanged has copy, drop {
        wallet: address,
        old_excluded: bool,
        new_excluded: bool,
        exclusion_version: u64,
    }

    struct SwordCreated has copy, drop {
        owner: address,
        created_ms: u64,
    }

    struct EnhancementStarted has copy, drop {
        owner: address,
        utc_day: u64,
        from_level: u8,
        target_level: u8,
        fever_level: u8,
        fever_constant_scaled: u64,
        base_success_units: u64,
        final_success_units: u64,
        cost_raw: u64,
        burn_pending_raw: u64,
        holding_reward_raw: u64,
        daily_success_reward_raw: u64,
        lifetime_success_reward_raw: u64,
        lifetime_attempt_reward_raw: u64,
        marketing_raw: u64,
        lifetime_attempts_after: u64,
        attempt_achieved_ms: u64,
    }

    struct EnhancementResolved has copy, drop {
        owner: address,
        attempt_utc_day: u64,
        fever_level: u8,
        fever_constant_scaled: u64,
        base_success_units: u64,
        final_success_units: u64,
        from_level: u8,
        target_level: u8,
        to_level: u8,
        success: bool,
        roll: u64,
        success_units: u64,
        resolve_utc_day: u64,
        lifetime_attempts: u64,
        lifetime_successes: u64,
        lifetime_success_achieved_ms: u64,
        daily_success_count: u64,
        daily_success_achieved_ms: u64,
    }

    struct MiningV2RootProposed has copy, drop {
        day: u64,
        root: address,
        total_mint_raw: u64,
        activity_root: address,
        policy_version: u8,
        month_id: u32,
        month_start_day: u64,
        activity_revision: u64,
        proposed_ms: u64,
        activates_ms: u64,
        revision: u64,
        authority_epoch: u64,
        budget_version: u64,
    }

    struct MiningV2RootActivated has copy, drop {
        day: u64,
        root: address,
        activated_ms: u64,
        revision: u64,
    }

    struct MiningV2RootCancelled has copy, drop {
        day: u64,
        root: address,
        cancelled_ms: u64,
        revision: u64,
    }

    struct MiningV2Claimed has copy, drop {
        day: u64,
        wallet: address,
        amount_raw: u64,
        activity_root: address,
        activity_score: u64,
        activity_class: u8,
        root_revision: u64,
    }

    struct MiningRootPublished has copy, drop {
        day: u64,
        root: address,
        total_mint_raw: u64,
    }

    struct MiningClaimed has copy, drop {
        day: u64,
        wallet: address,
        amount_raw: u64,
    }

    struct RewardSnapshotPublished has copy, drop {
        day: u64,
        holding_top_raw: u64,
        holding_winner_count: u64,
        holding_representative: address,
        daily_success_top: u64,
        daily_success_winner_count: u64,
        daily_success_representative: address,
        lifetime_success_top: u64,
        lifetime_success_winner_count: u64,
        lifetime_success_representative: address,
        lifetime_attempt_top: u64,
        lifetime_attempt_winner_count: u64,
        lifetime_attempt_representative: address,
    }

    struct FeverBaseBurnDayClosed has copy, drop {
        day: u64,
        next_day: u64,
        base_burned_raw: u64,
        day_minted_raw: u128,
        day_burned_raw: u128,
        tracked_supply_raw: u128,
        previous_day_net_negative: bool,
        previous_day_net_abs_raw: u128,
        deviation_negative: bool,
        deviation_abs_raw: u128,
        pressure_negative: bool,
        pressure_numerator_abs_raw: u128,
        previous_fever_level: u8,
        desired_fever_level: u8,
        fever_level: u8,
    }

    struct FeeDaySettled has copy, drop {
        day: u64,
        base_burned_raw: u64,
        unawarded_burned_raw: u64,
        total_burned_raw: u64,
        holding_reserved_raw: u64,
        daily_success_reserved_raw: u64,
        lifetime_success_reserved_raw: u64,
        lifetime_attempt_reserved_raw: u64,
        marketing_paid_raw: u64,
        holding_winner_count: u64,
        daily_success_winner_count: u64,
        lifetime_success_winner_count: u64,
        lifetime_attempt_winner_count: u64,
    }

    struct RankingRewardPaid has copy, drop {
        day: u64,
        category: u8,
        wallet: address,
        winner_index: u64,
        amount_raw: u64,
    }

    public fun activate_activity_snapshot(arg0: &mut SettlementBook, arg1: u64, arg2: &0x2::clock::Clock) {
        activate_activity_snapshot_internal(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    fun activate_activity_snapshot_internal(arg0: &mut SettlementBook, arg1: u64, arg2: u64) {
        let v0 = ActivitySnapshotKey{use_day: arg1};
        assert!(0x2::dynamic_field::exists<ActivitySnapshotKey>(&arg0.id, v0), 31);
        let v1 = 0x2::dynamic_field::borrow_mut<ActivitySnapshotKey, ActivitySnapshotRecord>(&mut arg0.id, v0);
        assert!(v1.status == 1, 32);
        assert!(arg2 >= v1.activates_ms, 33);
        assert!(v1.authority_epoch == settlement_authority_epoch(arg0), 34);
        v1.status = 2;
        let v2 = ActivitySnapshotActivated{
            use_day      : arg1,
            root         : v1.root,
            activated_ms : arg2,
            revision     : v1.revision,
        };
        0x2::event::emit<ActivitySnapshotActivated>(v2);
    }

    public fun activate_fever(arg0: &0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolAdminCap, arg1: &mut Economy, arg2: &mut 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolTreasury, arg3: &0x2::clock::Clock) {
        assert_fever_not_activated(arg1);
        assert_clean_fever_supply_values(0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::post_genesis_minted_raw(arg2), 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::post_genesis_burned_raw(arg2), 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::total_supply(arg2));
        apply_clean_fever_activation(arg1, arg3);
        assert!(arg1.fever_state.current_day == 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::activate_supply_rollover_cursor(arg2, arg3), 20505);
    }

    public fun activate_mining_v2_root(arg0: &mut SettlementBook, arg1: u64, arg2: &0x2::clock::Clock) {
        activate_mining_v2_root_internal(arg0, arg1, 0x2::clock::timestamp_ms(arg2));
    }

    fun activate_mining_v2_root_internal(arg0: &mut SettlementBook, arg1: u64, arg2: u64) {
        let v0 = MiningV2RootKey{day: arg1};
        assert!(0x2::dynamic_field::exists<MiningV2RootKey>(&arg0.id, v0), 40);
        let v1 = ActivitySnapshotKey{use_day: arg1};
        assert!(0x2::dynamic_field::exists<ActivitySnapshotKey>(&arg0.id, v1), 31);
        let v2 = 0x2::dynamic_field::borrow<ActivitySnapshotKey, ActivitySnapshotRecord>(&arg0.id, v1);
        assert!(v2.status == 2, 39);
        let v3 = v2.root;
        let v4 = v2.policy_version;
        let v5 = v2.month_id;
        let v6 = v2.month_start_day;
        let v7 = 0x2::dynamic_field::borrow_mut<MiningV2RootKey, MiningV2RootRecord>(&mut arg0.id, v0);
        assert!(v7.status == 1, 41);
        assert!(arg2 >= v7.activates_ms, 42);
        assert!(v7.authority_epoch == settlement_authority_epoch(arg0), 43);
        assert!(v7.budget_version == protocol_daily_mint_budget_version(arg0), 44);
        assert!(v7.total_mint_raw <= max_protocol_daily_mint_raw(arg0), 29);
        let v8 = if (v7.activity_root == v3) {
            if (v7.policy_version == v4) {
                if (v7.month_id == v5) {
                    if (v7.month_start_day == v6) {
                        v7.activity_revision == v2.revision
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
        assert!(v8, 50);
        v7.status = 2;
        let v9 = MiningV2RootActivated{
            day          : arg1,
            root         : v7.root,
            activated_ms : arg2,
            revision     : v7.revision,
        };
        0x2::event::emit<MiningV2RootActivated>(v9);
    }

    public fun active_activity_snapshot_root(arg0: &SettlementBook, arg1: u64) : address {
        let v0 = ActivitySnapshotKey{use_day: arg1};
        assert!(0x2::dynamic_field::exists<ActivitySnapshotKey>(&arg0.id, v0), 31);
        let v1 = 0x2::dynamic_field::borrow<ActivitySnapshotKey, ActivitySnapshotRecord>(&arg0.id, v0);
        assert!(v1.status == 2, 39);
        v1.root
    }

    public fun active_mining_v2_root(arg0: &SettlementBook, arg1: u64) : address {
        let v0 = MiningV2RootKey{day: arg1};
        assert!(0x2::dynamic_field::exists<MiningV2RootKey>(&arg0.id, v0), 40);
        let v1 = 0x2::dynamic_field::borrow<MiningV2RootKey, MiningV2RootRecord>(&arg0.id, v0);
        assert!(v1.status == 2, 48);
        v1.root
    }

    public fun activity_factor_scale() : u64 {
        100
    }

    fun activity_factor_scaled(arg0: u8) : u64 {
        if (arg0 == 0) {
            100
        } else if (arg0 == 1) {
            110
        } else if (arg0 == 2) {
            120
        } else if (arg0 == 3) {
            130
        } else {
            assert!(arg0 == 4, 11);
            150
        }
    }

    public fun activity_factor_scaled_for(arg0: u8) : u64 {
        activity_factor_scaled(arg0)
    }

    public fun activity_normal_class() : u8 {
        0
    }

    public fun activity_snapshot_status(arg0: &SettlementBook, arg1: u64) : u8 {
        let v0 = ActivitySnapshotKey{use_day: arg1};
        assert!(0x2::dynamic_field::exists<ActivitySnapshotKey>(&arg0.id, v0), 31);
        0x2::dynamic_field::borrow<ActivitySnapshotKey, ActivitySnapshotRecord>(&arg0.id, v0).status
    }

    public fun activity_top10_class() : u8 {
        2
    }

    public fun activity_top1_class() : u8 {
        4
    }

    public fun activity_top25_class() : u8 {
        1
    }

    public fun activity_top5_class() : u8 {
        3
    }

    public fun activity_v1_empty_root() : address {
        let v0 = 8;
        let v1 = 0x1::bcs::to_bytes<u8>(&v0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun activity_v1_leaf_hash_for(arg0: u8, arg1: u64, arg2: u32, arg3: u64, arg4: address, arg5: u64, arg6: u8, arg7: u64) : address {
        let v0 = 7;
        let v1 = 0x1::bcs::to_bytes<u8>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u8>(&arg0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u32>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u8>(&arg6));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg7));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun activity_v1_node_hash_for(arg0: address, arg1: address) : address {
        merkle_node_hash(arg0, arg1, 8)
    }

    public fun advance_fever_one_day(arg0: &mut Economy, arg1: &mut 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolTreasury, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_fever_activated(arg0);
        let v0 = arg0.fever_state.current_day;
        assert_rollover_day_ready_values(v0, 0x2::clock::timestamp_ms(arg2) / 86400000);
        assert!(0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::supply_rollover_activated(arg1), 20505);
        assert!(0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::supply_rollover_current_day(arg1) == v0, 20505);
        let v1 = FeeDayKey{day: v0};
        let v2 = 0x2::dynamic_field::exists<FeeDayKey>(&arg0.id, v1);
        let (v3, v4) = if (v2) {
            let v5 = 0x2::dynamic_field::borrow_mut<FeeDayKey, FeeDayPool>(&mut arg0.id, v1);
            assert!(!v5.base_burn_finalized, 20504);
            let v6 = 0x2::balance::value<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&v5.burn_pool);
            let v7 = if (v6 == 0) {
                0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>()
            } else {
                0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v5.burn_pool, v6)
            };
            (v7, v6)
        } else {
            (0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(), 0)
        };
        let (v8, v9, v10, v11) = 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::finalize_current_supply_rollover_day(arg1, v3, arg2, arg3);
        assert!(v8 == v0, 20505);
        assert!(v11 == v4, 11);
        if (v2) {
            let v12 = 0x2::dynamic_field::borrow_mut<FeeDayKey, FeeDayPool>(&mut arg0.id, v1);
            assert!(0x2::balance::value<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&v12.burn_pool) == 0, 11);
            v12.base_burn_finalized = true;
            v12.base_burned_raw = v11;
        };
        arg0.total_burned_raw = arg0.total_burned_raw + v11;
        arg0.fever_state.tracked_supply_raw = tracked_supply_after_closed_day(arg0.fever_state.tracked_supply_raw, v9, v10);
        let (v13, v14, v15, v16, v17, v18) = d2000_components(arg0.fever_state.tracked_supply_raw, v9, v10);
        let v19 = desired_fever_from_d2000_pressure(v17, v18);
        let v20 = arg0.fever_state.current_level;
        let v21 = fever_one_level_toward_desired(v20, v19);
        arg0.fever_state.current_level = v21;
        arg0.fever_state.has_closed_day = true;
        arg0.fever_state.last_closed_day = v0;
        arg0.fever_state.current_day = v0 + 1;
        assert!(0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::supply_rollover_current_day(arg1) == arg0.fever_state.current_day, 20505);
        let v22 = if (v21 >= v20) {
            v21 - v20
        } else {
            v20 - v21
        };
        assert!(v22 <= 1, 11);
        assert!(v21 >= 1 && v21 <= 10, 11);
        let v23 = FeverBaseBurnDayClosed{
            day                        : v0,
            next_day                   : v0 + 1,
            base_burned_raw            : v11,
            day_minted_raw             : v9,
            day_burned_raw             : v10,
            tracked_supply_raw         : arg0.fever_state.tracked_supply_raw,
            previous_day_net_negative  : v13,
            previous_day_net_abs_raw   : v14,
            deviation_negative         : v15,
            deviation_abs_raw          : v16,
            pressure_negative          : v17,
            pressure_numerator_abs_raw : v18,
            previous_fever_level       : v20,
            desired_fever_level        : v19,
            fever_level                : v21,
        };
        0x2::event::emit<FeverBaseBurnDayClosed>(v23);
    }

    fun apply_clean_fever_activation(arg0: &mut Economy, arg1: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg1) / 86400000;
        arg0.fever_state.activated = true;
        arg0.fever_state.current_day = v0;
        arg0.fever_state.current_level = 5;
        arg0.fever_state.tracked_supply_raw = (1000000000000000 as u128);
        arg0.fever_state.has_closed_day = false;
        arg0.fever_state.last_closed_day = 0;
        let v1 = FeverActivated{
            utc_day            : v0,
            level              : 5,
            tracked_supply_raw : (1000000000000000 as u128),
        };
        0x2::event::emit<FeverActivated>(v1);
    }

    fun apply_enhancement_result(arg0: &mut PlayerState, arg1: u8, arg2: bool, arg3: u64, arg4: u64) : (u8, u64, u64) {
        if (arg2) {
            arg0.level = arg1;
            arg0.lifetime_enhancement_successes = arg0.lifetime_enhancement_successes + 1;
            arg0.lifetime_success_achieved_ms = arg4;
            if (arg0.daily_success_day != arg3) {
                arg0.daily_success_day = arg3;
                arg0.daily_success_count = 1;
            } else {
                arg0.daily_success_count = arg0.daily_success_count + 1;
            };
            arg0.daily_success_achieved_ms = arg4;
        };
        let v0 = if (arg0.daily_success_day == arg3) {
            arg0.daily_success_count
        } else {
            0
        };
        let v1 = if (arg0.daily_success_day == arg3) {
            arg0.daily_success_achieved_ms
        } else {
            0
        };
        (arg0.level, v0, v1)
    }

    fun apply_fever_probability_floor(arg0: u64, arg1: u64) : u64 {
        assert!(arg0 <= 100000000, 11);
        let v0 = (arg0 as u128) * (arg1 as u128) / (10000 as u128);
        let v1 = if (v0 > (100000000 as u128)) {
            (100000000 as u128)
        } else {
            v0
        };
        (v1 as u64)
    }

    fun apply_protocol_reward_exclusion(arg0: &mut SettlementBook, arg1: address, arg2: bool) {
        let v0 = write_protocol_reward_exclusion(arg0, arg1, arg2);
        if (v0 != arg2) {
            let v1 = ProtocolRewardExclusionChanged{
                wallet            : arg1,
                old_excluded      : v0,
                new_excluded      : arg2,
                exclusion_version : increment_protocol_reward_exclusion_version(arg0),
            };
            0x2::event::emit<ProtocolRewardExclusionChanged>(v1);
        };
    }

    fun assert_base_burn_finalized_value(arg0: bool) {
        assert!(arg0, 20504);
    }

    fun assert_clean_fever_supply_values(arg0: u128, arg1: u128, arg2: u64) {
        assert!(arg0 == 0, 20502);
        assert!(arg1 == 0, 20502);
        assert!(arg2 == 1000000000000000, 20502);
    }

    fun assert_fever_activated(arg0: &Economy) {
        assert!(arg0.fever_state.activated, 20500);
    }

    fun assert_fever_current_day(arg0: &Economy, arg1: &0x2::clock::Clock) {
        assert_fever_current_values(arg0.fever_state.activated, arg0.fever_state.current_day, 0x2::clock::timestamp_ms(arg1) / 86400000);
    }

    fun assert_fever_current_values(arg0: bool, arg1: u64, arg2: u64) {
        assert!(arg0, 20500);
        assert!(arg1 == arg2, 20503);
    }

    fun assert_fever_not_activated(arg0: &Economy) {
        assert!(!arg0.fever_state.activated, 20501);
    }

    fun assert_owner(arg0: &PlayerState, arg1: &0x2::tx_context::TxContext) {
        assert!(arg0.owner == 0x2::tx_context::sender(arg1), 1);
    }

    fun assert_protocol_reward_eligible(arg0: &SettlementBook, arg1: address) {
        assert!(!is_protocol_reward_excluded(arg0, arg1), 30);
    }

    fun assert_rollover_day_ready_values(arg0: u64, arg1: u64) {
        assert!(arg0 < arg1, 18);
    }

    fun burn_balance_current_day(arg0: &mut 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolTreasury, arg1: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&arg1);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(arg1);
            0
        } else {
            let v2 = 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::burn_protocol_coin_current_day(arg0, 0x2::coin::from_balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(arg1, arg3), arg2);
            assert!(v2 == v0, 11);
            v2
        }
    }

    public fun cancel_pending_activity_snapshot(arg0: &0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolAdminCap, arg1: &mut SettlementBook, arg2: u64, arg3: &0x2::clock::Clock) {
        cancel_pending_activity_snapshot_internal(arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    fun cancel_pending_activity_snapshot_internal(arg0: &mut SettlementBook, arg1: u64, arg2: u64) {
        let v0 = ActivitySnapshotKey{use_day: arg1};
        assert!(0x2::dynamic_field::exists<ActivitySnapshotKey>(&arg0.id, v0), 31);
        let v1 = 0x2::dynamic_field::borrow_mut<ActivitySnapshotKey, ActivitySnapshotRecord>(&mut arg0.id, v0);
        assert!(v1.status == 1, 32);
        v1.status = 3;
        let v2 = ActivitySnapshotCancelled{
            use_day      : arg1,
            root         : v1.root,
            cancelled_ms : arg2,
            revision     : v1.revision,
        };
        0x2::event::emit<ActivitySnapshotCancelled>(v2);
    }

    public fun cancel_pending_mining_v2_root(arg0: &0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolAdminCap, arg1: &mut SettlementBook, arg2: u64, arg3: &0x2::clock::Clock) {
        cancel_pending_mining_v2_root_internal(arg1, arg2, 0x2::clock::timestamp_ms(arg3));
    }

    fun cancel_pending_mining_v2_root_internal(arg0: &mut SettlementBook, arg1: u64, arg2: u64) {
        let v0 = MiningV2RootKey{day: arg1};
        assert!(0x2::dynamic_field::exists<MiningV2RootKey>(&arg0.id, v0), 40);
        let v1 = 0x2::dynamic_field::borrow_mut<MiningV2RootKey, MiningV2RootRecord>(&mut arg0.id, v0);
        assert!(v1.status == 1, 41);
        v1.status = 3;
        let v2 = MiningV2RootCancelled{
            day          : arg1,
            root         : v1.root,
            cancelled_ms : arg2,
            revision     : v1.revision,
        };
        0x2::event::emit<MiningV2RootCancelled>(v2);
    }

    public fun category_daily_success() : u8 {
        2
    }

    public fun category_holding() : u8 {
        1
    }

    public fun category_lifetime_attempt() : u8 {
        4
    }

    public fun category_lifetime_success() : u8 {
        3
    }

    public fun claim_mining(arg0: &Economy, arg1: &mut SettlementBook, arg2: &mut 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolTreasury, arg3: &PlayerState, arg4: u64, arg5: u64, arg6: vector<address>, arg7: vector<bool>, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS> {
        assert_fever_current_day(arg0, arg8);
        assert!(arg5 > 0, 10);
        assert_owner(arg3, arg9);
        assert!(arg5 <= max_daily_mint_raw_per_player(), 20);
        let v0 = 0x2::tx_context::sender(arg9);
        assert_protocol_reward_eligible(arg1, v0);
        let v1 = MiningRootKey{day: arg4};
        assert!(0x2::dynamic_field::exists<MiningRootKey>(&arg1.id, v1), 14);
        let v2 = MiningClaimKey{
            day    : arg4,
            wallet : v0,
        };
        assert!(!0x2::dynamic_field::exists<MiningClaimKey>(&arg1.id, v2), 15);
        assert!(verify_merkle_proof(0x2::dynamic_field::borrow<MiningRootKey, MiningRootRecord>(&arg1.id, v1).root, mining_leaf_hash(arg4, v0, arg5), &arg6, &arg7, 4), 16);
        let v3 = 0x2::dynamic_field::borrow_mut<MiningRootKey, MiningRootRecord>(&mut arg1.id, v1);
        assert!(v3.claimed_mint_raw <= v3.total_mint_raw, 17);
        assert!(arg5 <= v3.total_mint_raw - v3.claimed_mint_raw, 17);
        v3.claimed_mint_raw = v3.claimed_mint_raw + arg5;
        0x2::dynamic_field::add<MiningClaimKey, bool>(&mut arg1.id, v2, true);
        let v4 = MiningClaimed{
            day        : arg4,
            wallet     : v0,
            amount_raw : arg5,
        };
        0x2::event::emit<MiningClaimed>(v4);
        0x2::coin::from_balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::mint_protocol_balance_current_day(arg2, arg5, arg8), arg9)
    }

    public fun claim_mining_v2(arg0: &Economy, arg1: &mut SettlementBook, arg2: &mut 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolTreasury, arg3: &PlayerState, arg4: u64, arg5: u64, arg6: u64, arg7: u8, arg8: vector<address>, arg9: vector<bool>, arg10: &0x2::clock::Clock, arg11: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS> {
        assert_fever_current_day(arg0, arg10);
        assert!(arg5 > 0, 10);
        assert_owner(arg3, arg11);
        assert!(arg5 <= max_daily_mint_raw_per_player(), 20);
        let v0 = 0x2::tx_context::sender(arg11);
        assert_protocol_reward_eligible(arg1, v0);
        activity_factor_scaled(arg7);
        if (arg6 == 0) {
            assert!(arg7 == 0, 50);
        };
        let v1 = MiningV2RootKey{day: arg4};
        assert!(0x2::dynamic_field::exists<MiningV2RootKey>(&arg1.id, v1), 40);
        let v2 = MiningClaimKey{
            day    : arg4,
            wallet : v0,
        };
        assert!(!0x2::dynamic_field::exists<MiningClaimKey>(&arg1.id, v2), 15);
        let v3 = 0x2::dynamic_field::borrow<MiningV2RootKey, MiningV2RootRecord>(&arg1.id, v1);
        assert!(v3.status == 2, 48);
        let v4 = v3.root;
        let v5 = v3.activity_root;
        let v6 = v3.policy_version;
        let v7 = v3.month_id;
        let v8 = v3.month_start_day;
        let v9 = v3.revision;
        let v10 = ActivitySnapshotKey{use_day: arg4};
        let v11 = 0x2::dynamic_field::borrow<ActivitySnapshotKey, ActivitySnapshotRecord>(&arg1.id, v10);
        let v12 = if (v11.status == 2) {
            if (v11.root == v5) {
                if (v11.policy_version == v6) {
                    if (v11.month_id == v7) {
                        v11.month_start_day == v8
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
        assert!(v12, 50);
        assert!(verify_merkle_proof(v4, mining_v2_leaf_hash_for(v6, arg4, v7, v8, v0, arg5, v5, arg6, arg7), &arg8, &arg9, 10), 16);
        let v13 = 0x2::dynamic_field::borrow_mut<MiningV2RootKey, MiningV2RootRecord>(&mut arg1.id, v1);
        assert!(v13.claimed_mint_raw <= v13.total_mint_raw, 17);
        assert!(arg5 <= v13.total_mint_raw - v13.claimed_mint_raw, 17);
        v13.claimed_mint_raw = v13.claimed_mint_raw + arg5;
        0x2::dynamic_field::add<MiningClaimKey, bool>(&mut arg1.id, v2, true);
        let v14 = MiningV2Claimed{
            day            : arg4,
            wallet         : v0,
            amount_raw     : arg5,
            activity_root  : v5,
            activity_score : arg6,
            activity_class : arg7,
            root_revision  : v9,
        };
        0x2::event::emit<MiningV2Claimed>(v14);
        0x2::coin::from_balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::mint_protocol_balance_current_day(arg2, arg5, arg10), arg11)
    }

    public fun create_sword(arg0: &mut SettlementBook, arg1: &0x2::clock::Clock, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        let v1 = PlayerKey{owner: v0};
        assert!(!0x2::dynamic_field::exists<PlayerKey>(&arg0.id, v1), 2);
        0x2::dynamic_field::add<PlayerKey, bool>(&mut arg0.id, v1, true);
        arg0.player_count = arg0.player_count + 1;
        let v2 = 0x2::clock::timestamp_ms(arg1);
        let v3 = PlayerState{
            id                             : 0x2::object::new(arg2),
            owner                          : v0,
            created_ms                     : v2,
            level                          : 0,
            pending_enhancement            : false,
            pending_target_level           : 0,
            pending_started_ms             : 0,
            pending_attempt_day            : 0,
            pending_fever_level            : 0,
            pending_fever_constant_scaled  : 0,
            pending_base_success_units     : 0,
            pending_success_units          : 0,
            lifetime_enhancement_attempts  : 0,
            lifetime_attempt_achieved_ms   : 0,
            lifetime_enhancement_successes : 0,
            lifetime_success_achieved_ms   : 0,
            daily_success_day              : 0,
            daily_success_count            : 0,
            daily_success_achieved_ms      : 0,
        };
        let v4 = SwordCreated{
            owner      : v0,
            created_ms : v2,
        };
        0x2::event::emit<SwordCreated>(v4);
        0x2::transfer::transfer<PlayerState>(v3, v0);
    }

    fun d2000_components(arg0: u128, arg1: u128, arg2: u128) : (bool, u128, bool, u128, bool, u128) {
        let (v0, v1) = d2000_signed_difference_clamped(arg0, (1000000000000000 as u128), 2000000000000);
        let (v2, v3) = d2000_signed_difference_clamped(arg1, arg2, 750000000000);
        let (v4, v5) = d2000_weighted_pressure(v0, v1, v2, v3);
        (v2, v3, v0, v1, v4, v5)
    }

    fun d2000_pressure_is_dead_zone(arg0: u128) : bool {
        arg0 < 1500000000000
    }

    fun d2000_signed_difference_clamped(arg0: u128, arg1: u128, arg2: u128) : (bool, u128) {
        if (arg0 >= arg1) {
            let v2 = arg0 - arg1;
            let v3 = if (v2 > arg2) {
                arg2
            } else {
                v2
            };
            (false, v3)
        } else {
            let v4 = arg1 - arg0;
            let v5 = if (v4 > arg2) {
                arg2
            } else {
                v4
            };
            (v5 != 0, v5)
        }
    }

    fun d2000_weighted_pressure(arg0: bool, arg1: u128, arg2: bool, arg3: u128) : (bool, u128) {
        let v0 = arg1 * 12;
        let v1 = arg3 * 8;
        let (v2, v3) = if (arg0 == arg2) {
            let v4 = v0 + v1;
            let v5 = v4 == 0 && false || arg0;
            (v5, v4)
        } else if (v0 == v1) {
            (false, 0)
        } else if (v0 > v1) {
            (arg0, v0 - v1)
        } else {
            (arg2, v1 - v0)
        };
        assert!(v3 <= 30000000000000, 11);
        (v2, v3)
    }

    public fun daily_mining_rate_raw_for(arg0: u64, arg1: u8) : u64 {
        daily_mining_rate_raw_for_activity(arg0, arg1, 0)
    }

    public fun daily_mining_rate_raw_for_activity(arg0: u64, arg1: u8, arg2: u8) : u64 {
        activity_factor_scaled(arg2) * holding_factor_scaled_from_raw(arg0) * enhancement_multiplier_scaled(arg1) * 14250000 / 10000 / 100 / 100
    }

    public fun daily_success_achieved_ms_for(arg0: &PlayerState, arg1: u64) : u64 {
        if (arg0.daily_success_day == arg1) {
            arg0.daily_success_achieved_ms
        } else {
            0
        }
    }

    public fun daily_success_count_for(arg0: &PlayerState, arg1: u64) : u64 {
        if (arg0.daily_success_day == arg1) {
            arg0.daily_success_count
        } else {
            0
        }
    }

    fun desired_fever_from_d2000_pressure(arg0: bool, arg1: u128) : u8 {
        assert!(arg1 <= 30000000000000, 11);
        if (d2000_pressure_is_dead_zone(arg1)) {
            5
        } else if (arg0) {
            if (arg1 >= 27000000000000) {
                10
            } else if (arg1 >= 21000000000000) {
                9
            } else if (arg1 >= 15000000000000) {
                8
            } else if (arg1 >= 9000000000000) {
                7
            } else if (arg1 >= 3000000000000) {
                6
            } else {
                5
            }
        } else if (arg1 >= 26250000000000) {
            1
        } else if (arg1 >= 18750000000000) {
            2
        } else if (arg1 >= 11250000000000) {
            3
        } else if (arg1 >= 3750000000000) {
            4
        } else {
            5
        }
    }

    public fun enhancement_cost_for(arg0: u8) : u64 {
        enhancement_cost_raw(arg0)
    }

    fun enhancement_cost_raw(arg0: u8) : u64 {
        if (arg0 == 1) {
            1000000000 / 10
        } else if (arg0 == 2) {
            1000000000 / 5
        } else if (arg0 == 3) {
            3 * 1000000000 / 10
        } else if (arg0 == 4) {
            1000000000 / 2
        } else if (arg0 == 5) {
            1 * 1000000000
        } else if (arg0 == 6) {
            1000000000 / 10
        } else if (arg0 == 7) {
            1000000000 / 5
        } else if (arg0 == 8) {
            3 * 1000000000 / 10
        } else if (arg0 == 9) {
            1000000000 / 2
        } else if (arg0 == 10) {
            2 * 1000000000
        } else if (arg0 == 11) {
            3 * 1000000000
        } else if (arg0 == 12) {
            5 * 1000000000
        } else if (arg0 == 13) {
            8 * 1000000000
        } else if (arg0 == 14) {
            12 * 1000000000
        } else if (arg0 == 15) {
            10 * 1000000000
        } else if (arg0 == 16) {
            1000000000 / 100
        } else if (arg0 == 17) {
            3 * 1000000000 / 100
        } else if (arg0 == 18) {
            8 * 1000000000 / 100
        } else if (arg0 == 19) {
            1000000000 / 5
        } else {
            assert!(arg0 == 20, 9);
            1000000000 / 2
        }
    }

    fun enhancement_fee_split(arg0: u64) : (u64, u64, u64, u64, u64, u64) {
        let v0 = arg0 * 90 / 100;
        let v1 = arg0 * 2 / 100;
        let v2 = arg0 * 3 / 100;
        let v3 = arg0 * 2 / 100;
        let v4 = arg0 * 2 / 100;
        let v5 = arg0 * 1 / 100;
        assert!(v0 + v1 + v2 + v3 + v4 + v5 == arg0, 11);
        (v0, v1, v2, v3, v4, v5)
    }

    public fun enhancement_final_success_units_for(arg0: u8, arg1: u8) : u64 {
        let (_, _, v2) = enhancement_probability_snapshot_values(arg0, arg1);
        v2
    }

    public fun enhancement_multiplier_for(arg0: u8) : u64 {
        enhancement_multiplier_scaled(arg0)
    }

    fun enhancement_multiplier_scaled(arg0: u8) : u64 {
        if (arg0 == 0) {
            1
        } else if (arg0 == 1) {
            40000
        } else if (arg0 == 2) {
            120000
        } else if (arg0 == 3) {
            240000
        } else if (arg0 == 4) {
            450000
        } else if (arg0 == 5) {
            1200000
        } else if (arg0 == 6) {
            1250000
        } else if (arg0 == 7) {
            1350000
        } else if (arg0 == 8) {
            1550000
        } else if (arg0 == 9) {
            1900000
        } else if (arg0 == 10) {
            3000000
        } else if (arg0 == 11) {
            7000000
        } else if (arg0 == 12) {
            18000000
        } else if (arg0 == 13) {
            45000000
        } else if (arg0 == 14) {
            120000000
        } else if (arg0 == 15) {
            220000000
        } else if (arg0 == 16) {
            500000000
        } else if (arg0 == 17) {
            650000000
        } else if (arg0 == 18) {
            900000000
        } else if (arg0 == 19) {
            1300000000
        } else {
            assert!(arg0 == 20, 9);
            2000000000
        }
    }

    fun enhancement_probability_snapshot_values(arg0: u8, arg1: u8) : (u64, u64, u64) {
        let v0 = enhancement_success_units(arg0);
        let v1 = fever_constant_scaled(arg1);
        (v0, v1, apply_fever_probability_floor(v0, v1))
    }

    fun enhancement_roll_succeeds(arg0: u64, arg1: u64) : bool {
        assert!(arg1 <= 100000000, 11);
        assert!(arg0 < 100000000, 11);
        arg0 < arg1
    }

    public fun enhancement_success_scale() : u64 {
        100000000
    }

    fun enhancement_success_units(arg0: u8) : u64 {
        if (arg0 == 1) {
            95000000
        } else if (arg0 == 2) {
            90000000
        } else if (arg0 == 3) {
            85000000
        } else if (arg0 == 4) {
            80000000
        } else if (arg0 == 5) {
            40000000
        } else if (arg0 == 6) {
            70000000
        } else if (arg0 == 7) {
            60000000
        } else if (arg0 == 8) {
            50000000
        } else if (arg0 == 9) {
            40000000
        } else if (arg0 == 10) {
            20000000
        } else if (arg0 == 11) {
            12000000
        } else if (arg0 == 12) {
            7000000
        } else if (arg0 == 13) {
            4000000
        } else if (arg0 == 14) {
            2000000
        } else if (arg0 == 15) {
            1000000
        } else if (arg0 == 16) {
            500
        } else if (arg0 == 17) {
            300
        } else if (arg0 == 18) {
            500
        } else if (arg0 == 19) {
            800
        } else {
            assert!(arg0 == 20, 9);
            5000
        }
    }

    public fun enhancement_success_units_for(arg0: u8) : u64 {
        enhancement_success_units(arg0)
    }

    public fun fee_day_base_burn_finalized(arg0: &Economy, arg1: u64) : bool {
        let v0 = FeeDayKey{day: arg1};
        if (!0x2::dynamic_field::exists<FeeDayKey>(&arg0.id, v0)) {
            arg0.fever_state.has_closed_day && arg1 <= arg0.fever_state.last_closed_day
        } else {
            let v2 = FeeDayKey{day: arg1};
            0x2::dynamic_field::borrow<FeeDayKey, FeeDayPool>(&arg0.id, v2).base_burn_finalized
        }
    }

    public fun fee_day_base_burned_raw(arg0: &Economy, arg1: u64) : u64 {
        let v0 = FeeDayKey{day: arg1};
        if (!0x2::dynamic_field::exists<FeeDayKey>(&arg0.id, v0)) {
            0
        } else {
            let v2 = FeeDayKey{day: arg1};
            0x2::dynamic_field::borrow<FeeDayKey, FeeDayPool>(&arg0.id, v2).base_burned_raw
        }
    }

    public fun fever_activated(arg0: &Economy) : bool {
        arg0.fever_state.activated
    }

    fun fever_constant_scaled(arg0: u8) : u64 {
        if (arg0 == 1) {
            8500
        } else if (arg0 == 2) {
            8875
        } else if (arg0 == 3) {
            9250
        } else if (arg0 == 4) {
            9625
        } else if (arg0 == 5) {
            10000
        } else if (arg0 == 6) {
            10300
        } else if (arg0 == 7) {
            10600
        } else if (arg0 == 8) {
            10900
        } else if (arg0 == 9) {
            11200
        } else {
            assert!(arg0 == 10, 9);
            11500
        }
    }

    public fun fever_constant_scaled_for(arg0: u8) : u64 {
        fever_constant_scaled(arg0)
    }

    public fun fever_current_day(arg0: &Economy) : u64 {
        arg0.fever_state.current_day
    }

    public fun fever_current_level(arg0: &Economy) : u8 {
        arg0.fever_state.current_level
    }

    public fun fever_has_closed_day(arg0: &Economy) : bool {
        arg0.fever_state.has_closed_day
    }

    public fun fever_last_closed_day(arg0: &Economy) : u64 {
        arg0.fever_state.last_closed_day
    }

    fun fever_one_level_toward_desired(arg0: u8, arg1: u8) : u8 {
        assert!(arg0 >= 1 && arg0 <= 10, 9);
        assert!(arg1 >= 1 && arg1 <= 10, 9);
        if (arg1 < arg0) {
            arg0 - 1
        } else if (arg1 > arg0) {
            arg0 + 1
        } else {
            arg0
        }
    }

    public fun fever_probability_scale() : u64 {
        10000
    }

    public fun fever_tracked_supply_raw(arg0: &Economy) : u128 {
        arg0.fever_state.tracked_supply_raw
    }

    public fun holding_factor_scale() : u64 {
        100
    }

    fun holding_factor_scaled_from_raw(arg0: u64) : u64 {
        let v0 = holding_tier_from_raw(arg0);
        if (v0 == 1) {
            100
        } else if (v0 == 2) {
            175
        } else if (v0 == 3) {
            250
        } else if (v0 == 4) {
            325
        } else if (v0 == 5) {
            400
        } else if (v0 == 6) {
            440
        } else if (v0 == 7) {
            480
        } else if (v0 == 8) {
            520
        } else if (v0 == 9) {
            560
        } else {
            assert!(v0 == 10, 11);
            600
        }
    }

    fun holding_tier_from_raw(arg0: u64) : u64 {
        let v0 = arg0 / 2500000000000 + 1;
        if (v0 > 10) {
            10
        } else {
            v0
        }
    }

    fun inactive_fever_state() : FeverState {
        FeverState{
            activated          : false,
            current_day        : 0,
            current_level      : 0,
            tracked_supply_raw : 0,
            has_closed_day     : false,
            last_closed_day    : 0,
        }
    }

    fun increment_protocol_daily_mint_budget_version(arg0: &mut SettlementBook) : u64 {
        let v0 = ProtocolDailyMintBudgetVersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ProtocolDailyMintBudgetVersionKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<ProtocolDailyMintBudgetVersionKey, u64>(&mut arg0.id, v0);
            *v2 = *v2 + 1;
            *v2
        } else {
            0x2::dynamic_field::add<ProtocolDailyMintBudgetVersionKey, u64>(&mut arg0.id, v0, 1);
            1
        }
    }

    fun increment_protocol_reward_exclusion_version(arg0: &mut SettlementBook) : u64 {
        let v0 = ProtocolRewardExclusionVersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ProtocolRewardExclusionVersionKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<ProtocolRewardExclusionVersionKey, u64>(&mut arg0.id, v0);
            *v2 = *v2 + 1;
            *v2
        } else {
            0x2::dynamic_field::add<ProtocolRewardExclusionVersionKey, u64>(&mut arg0.id, v0, 1);
            1
        }
    }

    fun increment_settlement_authority_epoch(arg0: &mut SettlementBook) : u64 {
        let v0 = SettlementAuthorityEpochKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SettlementAuthorityEpochKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<SettlementAuthorityEpochKey, u64>(&mut arg0.id, v0);
            *v2 = *v2 + 1;
            *v2
        } else {
            0x2::dynamic_field::add<SettlementAuthorityEpochKey, u64>(&mut arg0.id, v0, 1);
            1
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = Economy{
            id                              : 0x2::object::new(arg0),
            marketing_wallet                : v0,
            total_enhancement_fees_raw      : 0,
            total_burned_raw                : 0,
            total_rank_rewards_reserved_raw : 0,
            total_marketing_paid_raw        : 0,
            fever_state                     : inactive_fever_state(),
        };
        let v2 = SettlementBook{
            id           : 0x2::object::new(arg0),
            authority    : v0,
            player_count : 0,
        };
        let v3 = &mut v2;
        apply_protocol_reward_exclusion(v3, v0, true);
        let v4 = ProtocolInitialized{
            publisher            : v0,
            marketing_wallet     : v0,
            settlement_authority : v0,
        };
        0x2::event::emit<ProtocolInitialized>(v4);
        0x2::transfer::share_object<Economy>(v1);
        0x2::transfer::share_object<SettlementBook>(v2);
    }

    public fun is_activity_snapshot_active(arg0: &SettlementBook, arg1: u64) : bool {
        let v0 = ActivitySnapshotKey{use_day: arg1};
        0x2::dynamic_field::exists<ActivitySnapshotKey>(&arg0.id, v0) && 0x2::dynamic_field::borrow<ActivitySnapshotKey, ActivitySnapshotRecord>(&arg0.id, v0).status == 2
    }

    public fun is_protocol_reward_excluded(arg0: &SettlementBook, arg1: address) : bool {
        let v0 = ProtocolRewardExclusionKey{wallet: arg1};
        0x2::dynamic_field::exists<ProtocolRewardExclusionKey>(&arg0.id, v0) && *0x2::dynamic_field::borrow<ProtocolRewardExclusionKey, bool>(&arg0.id, v0)
    }

    public fun lifetime_attempt_achieved_ms(arg0: &PlayerState) : u64 {
        arg0.lifetime_attempt_achieved_ms
    }

    public fun lifetime_enhancement_attempts(arg0: &PlayerState) : u64 {
        arg0.lifetime_enhancement_attempts
    }

    public fun lifetime_enhancement_successes(arg0: &PlayerState) : u64 {
        arg0.lifetime_enhancement_successes
    }

    public fun lifetime_success_achieved_ms(arg0: &PlayerState) : u64 {
        arg0.lifetime_success_achieved_ms
    }

    public fun max_daily_mint_raw_per_player() : u64 {
        25650 * 1000000000
    }

    public fun max_protocol_daily_mint_raw(arg0: &SettlementBook) : u64 {
        let v0 = ProtocolDailyMintCapKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ProtocolDailyMintCapKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<ProtocolDailyMintCapKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun merkle_node_hash(arg0: address, arg1: address, arg2: u8) : address {
        let v0 = 0x1::bcs::to_bytes<u8>(&arg2);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg0));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg1));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v0))
    }

    fun mining_leaf_hash(arg0: u64, arg1: address, arg2: u64) : address {
        let v0 = 3;
        let v1 = 0x1::bcs::to_bytes<u8>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg2));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun mining_leaf_hash_for(arg0: u64, arg1: address, arg2: u64) : address {
        mining_leaf_hash(arg0, arg1, arg2)
    }

    fun mining_total_within_player_cap(arg0: u64, arg1: u64) : bool {
        if (arg0 == 0) {
            true
        } else if (arg1 == 0) {
            false
        } else {
            let v1 = max_daily_mint_raw_per_player();
            let v2 = arg0 / v1;
            v2 < arg1 || v2 == arg1 && arg0 % v1 == 0
        }
    }

    public fun mining_v2_empty_root() : address {
        let v0 = 10;
        let v1 = 0x1::bcs::to_bytes<u8>(&v0);
        0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun mining_v2_leaf_hash_for(arg0: u8, arg1: u64, arg2: u32, arg3: u64, arg4: address, arg5: u64, arg6: address, arg7: u64, arg8: u8) : address {
        let v0 = 9;
        let v1 = 0x1::bcs::to_bytes<u8>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u8>(&arg0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u32>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg4));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg5));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg6));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg7));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u8>(&arg8));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun mining_v2_node_hash_for(arg0: address, arg1: address) : address {
        merkle_node_hash(arg0, arg1, 10)
    }

    public fun mining_v2_root_status(arg0: &SettlementBook, arg1: u64) : u8 {
        let v0 = MiningV2RootKey{day: arg1};
        assert!(0x2::dynamic_field::exists<MiningV2RootKey>(&arg0.id, v0), 40);
        0x2::dynamic_field::borrow<MiningV2RootKey, MiningV2RootRecord>(&arg0.id, v0).status
    }

    fun paid_attempt_cooldown_ready(arg0: &PlayerState, arg1: u64) : bool {
        arg0.lifetime_enhancement_attempts == 0 || arg1 < arg0.pending_started_ms && false || arg1 - arg0.pending_started_ms >= 5000
    }

    public fun pay_ranking_reward(arg0: &SettlementBook, arg1: &mut RewardPayoutDay, arg2: u8, arg3: u64, arg4: address, arg5: vector<address>, arg6: vector<bool>, arg7: &mut 0x2::tx_context::TxContext) {
        assert_protocol_reward_eligible(arg0, arg4);
        pay_ranking_reward_internal(arg1, arg2, arg3, arg4, arg5, arg6, arg7);
    }

    fun pay_ranking_reward_internal(arg0: &mut RewardPayoutDay, arg1: u8, arg2: u64, arg3: address, arg4: vector<address>, arg5: vector<bool>, arg6: &mut 0x2::tx_context::TxContext) {
        let v0 = RewardClaimKey{
            category : arg1,
            wallet   : arg3,
        };
        assert!(!0x2::dynamic_field::exists<RewardClaimKey>(&arg0.id, v0), 26);
        let (v1, v2, v3) = reward_category_info(arg0, arg1);
        assert!(v2 > 0, 27);
        assert!(arg2 < v2, 25);
        assert!(verify_merkle_proof(v1, reward_leaf_hash(arg0.day, arg1, arg2, arg3), &arg4, &arg5, 6), 16);
        let v4 = ranking_reward_share(v3, v2, arg2);
        assert!(v4 > 0, 27);
        let v5 = take_reward_balance(arg0, arg1, v4);
        0x2::dynamic_field::add<RewardClaimKey, bool>(&mut arg0.id, v0, true);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>>(0x2::coin::from_balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(v5, arg6), arg3);
        let v6 = RankingRewardPaid{
            day          : arg0.day,
            category     : arg1,
            wallet       : arg3,
            winner_index : arg2,
            amount_raw   : v4,
        };
        0x2::event::emit<RankingRewardPaid>(v6);
    }

    public fun player_count(arg0: &SettlementBook) : u64 {
        arg0.player_count
    }

    public fun player_level(arg0: &PlayerState) : u8 {
        arg0.level
    }

    public fun player_level_for_day(arg0: &PlayerState, arg1: u64) : u8 {
        if (arg0.daily_success_day == arg1) {
            arg0.level
        } else {
            0
        }
    }

    public fun player_pending_attempt_day(arg0: &PlayerState) : u64 {
        arg0.pending_attempt_day
    }

    public fun player_pending_base_success_units(arg0: &PlayerState) : u64 {
        arg0.pending_base_success_units
    }

    public fun player_pending_fever_constant_scaled(arg0: &PlayerState) : u64 {
        arg0.pending_fever_constant_scaled
    }

    public fun player_pending_fever_level(arg0: &PlayerState) : u8 {
        arg0.pending_fever_level
    }

    public fun player_pending_success_units(arg0: &PlayerState) : u64 {
        arg0.pending_success_units
    }

    public fun propose_activity_snapshot(arg0: &mut SettlementBook, arg1: u64, arg2: address, arg3: u8, arg4: u32, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: &0x2::clock::Clock, arg10: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg9);
        propose_activity_snapshot_internal(arg0, arg1, arg2, arg3, arg4, arg5, arg6, arg7, arg8, v0, v0 / 86400000, 0x2::tx_context::sender(arg10));
    }

    fun propose_activity_snapshot_internal(arg0: &mut SettlementBook, arg1: u64, arg2: address, arg3: u8, arg4: u32, arg5: u64, arg6: u64, arg7: u64, arg8: u64, arg9: u64, arg10: u64, arg11: address) {
        assert!(arg11 == arg0.authority, 12);
        validate_activity_snapshot_proposal(arg0, arg1, arg2, arg3, arg5, arg7, arg8, arg10);
        let v0 = arg9 + 21600000;
        let v1 = settlement_authority_epoch(arg0);
        let v2 = ActivitySnapshotKey{use_day: arg1};
        let v3 = if (0x2::dynamic_field::exists<ActivitySnapshotKey>(&arg0.id, v2)) {
            let v4 = 0x2::dynamic_field::borrow_mut<ActivitySnapshotKey, ActivitySnapshotRecord>(&mut arg0.id, v2);
            assert!(v4.status != 2, 37);
            assert!(v4.status == 3, 38);
            let v5 = v4.revision + 1;
            let v6 = ActivitySnapshotRecord{
                root              : arg2,
                policy_version    : arg3,
                month_id          : arg4,
                month_start_day   : arg5,
                cutoff_checkpoint : arg6,
                exclusion_version : arg7,
                eligible_count    : arg8,
                status            : 1,
                proposed_ms       : arg9,
                activates_ms      : v0,
                revision          : v5,
                authority_epoch   : v1,
            };
            *v4 = v6;
            v5
        } else {
            let v7 = ActivitySnapshotRecord{
                root              : arg2,
                policy_version    : arg3,
                month_id          : arg4,
                month_start_day   : arg5,
                cutoff_checkpoint : arg6,
                exclusion_version : arg7,
                eligible_count    : arg8,
                status            : 1,
                proposed_ms       : arg9,
                activates_ms      : v0,
                revision          : 1,
                authority_epoch   : v1,
            };
            0x2::dynamic_field::add<ActivitySnapshotKey, ActivitySnapshotRecord>(&mut arg0.id, v2, v7);
            1
        };
        let v8 = ActivitySnapshotProposed{
            use_day           : arg1,
            root              : arg2,
            policy_version    : arg3,
            month_id          : arg4,
            month_start_day   : arg5,
            cutoff_checkpoint : arg6,
            exclusion_version : arg7,
            eligible_count    : arg8,
            proposed_ms       : arg9,
            activates_ms      : v0,
            revision          : v3,
            authority_epoch   : v1,
        };
        0x2::event::emit<ActivitySnapshotProposed>(v8);
    }

    public fun propose_mining_v2_root(arg0: &mut SettlementBook, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        propose_mining_v2_root_internal(arg0, arg1, arg2, arg3, v0, v0 / 86400000, 0x2::tx_context::sender(arg5));
    }

    fun propose_mining_v2_root_internal(arg0: &mut SettlementBook, arg1: u64, arg2: address, arg3: u64, arg4: u64, arg5: u64, arg6: address) {
        assert!(arg6 == arg0.authority, 12);
        assert!(arg1 < arg5, 18);
        assert!(mining_total_within_player_cap(arg3, arg0.player_count), 20);
        assert!(protocol_daily_mint_within_budget(arg3, max_protocol_daily_mint_raw(arg0)), 29);
        if (arg3 == 0) {
            assert!(arg2 == mining_v2_empty_root(), 45);
        } else {
            assert!(arg2 != @0x0, 45);
            assert!(arg2 != mining_v2_empty_root(), 45);
        };
        let v0 = MiningRootKey{day: arg1};
        assert!(!0x2::dynamic_field::exists<MiningRootKey>(&arg0.id, v0), 49);
        let v1 = ActivitySnapshotKey{use_day: arg1};
        assert!(0x2::dynamic_field::exists<ActivitySnapshotKey>(&arg0.id, v1), 31);
        let v2 = 0x2::dynamic_field::borrow<ActivitySnapshotKey, ActivitySnapshotRecord>(&arg0.id, v1);
        assert!(v2.status == 2, 39);
        let v3 = v2.root;
        let v4 = v2.policy_version;
        let v5 = v2.month_id;
        let v6 = v2.month_start_day;
        let v7 = v2.revision;
        let v8 = arg4 + 21600000;
        let v9 = settlement_authority_epoch(arg0);
        let v10 = protocol_daily_mint_budget_version(arg0);
        let v11 = MiningV2RootKey{day: arg1};
        let v12 = if (0x2::dynamic_field::exists<MiningV2RootKey>(&arg0.id, v11)) {
            let v13 = 0x2::dynamic_field::borrow_mut<MiningV2RootKey, MiningV2RootRecord>(&mut arg0.id, v11);
            assert!(v13.status != 2, 46);
            assert!(v13.status == 3, 47);
            let v14 = v13.revision + 1;
            let v15 = MiningV2RootRecord{
                root              : arg2,
                total_mint_raw    : arg3,
                claimed_mint_raw  : 0,
                activity_root     : v3,
                policy_version    : v4,
                month_id          : v5,
                month_start_day   : v6,
                activity_revision : v7,
                status            : 1,
                proposed_ms       : arg4,
                activates_ms      : v8,
                revision          : v14,
                authority_epoch   : v9,
                budget_version    : v10,
            };
            *v13 = v15;
            v14
        } else {
            let v16 = MiningV2RootRecord{
                root              : arg2,
                total_mint_raw    : arg3,
                claimed_mint_raw  : 0,
                activity_root     : v3,
                policy_version    : v4,
                month_id          : v5,
                month_start_day   : v6,
                activity_revision : v7,
                status            : 1,
                proposed_ms       : arg4,
                activates_ms      : v8,
                revision          : 1,
                authority_epoch   : v9,
                budget_version    : v10,
            };
            0x2::dynamic_field::add<MiningV2RootKey, MiningV2RootRecord>(&mut arg0.id, v11, v16);
            1
        };
        let v17 = MiningV2RootProposed{
            day               : arg1,
            root              : arg2,
            total_mint_raw    : arg3,
            activity_root     : v3,
            policy_version    : v4,
            month_id          : v5,
            month_start_day   : v6,
            activity_revision : v7,
            proposed_ms       : arg4,
            activates_ms      : v8,
            revision          : v12,
            authority_epoch   : v9,
            budget_version    : v10,
        };
        0x2::event::emit<MiningV2RootProposed>(v17);
    }

    public fun protocol_daily_mint_budget_version(arg0: &SettlementBook) : u64 {
        let v0 = ProtocolDailyMintBudgetVersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ProtocolDailyMintBudgetVersionKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<ProtocolDailyMintBudgetVersionKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    fun protocol_daily_mint_within_budget(arg0: u64, arg1: u64) : bool {
        arg0 <= arg1
    }

    public fun protocol_reward_exclusion_version(arg0: &SettlementBook) : u64 {
        let v0 = ProtocolRewardExclusionVersionKey{dummy_field: false};
        if (0x2::dynamic_field::exists<ProtocolRewardExclusionVersionKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<ProtocolRewardExclusionVersionKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun publish_mining_root(arg0: &mut SettlementBook, arg1: u64, arg2: address, arg3: u64, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg5) == arg0.authority, 12);
        assert!(arg1 < 0x2::clock::timestamp_ms(arg4) / 86400000, 18);
        assert!(mining_total_within_player_cap(arg3, arg0.player_count), 20);
        assert!(protocol_daily_mint_within_budget(arg3, max_protocol_daily_mint_raw(arg0)), 29);
        let v0 = MiningV2RootKey{day: arg1};
        assert!(!0x2::dynamic_field::exists<MiningV2RootKey>(&arg0.id, v0), 49);
        let v1 = MiningRootKey{day: arg1};
        assert!(!0x2::dynamic_field::exists<MiningRootKey>(&arg0.id, v1), 13);
        let v2 = MiningRootRecord{
            root             : arg2,
            total_mint_raw   : arg3,
            claimed_mint_raw : 0,
        };
        0x2::dynamic_field::add<MiningRootKey, MiningRootRecord>(&mut arg0.id, v1, v2);
        let v3 = MiningRootPublished{
            day            : arg1,
            root           : arg2,
            total_mint_raw : arg3,
        };
        0x2::event::emit<MiningRootPublished>(v3);
    }

    public fun publish_reward_snapshot(arg0: &mut SettlementBook, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: address, arg6: u64, arg7: u64, arg8: address, arg9: address, arg10: u64, arg11: u64, arg12: address, arg13: address, arg14: u64, arg15: u64, arg16: address, arg17: address, arg18: &0x2::clock::Clock, arg19: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg19) == arg0.authority, 12);
        assert!(arg1 < 0x2::clock::timestamp_ms(arg18) / 86400000, 18);
        validate_reward_category(arg2, arg3, arg4, arg5);
        validate_reward_category(arg6, arg7, arg8, arg9);
        validate_reward_category(arg10, arg11, arg12, arg13);
        validate_reward_category(arg14, arg15, arg16, arg17);
        let v0 = RewardSnapshotKey{day: arg1};
        assert!(!0x2::dynamic_field::exists<RewardSnapshotKey>(&arg0.id, v0), 21);
        let v1 = RewardSnapshotRecord{
            holding_top_raw                 : arg2,
            holding_winner_count            : arg3,
            holding_root                    : arg4,
            holding_representative          : arg5,
            daily_success_top               : arg6,
            daily_success_winner_count      : arg7,
            daily_success_root              : arg8,
            daily_success_representative    : arg9,
            lifetime_success_top            : arg10,
            lifetime_success_winner_count   : arg11,
            lifetime_success_root           : arg12,
            lifetime_success_representative : arg13,
            lifetime_attempt_top            : arg14,
            lifetime_attempt_winner_count   : arg15,
            lifetime_attempt_root           : arg16,
            lifetime_attempt_representative : arg17,
        };
        0x2::dynamic_field::add<RewardSnapshotKey, RewardSnapshotRecord>(&mut arg0.id, v0, v1);
        let v2 = RewardSnapshotPublished{
            day                             : arg1,
            holding_top_raw                 : arg2,
            holding_winner_count            : arg3,
            holding_representative          : arg5,
            daily_success_top               : arg6,
            daily_success_winner_count      : arg7,
            daily_success_representative    : arg9,
            lifetime_success_top            : arg10,
            lifetime_success_winner_count   : arg11,
            lifetime_success_representative : arg13,
            lifetime_attempt_top            : arg14,
            lifetime_attempt_winner_count   : arg15,
            lifetime_attempt_representative : arg17,
        };
        0x2::event::emit<RewardSnapshotPublished>(v2);
    }

    fun ranking_reward_share(arg0: u64, arg1: u64, arg2: u64) : u64 {
        assert!(arg1 > 0, 27);
        assert!(arg2 < arg1, 25);
        let v0 = if (arg2 < arg0 % arg1) {
            1
        } else {
            0
        };
        arg0 / arg1 + v0
    }

    fun reserve_or_burn_rank_pool(arg0: &mut 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolTreasury, arg1: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : (0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>, u64, u64) {
        if (arg2 == 0) {
            (0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(), 0, burn_balance_current_day(arg0, arg1, arg3, arg4))
        } else {
            (arg1, 0x2::balance::value<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&arg1), 0)
        }
    }

    entry fun resolve_enhancement(arg0: &mut PlayerState, arg1: &0x2::random::Random, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert_owner(arg0, arg3);
        assert!(arg0.pending_enhancement, 6);
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 > arg0.pending_started_ms, 8);
        let v1 = arg0.pending_attempt_day;
        let v2 = arg0.pending_fever_level;
        let v3 = arg0.pending_fever_constant_scaled;
        let v4 = arg0.pending_base_success_units;
        let v5 = arg0.level;
        let v6 = arg0.pending_target_level;
        let v7 = arg0.pending_success_units;
        assert!(v7 <= 100000000, 11);
        let v8 = 0x2::random::new_generator(arg1, arg3);
        let v9 = 0x2::random::generate_u64_in_range(&mut v8, 0, 100000000 - 1);
        let v10 = enhancement_roll_succeeds(v9, v7);
        let v11 = v0 / 86400000;
        let (v12, v13, v14) = apply_enhancement_result(arg0, v6, v10, v1, v0);
        sync_daily_level(arg0, v11);
        arg0.pending_enhancement = false;
        arg0.pending_target_level = 0;
        arg0.pending_attempt_day = 0;
        arg0.pending_fever_level = 0;
        arg0.pending_fever_constant_scaled = 0;
        arg0.pending_base_success_units = 0;
        arg0.pending_success_units = 0;
        let v15 = EnhancementResolved{
            owner                        : arg0.owner,
            attempt_utc_day              : v1,
            fever_level                  : v2,
            fever_constant_scaled        : v3,
            base_success_units           : v4,
            final_success_units          : v7,
            from_level                   : v5,
            target_level                 : v6,
            to_level                     : v12,
            success                      : v10,
            roll                         : v9,
            success_units                : v7,
            resolve_utc_day              : v11,
            lifetime_attempts            : arg0.lifetime_enhancement_attempts,
            lifetime_successes           : arg0.lifetime_enhancement_successes,
            lifetime_success_achieved_ms : arg0.lifetime_success_achieved_ms,
            daily_success_count          : v13,
            daily_success_achieved_ms    : v14,
        };
        0x2::event::emit<EnhancementResolved>(v15);
    }

    fun reward_category_info(arg0: &RewardPayoutDay, arg1: u8) : (address, u64, u64) {
        if (arg1 == 1) {
            (arg0.holding_root, arg0.holding_winner_count, arg0.holding_total_raw)
        } else if (arg1 == 2) {
            (arg0.daily_success_root, arg0.daily_success_winner_count, arg0.daily_success_total_raw)
        } else if (arg1 == 3) {
            (arg0.lifetime_success_root, arg0.lifetime_success_winner_count, arg0.lifetime_success_total_raw)
        } else {
            assert!(arg1 == 4, 24);
            (arg0.lifetime_attempt_root, arg0.lifetime_attempt_winner_count, arg0.lifetime_attempt_total_raw)
        }
    }

    fun reward_leaf_hash(arg0: u64, arg1: u8, arg2: u64, arg3: address) : address {
        let v0 = 5;
        let v1 = 0x1::bcs::to_bytes<u8>(&v0);
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg0));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u8>(&arg1));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<u64>(&arg2));
        0x1::vector::append<u8>(&mut v1, 0x1::bcs::to_bytes<address>(&arg3));
        0x2::address::from_bytes(0x2::hash::blake2b256(&v1))
    }

    public fun reward_leaf_hash_for(arg0: u64, arg1: u8, arg2: u64, arg3: address) : address {
        reward_leaf_hash(arg0, arg1, arg2, arg3)
    }

    public fun set_marketing_wallet(arg0: &0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolAdminCap, arg1: &mut Economy, arg2: &mut SettlementBook, arg3: address) {
        apply_protocol_reward_exclusion(arg2, arg3, true);
        arg1.marketing_wallet = arg3;
        let v0 = MarketingWalletChanged{
            old_wallet : arg1.marketing_wallet,
            new_wallet : arg3,
        };
        0x2::event::emit<MarketingWalletChanged>(v0);
    }

    public fun set_max_protocol_daily_mint_raw(arg0: &0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolAdminCap, arg1: &mut SettlementBook, arg2: u64) {
        let v0 = write_protocol_daily_mint_budget(arg1, arg2);
        let v1 = ProtocolDailyMintCapChanged{
            old_max_raw    : v0,
            new_max_raw    : arg2,
            budget_version : protocol_daily_mint_budget_version(arg1),
        };
        0x2::event::emit<ProtocolDailyMintCapChanged>(v1);
    }

    public fun set_protocol_reward_excluded(arg0: &0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolAdminCap, arg1: &mut SettlementBook, arg2: address, arg3: bool) {
        apply_protocol_reward_exclusion(arg1, arg2, arg3);
    }

    public fun set_settlement_authority(arg0: &0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolAdminCap, arg1: &mut SettlementBook, arg2: address) {
        let v0 = arg1.authority;
        apply_protocol_reward_exclusion(arg1, arg2, true);
        let v1 = if (v0 != arg2) {
            increment_settlement_authority_epoch(arg1)
        } else {
            settlement_authority_epoch(arg1)
        };
        arg1.authority = arg2;
        let v2 = SettlementAuthorityChanged{
            old_authority   : v0,
            new_authority   : arg2,
            authority_epoch : v1,
        };
        0x2::event::emit<SettlementAuthorityChanged>(v2);
    }

    public fun settle_fee_day(arg0: &mut Economy, arg1: &SettlementBook, arg2: &mut 0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::ProtocolTreasury, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg3 < 0x2::clock::timestamp_ms(arg4) / 86400000, 18);
        let v0 = RewardSnapshotKey{day: arg3};
        assert!(0x2::dynamic_field::exists<RewardSnapshotKey>(&arg1.id, v0), 22);
        let v1 = FeeDayKey{day: arg3};
        assert!(0x2::dynamic_field::exists<FeeDayKey>(&arg0.id, v1), 19);
        let v2 = 0x2::dynamic_field::borrow<FeeDayKey, FeeDayPool>(&arg0.id, v1);
        assert_base_burn_finalized_value(v2.base_burn_finalized);
        let v3 = v2.base_burned_raw;
        let v4 = 0x2::dynamic_field::borrow<RewardSnapshotKey, RewardSnapshotRecord>(&arg1.id, v0);
        let v5 = v4.holding_winner_count;
        let v6 = v4.daily_success_winner_count;
        let v7 = v4.lifetime_success_winner_count;
        let v8 = v4.lifetime_attempt_winner_count;
        let FeeDayPool {
            marketing_wallet             : v9,
            burn_pool                    : v10,
            holding_reward_pool          : v11,
            daily_success_reward_pool    : v12,
            lifetime_success_reward_pool : v13,
            lifetime_attempt_reward_pool : v14,
            marketing_pool               : v15,
            base_burn_finalized          : _,
            base_burned_raw              : _,
        } = 0x2::dynamic_field::remove<FeeDayKey, FeeDayPool>(&mut arg0.id, v1);
        let v18 = v10;
        assert!(0x2::balance::value<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&v18) == 0, 11);
        0x2::balance::destroy_zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(v18);
        let (v19, v20, v21) = reserve_or_burn_rank_pool(arg2, v11, v5, arg4, arg5);
        let (v22, v23, v24) = reserve_or_burn_rank_pool(arg2, v12, v6, arg4, arg5);
        let (v25, v26, v27) = reserve_or_burn_rank_pool(arg2, v13, v7, arg4, arg5);
        let (v28, v29, v30) = reserve_or_burn_rank_pool(arg2, v14, v8, arg4, arg5);
        let v31 = transfer_balance(v15, v9, arg5);
        let v32 = v21 + v24 + v27 + v30;
        arg0.total_burned_raw = arg0.total_burned_raw + v32;
        arg0.total_rank_rewards_reserved_raw = arg0.total_rank_rewards_reserved_raw + v20 + v23 + v26 + v29;
        arg0.total_marketing_paid_raw = arg0.total_marketing_paid_raw + v31;
        let v33 = RewardPayoutDay{
            id                            : 0x2::object::new(arg5),
            day                           : arg3,
            holding_root                  : v4.holding_root,
            holding_winner_count          : v5,
            holding_total_raw             : v20,
            holding_remaining             : v19,
            daily_success_root            : v4.daily_success_root,
            daily_success_winner_count    : v6,
            daily_success_total_raw       : v23,
            daily_success_remaining       : v22,
            lifetime_success_root         : v4.lifetime_success_root,
            lifetime_success_winner_count : v7,
            lifetime_success_total_raw    : v26,
            lifetime_success_remaining    : v25,
            lifetime_attempt_root         : v4.lifetime_attempt_root,
            lifetime_attempt_winner_count : v8,
            lifetime_attempt_total_raw    : v29,
            lifetime_attempt_remaining    : v28,
        };
        0x2::transfer::share_object<RewardPayoutDay>(v33);
        let v34 = FeeDaySettled{
            day                           : arg3,
            base_burned_raw               : v3,
            unawarded_burned_raw          : v32,
            total_burned_raw              : v3 + v32,
            holding_reserved_raw          : v20,
            daily_success_reserved_raw    : v23,
            lifetime_success_reserved_raw : v26,
            lifetime_attempt_reserved_raw : v29,
            marketing_paid_raw            : v31,
            holding_winner_count          : v5,
            daily_success_winner_count    : v6,
            lifetime_success_winner_count : v7,
            lifetime_attempt_winner_count : v8,
        };
        0x2::event::emit<FeeDaySettled>(v34);
    }

    public fun settlement_authority_epoch(arg0: &SettlementBook) : u64 {
        let v0 = SettlementAuthorityEpochKey{dummy_field: false};
        if (0x2::dynamic_field::exists<SettlementAuthorityEpochKey>(&arg0.id, v0)) {
            *0x2::dynamic_field::borrow<SettlementAuthorityEpochKey, u64>(&arg0.id, v0)
        } else {
            0
        }
    }

    public fun start_enhancement(arg0: &mut Economy, arg1: &mut PlayerState, arg2: 0x2::coin::Coin<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        assert_fever_current_day(arg0, arg3);
        assert_owner(arg1, arg4);
        assert!(!arg1.pending_enhancement, 5);
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = v0 / 86400000;
        sync_daily_level(arg1, v1);
        assert!(paid_attempt_cooldown_ready(arg1, v0), 28);
        assert!(arg1.level < 20, 4);
        let v2 = arg1.level + 1;
        let v3 = arg0.fever_state.current_level;
        let (v4, v5, v6) = enhancement_probability_snapshot_values(v2, v3);
        let v7 = enhancement_cost_raw(v2);
        assert!(0x2::coin::value<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&arg2) == v7, 7);
        let (v8, v9, v10, v11, v12, v13) = enhancement_fee_split(v7);
        let v14 = 0x2::coin::into_balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(arg2);
        assert!(0x2::balance::value<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&v14) == v8, 11);
        let v15 = FeeDayKey{day: v1};
        if (!0x2::dynamic_field::exists<FeeDayKey>(&arg0.id, v15)) {
            let v16 = FeeDayPool{
                marketing_wallet             : arg0.marketing_wallet,
                burn_pool                    : 0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(),
                holding_reward_pool          : 0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(),
                daily_success_reward_pool    : 0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(),
                lifetime_success_reward_pool : 0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(),
                lifetime_attempt_reward_pool : 0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(),
                marketing_pool               : 0x2::balance::zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(),
                base_burn_finalized          : false,
                base_burned_raw              : 0,
            };
            0x2::dynamic_field::add<FeeDayKey, FeeDayPool>(&mut arg0.id, v15, v16);
        };
        let v17 = 0x2::dynamic_field::borrow_mut<FeeDayKey, FeeDayPool>(&mut arg0.id, v15);
        0x2::balance::join<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v17.burn_pool, v14);
        0x2::balance::join<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v17.holding_reward_pool, 0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v14, v9));
        0x2::balance::join<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v17.daily_success_reward_pool, 0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v14, v10));
        0x2::balance::join<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v17.lifetime_success_reward_pool, 0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v14, v11));
        0x2::balance::join<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v17.lifetime_attempt_reward_pool, 0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v14, v12));
        0x2::balance::join<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v17.marketing_pool, 0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut v14, v13));
        arg0.total_enhancement_fees_raw = arg0.total_enhancement_fees_raw + v7;
        arg1.lifetime_enhancement_attempts = arg1.lifetime_enhancement_attempts + 1;
        arg1.lifetime_attempt_achieved_ms = v0;
        arg1.pending_enhancement = true;
        arg1.pending_target_level = v2;
        arg1.pending_started_ms = v0;
        arg1.pending_attempt_day = v1;
        arg1.pending_fever_level = v3;
        arg1.pending_fever_constant_scaled = v5;
        arg1.pending_base_success_units = v4;
        arg1.pending_success_units = v6;
        let v18 = EnhancementStarted{
            owner                       : arg1.owner,
            utc_day                     : v1,
            from_level                  : arg1.level,
            target_level                : v2,
            fever_level                 : v3,
            fever_constant_scaled       : v5,
            base_success_units          : v4,
            final_success_units         : v6,
            cost_raw                    : v7,
            burn_pending_raw            : v8,
            holding_reward_raw          : v9,
            daily_success_reward_raw    : v10,
            lifetime_success_reward_raw : v11,
            lifetime_attempt_reward_raw : v12,
            marketing_raw               : v13,
            lifetime_attempts_after     : arg1.lifetime_enhancement_attempts,
            attempt_achieved_ms         : v0,
        };
        0x2::event::emit<EnhancementStarted>(v18);
    }

    fun sync_daily_level(arg0: &mut PlayerState, arg1: u64) {
        if (arg0.daily_success_day != arg1) {
            arg0.level = 0;
        };
    }

    fun take_reward_balance(arg0: &mut RewardPayoutDay, arg1: u8, arg2: u64) : 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS> {
        if (arg1 == 1) {
            0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut arg0.holding_remaining, arg2)
        } else if (arg1 == 2) {
            0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut arg0.daily_success_remaining, arg2)
        } else if (arg1 == 3) {
            0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut arg0.lifetime_success_remaining, arg2)
        } else {
            assert!(arg1 == 4, 24);
            0x2::balance::split<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&mut arg0.lifetime_attempt_remaining, arg2)
        }
    }

    fun tracked_supply_after_closed_day(arg0: u128, arg1: u128, arg2: u128) : u128 {
        if (arg1 >= arg2) {
            arg0 + arg1 - arg2
        } else {
            let v1 = arg2 - arg1;
            assert!(arg0 >= v1, 20506);
            arg0 - v1
        }
    }

    fun transfer_balance(arg0: 0x2::balance::Balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>, arg1: address, arg2: &mut 0x2::tx_context::TxContext) : u64 {
        let v0 = 0x2::balance::value<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(&arg0);
        if (v0 == 0) {
            0x2::balance::destroy_zero<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(arg0);
            0
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>>(0x2::coin::from_balance<0x68f8355f65af278cd8b7bee35de76f9241126a098ffc46f16d647b09e6f71dc8::ss::SS>(arg0, arg2), arg1);
            v0
        }
    }

    fun validate_activity_snapshot_proposal(arg0: &SettlementBook, arg1: u64, arg2: address, arg3: u8, arg4: u64, arg5: u64, arg6: u64, arg7: u64) {
        assert!(arg1 <= arg7, 36);
        assert!(arg3 == 1, 35);
        assert!(arg4 <= arg1, 35);
        assert!(arg5 <= protocol_reward_exclusion_version(arg0), 35);
        if (arg6 == 0) {
            assert!(arg2 == activity_v1_empty_root(), 35);
        } else {
            assert!(arg2 != @0x0, 35);
            assert!(arg2 != activity_v1_empty_root(), 35);
        };
    }

    fun validate_reward_category(arg0: u64, arg1: u64, arg2: address, arg3: address) {
        if (arg0 == 0) {
            assert!(arg1 == 0, 23);
            assert!(arg2 == @0x0, 23);
            assert!(arg3 == @0x0, 23);
        } else {
            assert!(arg1 > 0, 23);
            assert!(arg2 != @0x0, 23);
            assert!(arg3 != @0x0, 23);
        };
    }

    fun verify_merkle_proof(arg0: address, arg1: address, arg2: &vector<address>, arg3: &vector<bool>, arg4: u8) : bool {
        if (0x1::vector::length<address>(arg2) != 0x1::vector::length<bool>(arg3)) {
            return false
        };
        let v0 = arg1;
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(arg2)) {
            let v2 = if (*0x1::vector::borrow<bool>(arg3, v1)) {
                merkle_node_hash(*0x1::vector::borrow<address>(arg2, v1), v0, arg4)
            } else {
                merkle_node_hash(v0, *0x1::vector::borrow<address>(arg2, v1), arg4)
            };
            v0 = v2;
            v1 = v1 + 1;
        };
        v0 == arg0
    }

    public fun wallet_holding_constant(arg0: u64) : u64 {
        holding_tier_from_raw(arg0)
    }

    public fun wallet_holding_factor_scaled(arg0: u64) : u64 {
        holding_factor_scaled_from_raw(arg0)
    }

    fun write_protocol_daily_mint_budget(arg0: &mut SettlementBook, arg1: u64) : u64 {
        let v0 = ProtocolDailyMintCapKey{dummy_field: false};
        let v1 = if (0x2::dynamic_field::exists<ProtocolDailyMintCapKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<ProtocolDailyMintCapKey, u64>(&mut arg0.id, v0);
            *v2 = arg1;
            *v2
        } else {
            0x2::dynamic_field::add<ProtocolDailyMintCapKey, u64>(&mut arg0.id, v0, arg1);
            0
        };
        increment_protocol_daily_mint_budget_version(arg0);
        v1
    }

    fun write_protocol_reward_exclusion(arg0: &mut SettlementBook, arg1: address, arg2: bool) : bool {
        let v0 = ProtocolRewardExclusionKey{wallet: arg1};
        if (0x2::dynamic_field::exists<ProtocolRewardExclusionKey>(&arg0.id, v0)) {
            let v2 = 0x2::dynamic_field::borrow_mut<ProtocolRewardExclusionKey, bool>(&mut arg0.id, v0);
            *v2 = arg2;
            *v2
        } else {
            0x2::dynamic_field::add<ProtocolRewardExclusionKey, bool>(&mut arg0.id, v0, arg2);
            false
        }
    }

    // decompiled from Move bytecode v7
}

