module 0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::reputation {
    struct ProfileOwnerKey has copy, drop, store {
        owner: address,
    }

    struct ParticipantReputationKey has copy, drop, store {
        owner: address,
    }

    struct ReputationFeeConfig has key {
        id: 0x2::object::UID,
        profile_count: u64,
        reference_exec_gas: u64,
        init_multiplier_bps: u64,
        init_min_sui: u64,
        init_max_sui: u64,
        treasury_sink: address,
        pending_reference_exec_gas: u64,
        pending_init_multiplier_bps: u64,
        pending_init_min_sui: u64,
        pending_init_max_sui: u64,
        pending_treasury_sink: address,
        pending_effective_at_ms: u64,
        has_pending_update: bool,
        pending_treasury_approved: bool,
        timelock_ms: u64,
        updated_at_ms: u64,
    }

    struct ReputationProfile has key {
        id: 0x2::object::UID,
        owner: address,
        init_fee_paid: u64,
        seller_completed_orders: u64,
        seller_disputed_orders: u64,
        seller_settled_milestones: u64,
        seller_rejected_milestones: u64,
        seller_refunded_milestones: u64,
        seller_deadline_misses: u64,
        buyer_completed_orders: u64,
        buyer_disputed_orders: u64,
        buyer_manual_review_actions: u64,
        buyer_auto_release_misses: u64,
        seller_score: u64,
        seller_confidence: u64,
        seller_level: u8,
        buyer_score: u64,
        buyer_confidence: u64,
        buyer_level: u8,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct ParticipantReputationState has store {
        owner: address,
        seller_completed_orders: u64,
        seller_disputed_orders: u64,
        seller_settled_milestones: u64,
        seller_rejected_milestones: u64,
        seller_refunded_milestones: u64,
        seller_deadline_misses: u64,
        buyer_completed_orders: u64,
        buyer_disputed_orders: u64,
        buyer_manual_review_actions: u64,
        buyer_auto_release_misses: u64,
        seller_score: u64,
        seller_confidence: u64,
        seller_level: u8,
        buyer_score: u64,
        buyer_confidence: u64,
        buyer_level: u8,
        created_at_ms: u64,
        updated_at_ms: u64,
    }

    struct ReputationFeeConfigInitialized has copy, drop {
        config_id: address,
        actor: address,
        reference_exec_gas: u64,
        init_multiplier_bps: u64,
        init_min_sui: u64,
        init_max_sui: u64,
        treasury_sink: address,
        timelock_ms: u64,
    }

    struct ReputationFeePolicyUpdateQueued has copy, drop {
        config_id: address,
        actor: address,
        effective_at_ms: u64,
    }

    struct ReputationFeePolicyUpdateApproved has copy, drop {
        config_id: address,
        actor: address,
    }

    struct ReputationFeePolicyUpdateCanceled has copy, drop {
        config_id: address,
        actor: address,
        pending_effective_at_ms: u64,
    }

    struct ReputationFeeConfigUpdated has copy, drop {
        config_id: address,
        actor: address,
        applied_at_ms: u64,
    }

    struct ReputationProfileCreated has copy, drop {
        profile_object_id: address,
        owner: address,
        init_fee_paid: u64,
        treasury_sink: address,
        created_at_ms: u64,
    }

    struct ParticipantReputationUpdated has copy, drop {
        owner: address,
        seller_score: u64,
        seller_confidence: u64,
        seller_level: u8,
        buyer_score: u64,
        buyer_confidence: u64,
        buyer_level: u8,
        updated_at_ms: u64,
    }

    public fun apply_reputation_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ReputationFeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        assert!(arg2.pending_treasury_approved, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_fee_update_not_approved());
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(v0 >= arg2.pending_effective_at_ms, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_fee_timelock_not_elapsed());
        arg2.reference_exec_gas = arg2.pending_reference_exec_gas;
        arg2.init_multiplier_bps = arg2.pending_init_multiplier_bps;
        arg2.init_min_sui = arg2.pending_init_min_sui;
        arg2.init_max_sui = arg2.pending_init_max_sui;
        arg2.treasury_sink = arg2.pending_treasury_sink;
        arg2.pending_reference_exec_gas = 0;
        arg2.pending_init_multiplier_bps = 0;
        arg2.pending_init_min_sui = 0;
        arg2.pending_init_max_sui = 0;
        arg2.pending_treasury_sink = @0x0;
        arg2.pending_effective_at_ms = 0;
        arg2.has_pending_update = false;
        arg2.pending_treasury_approved = false;
        arg2.updated_at_ms = v0;
        let v1 = 0x2::object::id<ReputationFeeConfig>(arg2);
        let v2 = ReputationFeeConfigUpdated{
            config_id     : 0x2::object::id_to_address(&v1),
            actor         : 0x2::tx_context::sender(arg4),
            applied_at_ms : v0,
        };
        0x2::event::emit<ReputationFeeConfigUpdated>(v2);
    }

    public fun approve_pending_reputation_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::TreasuryCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ReputationFeeConfig, arg3: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert!(arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        arg2.pending_treasury_approved = true;
        let v0 = 0x2::object::id<ReputationFeeConfig>(arg2);
        let v1 = ReputationFeePolicyUpdateApproved{
            config_id : 0x2::object::id_to_address(&v0),
            actor     : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ReputationFeePolicyUpdateApproved>(v1);
    }

    fun assert_valid_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: address) {
        assert!(arg0 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(arg1 > 0 && arg1 <= 10000, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(arg2 > 0 && arg2 <= arg3, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        assert!(arg4 != @0x0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
    }

    public(friend) fun best_threshold_summary_for_owner(arg0: &ReputationFeeConfig, arg1: address) : (u8, u64, u64) {
        let (v0, v1, v2, v3) = participant_best_threshold_summary_for_view(arg0, arg1);
        assert!(v0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        (v1, v2, v3)
    }

    public fun buyer_auto_release_misses(arg0: &ReputationProfile) : u64 {
        arg0.buyer_auto_release_misses
    }

    public fun buyer_completed_orders(arg0: &ReputationProfile) : u64 {
        arg0.buyer_completed_orders
    }

    public fun buyer_confidence(arg0: &ReputationProfile) : u64 {
        arg0.buyer_confidence
    }

    public fun buyer_disputed_orders(arg0: &ReputationProfile) : u64 {
        arg0.buyer_disputed_orders
    }

    public fun buyer_level(arg0: &ReputationProfile) : u8 {
        arg0.buyer_level
    }

    public fun buyer_manual_review_actions(arg0: &ReputationProfile) : u64 {
        arg0.buyer_manual_review_actions
    }

    public fun buyer_score(arg0: &ReputationProfile) : u64 {
        arg0.buyer_score
    }

    public fun cancel_pending_reputation_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &mut ReputationFeeConfig, arg2: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_no_pending_fee_update());
        arg1.pending_reference_exec_gas = 0;
        arg1.pending_init_multiplier_bps = 0;
        arg1.pending_init_min_sui = 0;
        arg1.pending_init_max_sui = 0;
        arg1.pending_treasury_sink = @0x0;
        arg1.pending_effective_at_ms = 0;
        arg1.has_pending_update = false;
        arg1.pending_treasury_approved = false;
        let v0 = 0x2::object::id<ReputationFeeConfig>(arg1);
        let v1 = ReputationFeePolicyUpdateCanceled{
            config_id               : 0x2::object::id_to_address(&v0),
            actor                   : 0x2::tx_context::sender(arg2),
            pending_effective_at_ms : arg1.pending_effective_at_ms,
        };
        0x2::event::emit<ReputationFeePolicyUpdateCanceled>(v1);
    }

    fun clamp_bps(arg0: u64) : u64 {
        if (arg0 > 10000) {
            10000
        } else {
            arg0
        }
    }

    fun compute_buyer_summary_fields(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : (u64, u64, u8) {
        let v0 = arg0 + arg1;
        let v1 = arg2 + arg3;
        let v2 = v0 + v1;
        if (v0 == 0 && v2 == 0) {
            return (50, 0, 0)
        };
        let v3 = 50 + (ratio_bps(arg0, v0, 5000) as u128) * 18 / (10000 as u128) + ((10000 - ratio_bps(arg1, v0, 0)) as u128) * 14 / (10000 as u128) + (ratio_bps(arg2, v1, 5000) as u128) * 18 / (10000 as u128) + (volume_factor_bps(v2) as u128) * 10 / (10000 as u128);
        let v4 = ((arg3 as u128) * 20 + (arg1 as u128) * 5) / 10;
        let v5 = if (v3 > v4) {
            v3 - v4
        } else {
            0
        };
        let v6 = if (v5 > 100) {
            100
        } else {
            (v5 as u64)
        };
        let v7 = compute_confidence(v0, v2);
        (v6, v7, infer_level(v6, v7, v2))
    }

    fun compute_confidence(arg0: u64, arg1: u64) : u64 {
        let v0 = (arg1 as u128) * 3 + (arg0 as u128) * 2;
        if (v0 > 100) {
            100
        } else {
            (v0 as u64)
        }
    }

    fun compute_init_fee(arg0: u64, arg1: u64, arg2: u64, arg3: u64) : u64 {
        let v0 = (arg0 as u128) * (arg1 as u128) / (10000 as u128);
        if (v0 < (arg2 as u128)) {
            arg2
        } else if (v0 > (arg3 as u128)) {
            arg3
        } else {
            (v0 as u64)
        }
    }

    public fun compute_init_fee_sui(arg0: &ReputationFeeConfig) : u64 {
        compute_init_fee(arg0.reference_exec_gas, arg0.init_multiplier_bps, arg0.init_min_sui, arg0.init_max_sui)
    }

    fun compute_seller_summary_fields(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) : (u64, u64, u8) {
        let v0 = arg0 + arg1;
        let v1 = v0 + arg2 + arg3 + arg4 + arg5;
        if (v0 == 0 && v1 == 0) {
            return (50, 0, 0)
        };
        let v2 = 50 + (ratio_bps(arg0, v0, 5000) as u128) * 22 / (10000 as u128) + ((10000 - ratio_bps(arg1, v0, 0)) as u128) * 16 / (10000 as u128) + (volume_factor_bps(v1) as u128) * 12 / (10000 as u128);
        let v3 = ((arg3 as u128) * 12 + (arg4 as u128) * 20 + (arg5 as u128) * 25) / 10;
        let v4 = if (v2 > v3) {
            v2 - v3
        } else {
            0
        };
        let v5 = if (v4 > 100) {
            100
        } else {
            (v4 as u64)
        };
        let v6 = compute_confidence(v0, v1);
        (v5, v6, infer_level(v5, v6, v1))
    }

    fun create_reputation_profile_sui(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut ReputationFeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : ReputationProfile {
        assert!(0x2::tx_context::sender(arg4) == arg0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_not_authorized());
        let v0 = ProfileOwnerKey{owner: arg0};
        assert!(!0x2::dynamic_field::exists_<ProfileOwnerKey>(&arg2.id, v0), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v1 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(v1 == compute_init_fee_sui(arg2), 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_amount());
        let v2 = 0x2::clock::timestamp_ms(arg3);
        let v3 = neutral_profile(arg0, v1, v2, arg4);
        let v4 = 0x2::object::id<ReputationProfile>(&v3);
        let v5 = 0x2::object::id_to_address(&v4);
        let v6 = ProfileOwnerKey{owner: arg0};
        0x2::dynamic_field::add<ProfileOwnerKey, address>(&mut arg2.id, v6, v5);
        arg2.profile_count = arg2.profile_count + 1;
        ensure_participant_state(arg2, arg0, arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg1, arg2.treasury_sink);
        let v7 = ReputationProfileCreated{
            profile_object_id : v5,
            owner             : arg0,
            init_fee_paid     : v1,
            treasury_sink     : arg2.treasury_sink,
            created_at_ms     : v2,
        };
        0x2::event::emit<ReputationProfileCreated>(v7);
        v3
    }

    public fun create_reputation_profile_sui_entry(arg0: address, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &mut ReputationFeeConfig, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::transfer::transfer<ReputationProfile>(create_reputation_profile_sui(arg0, arg1, arg2, arg3, arg4), arg0);
    }

    public fun created_at_ms(arg0: &ReputationProfile) : u64 {
        arg0.created_at_ms
    }

    fun ensure_participant_state(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) : &mut ParticipantReputationState {
        let v0 = ParticipantReputationKey{owner: arg1};
        if (!0x2::dynamic_field::exists_<ParticipantReputationKey>(&arg0.id, v0)) {
            0x2::dynamic_field::add<ParticipantReputationKey, ParticipantReputationState>(&mut arg0.id, v0, neutral_participant_state(arg1, 0x2::clock::timestamp_ms(arg2)));
        };
        0x2::dynamic_field::borrow_mut<ParticipantReputationKey, ParticipantReputationState>(&mut arg0.id, v0)
    }

    public fun has_participant_state(arg0: &ReputationFeeConfig, arg1: address) : bool {
        let v0 = ParticipantReputationKey{owner: arg1};
        0x2::dynamic_field::exists_<ParticipantReputationKey>(&arg0.id, v0)
    }

    public fun has_pending_update(arg0: &ReputationFeeConfig) : bool {
        arg0.has_pending_update
    }

    public fun has_profile(arg0: &ReputationFeeConfig, arg1: address) : bool {
        let v0 = ProfileOwnerKey{owner: arg1};
        0x2::dynamic_field::exists_<ProfileOwnerKey>(&arg0.id, v0)
    }

    fun infer_level(arg0: u64, arg1: u64, arg2: u64) : u8 {
        if (arg2 < 2 || arg1 < 20) {
            0
        } else if (arg0 >= 85 && arg1 >= 70) {
            4
        } else if (arg0 >= 75 && arg1 >= 55) {
            3
        } else if (arg0 >= 65 && arg1 >= 40) {
            2
        } else if (arg0 >= 55 && arg1 >= 25) {
            1
        } else {
            0
        }
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = new_config(1000000, 3000, 1000000, 1000000000, @0xa0d4c9a9f935dac9f9bee55ca0632c187077a04d0dffcc479402f2de9a82140, 86400000, 0, arg0);
        let v2 = 0x2::object::id<ReputationFeeConfig>(&v1);
        let v3 = ReputationFeeConfigInitialized{
            config_id           : 0x2::object::id_to_address(&v2),
            actor               : v0,
            reference_exec_gas  : v1.reference_exec_gas,
            init_multiplier_bps : v1.init_multiplier_bps,
            init_min_sui        : v1.init_min_sui,
            init_max_sui        : v1.init_max_sui,
            treasury_sink       : v1.treasury_sink,
            timelock_ms         : v1.timelock_ms,
        };
        0x2::event::emit<ReputationFeeConfigInitialized>(v3);
        0x2::transfer::share_object<ReputationFeeConfig>(v1);
    }

    public fun init_fee_paid(arg0: &ReputationProfile) : u64 {
        arg0.init_fee_paid
    }

    public fun init_max_sui(arg0: &ReputationFeeConfig) : u64 {
        arg0.init_max_sui
    }

    public fun init_min_sui(arg0: &ReputationFeeConfig) : u64 {
        arg0.init_min_sui
    }

    public fun init_multiplier_bps(arg0: &ReputationFeeConfig) : u64 {
        arg0.init_multiplier_bps
    }

    fun mark_participant_state_updated(arg0: &mut ParticipantReputationState, arg1: &0x2::clock::Clock) {
        refresh_participant_state_summary(arg0);
        arg0.updated_at_ms = 0x2::clock::timestamp_ms(arg1);
        let v0 = ParticipantReputationUpdated{
            owner             : arg0.owner,
            seller_score      : arg0.seller_score,
            seller_confidence : arg0.seller_confidence,
            seller_level      : arg0.seller_level,
            buyer_score       : arg0.buyer_score,
            buyer_confidence  : arg0.buyer_confidence,
            buyer_level       : arg0.buyer_level,
            updated_at_ms     : arg0.updated_at_ms,
        };
        0x2::event::emit<ParticipantReputationUpdated>(v0);
    }

    fun neutral_participant_state(arg0: address, arg1: u64) : ParticipantReputationState {
        ParticipantReputationState{
            owner                       : arg0,
            seller_completed_orders     : 0,
            seller_disputed_orders      : 0,
            seller_settled_milestones   : 0,
            seller_rejected_milestones  : 0,
            seller_refunded_milestones  : 0,
            seller_deadline_misses      : 0,
            buyer_completed_orders      : 0,
            buyer_disputed_orders       : 0,
            buyer_manual_review_actions : 0,
            buyer_auto_release_misses   : 0,
            seller_score                : 50,
            seller_confidence           : 0,
            seller_level                : 0,
            buyer_score                 : 50,
            buyer_confidence            : 0,
            buyer_level                 : 0,
            created_at_ms               : arg1,
            updated_at_ms               : arg1,
        }
    }

    fun neutral_profile(arg0: address, arg1: u64, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) : ReputationProfile {
        ReputationProfile{
            id                          : 0x2::object::new(arg3),
            owner                       : arg0,
            init_fee_paid               : arg1,
            seller_completed_orders     : 0,
            seller_disputed_orders      : 0,
            seller_settled_milestones   : 0,
            seller_rejected_milestones  : 0,
            seller_refunded_milestones  : 0,
            seller_deadline_misses      : 0,
            buyer_completed_orders      : 0,
            buyer_disputed_orders       : 0,
            buyer_manual_review_actions : 0,
            buyer_auto_release_misses   : 0,
            seller_score                : 50,
            seller_confidence           : 0,
            seller_level                : 0,
            buyer_score                 : 50,
            buyer_confidence            : 0,
            buyer_level                 : 0,
            created_at_ms               : arg2,
            updated_at_ms               : arg2,
        }
    }

    fun new_config(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: address, arg5: u64, arg6: u64, arg7: &mut 0x2::tx_context::TxContext) : ReputationFeeConfig {
        assert_valid_config(arg0, arg1, arg2, arg3, arg4);
        assert!(arg5 > 0, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_fee_config());
        ReputationFeeConfig{
            id                          : 0x2::object::new(arg7),
            profile_count               : 0,
            reference_exec_gas          : arg0,
            init_multiplier_bps         : arg1,
            init_min_sui                : arg2,
            init_max_sui                : arg3,
            treasury_sink               : arg4,
            pending_reference_exec_gas  : 0,
            pending_init_multiplier_bps : 0,
            pending_init_min_sui        : 0,
            pending_init_max_sui        : 0,
            pending_treasury_sink       : @0x0,
            pending_effective_at_ms     : 0,
            has_pending_update          : false,
            pending_treasury_approved   : false,
            timelock_ms                 : arg5,
            updated_at_ms               : arg6,
        }
    }

    public fun owner(arg0: &ReputationProfile) : address {
        arg0.owner
    }

    public fun participant_best_threshold_summary_for_view(arg0: &ReputationFeeConfig, arg1: address) : (bool, u8, u64, u64) {
        let v0 = ParticipantReputationKey{owner: arg1};
        if (!0x2::dynamic_field::exists_<ParticipantReputationKey>(&arg0.id, v0)) {
            return (false, 0, 0, 0)
        };
        let v1 = 0x2::dynamic_field::borrow<ParticipantReputationKey, ParticipantReputationState>(&arg0.id, v0);
        let v2 = if (v1.seller_level > v1.buyer_level) {
            v1.seller_level
        } else {
            v1.buyer_level
        };
        let v3 = if (v1.seller_score > v1.buyer_score) {
            v1.seller_score
        } else {
            v1.buyer_score
        };
        let v4 = if (v1.seller_confidence > v1.buyer_confidence) {
            v1.seller_confidence
        } else {
            v1.buyer_confidence
        };
        (true, v2, v3, v4)
    }

    public fun pending_effective_at_ms(arg0: &ReputationFeeConfig) : u64 {
        arg0.pending_effective_at_ms
    }

    public fun pending_init_max_sui(arg0: &ReputationFeeConfig) : u64 {
        arg0.pending_init_max_sui
    }

    public fun pending_init_min_sui(arg0: &ReputationFeeConfig) : u64 {
        arg0.pending_init_min_sui
    }

    public fun pending_init_multiplier_bps(arg0: &ReputationFeeConfig) : u64 {
        arg0.pending_init_multiplier_bps
    }

    public fun pending_reference_exec_gas(arg0: &ReputationFeeConfig) : u64 {
        arg0.pending_reference_exec_gas
    }

    public fun pending_treasury_approved(arg0: &ReputationFeeConfig) : bool {
        arg0.pending_treasury_approved
    }

    public fun pending_treasury_sink(arg0: &ReputationFeeConfig) : address {
        arg0.pending_treasury_sink
    }

    public fun profile_count(arg0: &ReputationFeeConfig) : u64 {
        arg0.profile_count
    }

    public fun profile_object_id(arg0: &ReputationFeeConfig, arg1: address) : address {
        let v0 = ProfileOwnerKey{owner: arg1};
        *0x2::dynamic_field::borrow<ProfileOwnerKey, address>(&arg0.id, v0)
    }

    public fun queue_reputation_fee_policy_update(arg0: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::AdminCap, arg1: &0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::GovernanceConfig, arg2: &mut ReputationFeeConfig, arg3: u64, arg4: u64, arg5: u64, arg6: u64, arg7: address, arg8: &0x2::clock::Clock, arg9: &mut 0x2::tx_context::TxContext) {
        0xd52919383c5190f43b20e313fb8272da5005346e15bae6843f624015ec3b4ae1::admin::assert_incident_not_frozen(arg1);
        assert_valid_config(arg3, arg4, arg5, arg6, arg7);
        assert!(!arg2.has_pending_update, 0x11f7f1215c1df42e0b340ac1ba253186ab83454d179f8551b7a64f8fadc01eb6::errors::e_invalid_state());
        let v0 = 0x2::clock::timestamp_ms(arg8) + arg2.timelock_ms;
        arg2.pending_reference_exec_gas = arg3;
        arg2.pending_init_multiplier_bps = arg4;
        arg2.pending_init_min_sui = arg5;
        arg2.pending_init_max_sui = arg6;
        arg2.pending_treasury_sink = arg7;
        arg2.pending_effective_at_ms = v0;
        arg2.has_pending_update = true;
        arg2.pending_treasury_approved = false;
        let v1 = 0x2::object::id<ReputationFeeConfig>(arg2);
        let v2 = ReputationFeePolicyUpdateQueued{
            config_id       : 0x2::object::id_to_address(&v1),
            actor           : 0x2::tx_context::sender(arg9),
            effective_at_ms : v0,
        };
        0x2::event::emit<ReputationFeePolicyUpdateQueued>(v2);
    }

    fun ratio_bps(arg0: u64, arg1: u64, arg2: u64) : u64 {
        if (arg1 == 0) {
            clamp_bps(arg2)
        } else {
            let v1 = (arg0 as u128) * (10000 as u128) / (arg1 as u128);
            if (v1 > (10000 as u128)) {
                10000
            } else {
                (v1 as u64)
            }
        }
    }

    public(friend) fun record_buyer_auto_release_miss_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.buyer_auto_release_misses = v0.buyer_auto_release_misses + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_buyer_completed_order_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.buyer_completed_orders = v0.buyer_completed_orders + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_buyer_disputed_order_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.buyer_disputed_orders = v0.buyer_disputed_orders + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_buyer_manual_review_action_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.buyer_manual_review_actions = v0.buyer_manual_review_actions + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_seller_completed_order_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.seller_completed_orders = v0.seller_completed_orders + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_seller_deadline_miss_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.seller_deadline_misses = v0.seller_deadline_misses + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_seller_disputed_order_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.seller_disputed_orders = v0.seller_disputed_orders + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_seller_milestone_refunded_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.seller_refunded_milestones = v0.seller_refunded_milestones + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_seller_milestone_rejected_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.seller_rejected_milestones = v0.seller_rejected_milestones + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public(friend) fun record_seller_milestone_settled_for(arg0: &mut ReputationFeeConfig, arg1: address, arg2: &0x2::clock::Clock) {
        let v0 = ensure_participant_state(arg0, arg1, arg2);
        v0.seller_settled_milestones = v0.seller_settled_milestones + 1;
        mark_participant_state_updated(v0, arg2);
    }

    public fun reference_exec_gas(arg0: &ReputationFeeConfig) : u64 {
        arg0.reference_exec_gas
    }

    fun refresh_participant_state_summary(arg0: &mut ParticipantReputationState) {
        let (v0, v1, v2) = compute_seller_summary_fields(arg0.seller_completed_orders, arg0.seller_disputed_orders, arg0.seller_settled_milestones, arg0.seller_rejected_milestones, arg0.seller_refunded_milestones, arg0.seller_deadline_misses);
        let (v3, v4, v5) = compute_buyer_summary_fields(arg0.buyer_completed_orders, arg0.buyer_disputed_orders, arg0.buyer_manual_review_actions, arg0.buyer_auto_release_misses);
        arg0.seller_score = v0;
        arg0.seller_confidence = v1;
        arg0.seller_level = v2;
        arg0.buyer_score = v3;
        arg0.buyer_confidence = v4;
        arg0.buyer_level = v5;
    }

    public fun seller_completed_orders(arg0: &ReputationProfile) : u64 {
        arg0.seller_completed_orders
    }

    public fun seller_confidence(arg0: &ReputationProfile) : u64 {
        arg0.seller_confidence
    }

    public fun seller_deadline_misses(arg0: &ReputationProfile) : u64 {
        arg0.seller_deadline_misses
    }

    public fun seller_disputed_orders(arg0: &ReputationProfile) : u64 {
        arg0.seller_disputed_orders
    }

    public fun seller_level(arg0: &ReputationProfile) : u8 {
        arg0.seller_level
    }

    public fun seller_refunded_milestones(arg0: &ReputationProfile) : u64 {
        arg0.seller_refunded_milestones
    }

    public fun seller_rejected_milestones(arg0: &ReputationProfile) : u64 {
        arg0.seller_rejected_milestones
    }

    public fun seller_score(arg0: &ReputationProfile) : u64 {
        arg0.seller_score
    }

    public fun seller_settled_milestones(arg0: &ReputationProfile) : u64 {
        arg0.seller_settled_milestones
    }

    public fun timelock_ms(arg0: &ReputationFeeConfig) : u64 {
        arg0.timelock_ms
    }

    public fun treasury_sink(arg0: &ReputationFeeConfig) : address {
        arg0.treasury_sink
    }

    public fun updated_at_ms(arg0: &ReputationProfile) : u64 {
        arg0.updated_at_ms
    }

    fun volume_factor_bps(arg0: u64) : u64 {
        let v0 = (arg0 as u128) * (10000 as u128) / (25 as u128);
        if (v0 > (10000 as u128)) {
            10000
        } else {
            (v0 as u64)
        }
    }

    // decompiled from Move bytecode v7
}

