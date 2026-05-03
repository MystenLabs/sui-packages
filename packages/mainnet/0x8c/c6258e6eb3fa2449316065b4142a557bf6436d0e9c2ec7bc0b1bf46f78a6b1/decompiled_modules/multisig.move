module 0x8cc6258e6eb3fa2449316065b4142a557bf6436d0e9c2ec7bc0b1bf46f78a6b1::multisig {
    struct ConfigWitness has drop {
        dummy_field: bool,
    }

    struct ProposedConfigKey has copy, drop, store {
        intent_key: 0x1::string::String,
    }

    struct MultisigAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct MultisigFeeVault has key {
        id: 0x2::object::UID,
        balance: 0x2::balance::Balance<0x2::sui::SUI>,
        creation_fee: u64,
        fee_recipient: address,
    }

    struct TimeBand has copy, drop, store {
        after_ms: u64,
        weight: u64,
    }

    struct GroupMember has copy, drop, store {
        addr: address,
        weight: u64,
    }

    struct Group has copy, drop, store {
        name: 0x1::string::String,
        members: vector<GroupMember>,
        time_bands: vector<TimeBand>,
    }

    struct PathRequirement has copy, drop, store {
        group_idx: u64,
        threshold: u64,
    }

    struct PolicyPath has copy, drop, store {
        requirements: vector<PathRequirement>,
    }

    struct RolePolicy has copy, drop, store {
        paths: vector<PolicyPath>,
    }

    struct MultisigConfig has copy, drop, store {
        groups: vector<Group>,
        approve_policy: RolePolicy,
        cancel_policy: RolePolicy,
        propose_groups: vector<u64>,
        execute_groups: vector<u64>,
        cancel_groups: vector<u64>,
        intent_expiry_ms: u64,
        config_nonce: u64,
    }

    struct Approvals has copy, drop, store {
        config_nonce: u64,
        status: u8,
        approved: 0x2::vec_set::VecSet<address>,
        rejected: 0x2::vec_set::VecSet<address>,
        matched_vote_path: 0x1::option::Option<u64>,
        approved_at_ms: u64,
    }

    struct AccountCreatedEvent has copy, drop {
        account_addr: address,
        creator: address,
    }

    struct ConfigChangedEvent has copy, drop {
        account_addr: address,
        group_names: vector<0x1::string::String>,
        group_member_counts: vector<u64>,
        all_member_addresses: vector<address>,
        all_member_weights: vector<u64>,
        time_band_counts: vector<u64>,
        all_time_band_afters: vector<u64>,
        all_time_band_weights: vector<u64>,
        approve_path_req_counts: vector<u64>,
        all_approve_group_indices: vector<u64>,
        all_approve_thresholds: vector<u64>,
        cancel_path_req_counts: vector<u64>,
        all_cancel_group_indices: vector<u64>,
        all_cancel_thresholds: vector<u64>,
        propose_groups: vector<u64>,
        execute_groups: vector<u64>,
        cancel_groups: vector<u64>,
        intent_expiry_ms: u64,
        config_nonce: u64,
    }

    struct IntentCreatedEvent has copy, drop {
        account_addr: address,
        key: 0x1::string::String,
        description: 0x1::string::String,
        creator: address,
    }

    struct IntentExecutedEvent has copy, drop {
        account_addr: address,
        key: 0x1::string::String,
        executor: address,
    }

    struct IntentCancelledEvent has copy, drop {
        account_addr: address,
        key: 0x1::string::String,
        canceller: address,
        reason: u8,
    }

    fun active_time_band_weight(arg0: &Group, arg1: u64, arg2: bool) : u64 {
        let v0 = 0;
        if (arg2) {
            let v1 = &arg0.time_bands;
            let v2 = 0;
            while (v2 < 0x1::vector::length<TimeBand>(v1)) {
                let v3 = 0x1::vector::borrow<TimeBand>(v1, v2);
                if (arg1 >= v3.after_ms) {
                    v0 = v3.weight;
                };
                v2 = v2 + 1;
            };
        };
        v0
    }

    public fun approve_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = *0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        assert!(is_member_of_any_group(&v0, 0x2::tx_context::sender(arg3)), 0);
        let v1 = ConfigWitness{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get_mut<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v1), arg1);
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome_mut<Approvals>(v2);
        assert!(v3.config_nonce == v0.config_nonce, 7);
        assert!(v3.status == 0, 6);
        let v4 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_set::contains<address>(&v3.rejected, &v4)) {
            let v5 = 0x2::tx_context::sender(arg3);
            0x2::vec_set::remove<address>(&mut v3.rejected, &v5);
        };
        let v6 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_set::contains<address>(&v3.approved, &v6), 3);
        0x2::vec_set::insert<address>(&mut v3.approved, 0x2::tx_context::sender(arg3));
        let v7 = find_satisfied_vote_path(&v0, &v3.approved, 0x2::clock::timestamp_ms(arg2) - 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::creation_time<Approvals>(v2));
        if (0x1::option::is_some<u64>(&v7)) {
            v3.status = 1;
            v3.matched_vote_path = v7;
            v3.approved_at_ms = 0x2::clock::timestamp_ms(arg2);
        };
    }

    public fun approve_policy(arg0: &MultisigConfig) : &RolePolicy {
        &arg0.approve_policy
    }

    public fun approved(arg0: &Approvals) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.approved)
    }

    public fun approved_at_ms(arg0: &Approvals) : u64 {
        arg0.approved_at_ms
    }

    fun assert_fresh_pending_outcome(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &Approvals) {
        assert!(arg1.config_nonce == 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0).config_nonce, 7);
        assert!(arg1.status == 0, 6);
        assert!(0x1::vector::is_empty<address>(0x2::vec_set::keys<address>(&arg1.approved)), 6);
        assert!(0x1::vector::is_empty<address>(0x2::vec_set::keys<address>(&arg1.rejected)), 6);
        assert!(0x1::option::is_none<u64>(&arg1.matched_vote_path), 6);
        assert!(arg1.approved_at_ms == 0, 6);
    }

    fun assert_intent_matches_config_policy(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Intent<Approvals>) {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::execution_times<Approvals>(arg1);
        assert!(0x1::vector::length<u64>(&v1) == 1, 13);
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::expiration_time<Approvals>(arg1);
        assert!(v2 > 0, 14);
        assert!(v2 == 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::creation_time<Approvals>(arg1) + v0.intent_expiry_ms, 14);
        assert!(*0x1::vector::borrow<u64>(&v1, 0) < v2, 14);
    }

    fun assert_not_config_change_intent(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String) {
        assert!(!intent_has_config_change_action(arg0, arg1), 10);
    }

    fun assert_sender_can_cancel(arg0: &MultisigConfig, arg1: address) {
        assert!(is_member_of_any_group(arg0, arg1), 0);
        assert!(is_in_cancel_groups(arg0, arg1), 34);
    }

    public(friend) fun assert_sender_can_propose(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: address) {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        assert!(is_member_of_any_group(v0, arg1), 0);
        assert!(is_in_propose_groups(v0, arg1), 1);
    }

    fun assert_valid_config_change_intent<T0: drop>(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Intent<Approvals>) {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<Approvals>(arg0);
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v0)) {
            if (is_config_change_action_spec(0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v0, v2))) {
                v1 = v1 + 1;
            };
            v2 = v2 + 1;
        };
        let v3 = is_config_change_intent_witness<T0>();
        let v4 = if (v1 == 0 && !v3) {
            true
        } else if (v1 == 1) {
            if (0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v0) == 1) {
                v3
            } else {
                false
            }
        } else {
            false
        };
        assert!(v4, 16);
    }

    fun assert_valid_intent_expiry_ms(arg0: u64) {
        assert!(arg0 > 0, 15);
    }

    fun assert_valid_intent_policy(arg0: u64) {
        assert_valid_intent_expiry_ms(arg0);
    }

    public fun authenticate(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Auth {
        assert_sender_can_propose(arg0, 0x2::tx_context::sender(arg1));
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::new_auth<MultisigConfig, ConfigWitness>(arg0, v0)
    }

    public(friend) fun build_config_from_flat_vectors(arg0: vector<0x1::string::String>, arg1: vector<u64>, arg2: vector<address>, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: vector<u64>, arg7: vector<u64>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: vector<u64>, arg16: u64) : MultisigConfig {
        let v0 = 0x1::vector::length<0x1::string::String>(&arg0);
        assert!(v0 > 0, 21);
        assert!(v0 <= 20, 21);
        assert!(0x1::vector::length<u64>(&arg1) == v0, 39);
        assert!(0x1::vector::length<u64>(&arg4) == v0, 40);
        assert!(0x1::vector::length<address>(&arg2) == 0x1::vector::length<u64>(&arg3), 39);
        assert!(0x1::vector::length<address>(&arg2) <= 200, 32);
        assert!(0x1::vector::length<u64>(&arg5) == 0x1::vector::length<u64>(&arg6), 40);
        assert!(0x1::vector::length<u64>(&arg5) <= 20 * 10, 26);
        assert!(0x1::vector::length<u64>(&arg8) == 0x1::vector::length<u64>(&arg9), 41);
        assert!(0x1::vector::length<u64>(&arg11) == 0x1::vector::length<u64>(&arg12), 41);
        let v1 = 0x1::vector::empty<Group>();
        let v2 = 0;
        let v3 = 0;
        let v4 = 0;
        while (v4 < v0) {
            let v5 = *0x1::vector::borrow<u64>(&arg1, v4);
            assert!(v5 <= 200, 32);
            assert!(v2 + v5 <= 0x1::vector::length<address>(&arg2), 39);
            let v6 = 0x1::vector::empty<GroupMember>();
            let v7 = 0;
            while (v7 < v5) {
                let v8 = GroupMember{
                    addr   : *0x1::vector::borrow<address>(&arg2, v2 + v7),
                    weight : *0x1::vector::borrow<u64>(&arg3, v2 + v7),
                };
                0x1::vector::push_back<GroupMember>(&mut v6, v8);
                v7 = v7 + 1;
            };
            v2 = v2 + v5;
            let v9 = *0x1::vector::borrow<u64>(&arg4, v4);
            assert!(v9 <= 10, 26);
            assert!(v3 + v9 <= 0x1::vector::length<u64>(&arg5), 40);
            let v10 = 0x1::vector::empty<TimeBand>();
            let v11 = 0;
            while (v11 < v9) {
                let v12 = TimeBand{
                    after_ms : *0x1::vector::borrow<u64>(&arg5, v3 + v11),
                    weight   : *0x1::vector::borrow<u64>(&arg6, v3 + v11),
                };
                0x1::vector::push_back<TimeBand>(&mut v10, v12);
                v11 = v11 + 1;
            };
            v3 = v3 + v9;
            let v13 = Group{
                name       : *0x1::vector::borrow<0x1::string::String>(&arg0, v4),
                members    : v6,
                time_bands : v10,
            };
            0x1::vector::push_back<Group>(&mut v1, v13);
            v4 = v4 + 1;
        };
        assert!(v2 == 0x1::vector::length<address>(&arg2), 39);
        assert!(v3 == 0x1::vector::length<u64>(&arg5), 40);
        new_config(v1, build_role_policy_from_flat(arg7, arg8, arg9), build_role_policy_from_flat(arg10, arg11, arg12), arg13, arg14, arg15, arg16)
    }

    fun build_role_policy_from_flat(arg0: vector<u64>, arg1: vector<u64>, arg2: vector<u64>) : RolePolicy {
        assert!(0x1::vector::length<u64>(&arg0) <= 20, 22);
        assert!(0x1::vector::length<u64>(&arg1) <= 20 * 20, 45);
        let v0 = 0x1::vector::empty<PolicyPath>();
        let v1 = 0;
        let v2 = 0;
        while (v2 < 0x1::vector::length<u64>(&arg0)) {
            let v3 = *0x1::vector::borrow<u64>(&arg0, v2);
            assert!(v3 > 0, 36);
            assert!(v3 <= 20, 45);
            assert!(v1 + v3 <= 0x1::vector::length<u64>(&arg1), 41);
            let v4 = 0x1::vector::empty<PathRequirement>();
            let v5 = 0;
            while (v5 < v3) {
                assert!(*0x1::vector::borrow<u64>(&arg2, v1 + v5) > 0, 37);
                let v6 = PathRequirement{
                    group_idx : *0x1::vector::borrow<u64>(&arg1, v1 + v5),
                    threshold : *0x1::vector::borrow<u64>(&arg2, v1 + v5),
                };
                0x1::vector::push_back<PathRequirement>(&mut v4, v6);
                v5 = v5 + 1;
            };
            v1 = v1 + v3;
            let v7 = PolicyPath{requirements: v4};
            0x1::vector::push_back<PolicyPath>(&mut v0, v7);
            v2 = v2 + 1;
        };
        assert!(v1 == 0x1::vector::length<u64>(&arg1), 41);
        RolePolicy{paths: v0}
    }

    fun can_any_approve_path_be_satisfied(arg0: &MultisigConfig, arg1: &0x2::vec_set::VecSet<address>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PolicyPath>(&arg0.approve_policy.paths)) {
            if (path_can_be_satisfied(arg0, 0x1::vector::borrow<PolicyPath>(&arg0.approve_policy.paths, v0), arg1, true)) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    public fun cancel_expired_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        assert_not_config_change_intent(arg0, arg1);
        cancel_expired_intent_inner(arg0, arg1, arg2, arg3)
    }

    public(friend) fun cancel_expired_intent_for_cleanup(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        cancel_expired_intent_inner(arg0, arg1, arg2, arg3)
    }

    fun cancel_expired_intent_inner(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        emit_intent_cancelled(arg0, arg1, 0x2::tx_context::sender(arg3), 3);
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::delete_expired_intent<Approvals, ConfigWitness>(arg0, arg1, arg2, v0, arg3)
    }

    public fun cancel_groups(arg0: &MultisigConfig) : &vector<u64> {
        &arg0.cancel_groups
    }

    public fun cancel_pending_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        assert_not_config_change_intent(arg0, arg1);
        cancel_pending_intent_inner(arg0, arg1, arg2, arg3)
    }

    public(friend) fun cancel_pending_intent_for_cleanup(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        cancel_pending_intent_inner(arg0, arg1, arg2, arg3)
    }

    fun cancel_pending_intent_inner(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        let v0 = *0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        assert_sender_can_cancel(&v0, 0x2::tx_context::sender(arg3));
        let v1 = ConfigWitness{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get_mut<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v1), arg1);
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome_mut<Approvals>(v2);
        let v4 = if (v3.status == 0) {
            true
        } else if (v3.status == 1) {
            true
        } else {
            v3.status == 2
        };
        assert!(v4, 6);
        let v5 = find_satisfied_reject_path(&v0, &v3.rejected, 0x2::clock::timestamp_ms(arg2) - 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::creation_time<Approvals>(v2));
        assert!(v3.status == 2 || 0x1::option::is_some<u64>(&v5), 6);
        emit_intent_cancelled(arg0, arg1, 0x2::tx_context::sender(arg3), 0);
        let v6 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::cancel_intent<Approvals, ConfigWitness>(arg0, arg1, v6, arg3)
    }

    public fun cancel_policy(arg0: &MultisigConfig) : &RolePolicy {
        &arg0.cancel_policy
    }

    public fun cancel_reason_expired() : u8 {
        3
    }

    public fun cancel_reason_pending() : u8 {
        0
    }

    public fun cancel_reason_rejected() : u8 {
        2
    }

    public fun cancel_reason_stale() : u8 {
        1
    }

    public fun cancel_rejected_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        assert_not_config_change_intent(arg0, arg1);
        cancel_rejected_intent_inner(arg0, arg1, arg2)
    }

    public(friend) fun cancel_rejected_intent_for_cleanup(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        cancel_rejected_intent_inner(arg0, arg1, arg2)
    }

    fun cancel_rejected_intent_inner(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        let v0 = *0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        assert_sender_can_cancel(&v0, 0x2::tx_context::sender(arg2));
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents(arg0), arg1)).status == 2, 6);
        emit_intent_cancelled(arg0, arg1, 0x2::tx_context::sender(arg2), 2);
        let v1 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::cancel_intent<Approvals, ConfigWitness>(arg0, arg1, v1, arg2)
    }

    public fun cancel_stale_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        assert_not_config_change_intent(arg0, arg1);
        cancel_stale_intent_inner(arg0, arg1, arg2)
    }

    public(friend) fun cancel_stale_intent_for_cleanup(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        cancel_stale_intent_inner(arg0, arg1, arg2)
    }

    fun cancel_stale_intent_inner(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Expired {
        assert!(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents(arg0), arg1)).config_nonce != 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0).config_nonce, 8);
        emit_intent_cancelled(arg0, arg1, 0x2::tx_context::sender(arg2), 1);
        let v0 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::cancel_intent<Approvals, ConfigWitness>(arg0, arg1, v0, arg2)
    }

    public fun config_nonce(arg0: &MultisigConfig) : u64 {
        arg0.config_nonce
    }

    public fun creation_fee(arg0: &MultisigFeeVault) : u64 {
        arg0.creation_fee
    }

    public fun disapprove_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::tx_context::TxContext) {
        let v0 = *0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        assert!(is_member_of_any_group(&v0, 0x2::tx_context::sender(arg2)), 0);
        let v1 = ConfigWitness{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome_mut<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get_mut<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v1), arg1));
        assert!(v2.config_nonce == v0.config_nonce, 7);
        assert!(v2.status == 0, 6);
        let v3 = 0x2::tx_context::sender(arg2);
        assert!(0x2::vec_set::contains<address>(&v2.approved, &v3), 5);
        let v4 = 0x2::tx_context::sender(arg2);
        0x2::vec_set::remove<address>(&mut v2.approved, &v4);
    }

    public(friend) fun emit_config_changed(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account) {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        let v1 = 0x1::vector::empty<0x1::string::String>();
        let v2 = vector[];
        let v3 = vector[];
        let v4 = vector[];
        let v5 = vector[];
        let v6 = vector[];
        let v7 = vector[];
        let v8 = &v0.groups;
        let v9 = 0;
        while (v9 < 0x1::vector::length<Group>(v8)) {
            let v10 = 0x1::vector::borrow<Group>(v8, v9);
            0x1::vector::push_back<0x1::string::String>(&mut v1, v10.name);
            0x1::vector::push_back<u64>(&mut v2, 0x1::vector::length<GroupMember>(&v10.members));
            let v11 = &v10.members;
            let v12 = 0;
            while (v12 < 0x1::vector::length<GroupMember>(v11)) {
                let v13 = 0x1::vector::borrow<GroupMember>(v11, v12);
                0x1::vector::push_back<address>(&mut v3, v13.addr);
                0x1::vector::push_back<u64>(&mut v4, v13.weight);
                v12 = v12 + 1;
            };
            0x1::vector::push_back<u64>(&mut v5, 0x1::vector::length<TimeBand>(&v10.time_bands));
            let v14 = &v10.time_bands;
            let v15 = 0;
            while (v15 < 0x1::vector::length<TimeBand>(v14)) {
                let v16 = 0x1::vector::borrow<TimeBand>(v14, v15);
                0x1::vector::push_back<u64>(&mut v6, v16.after_ms);
                0x1::vector::push_back<u64>(&mut v7, v16.weight);
                v15 = v15 + 1;
            };
            v9 = v9 + 1;
        };
        let v17 = vector[];
        let v18 = vector[];
        let v19 = vector[];
        let v20 = &v0.approve_policy.paths;
        let v21 = 0;
        while (v21 < 0x1::vector::length<PolicyPath>(v20)) {
            let v22 = 0x1::vector::borrow<PolicyPath>(v20, v21);
            0x1::vector::push_back<u64>(&mut v17, 0x1::vector::length<PathRequirement>(&v22.requirements));
            let v23 = &v22.requirements;
            let v24 = 0;
            while (v24 < 0x1::vector::length<PathRequirement>(v23)) {
                let v25 = 0x1::vector::borrow<PathRequirement>(v23, v24);
                0x1::vector::push_back<u64>(&mut v18, v25.group_idx);
                0x1::vector::push_back<u64>(&mut v19, v25.threshold);
                v24 = v24 + 1;
            };
            v21 = v21 + 1;
        };
        let v26 = vector[];
        let v27 = vector[];
        let v28 = vector[];
        let v29 = &v0.cancel_policy.paths;
        let v30 = 0;
        while (v30 < 0x1::vector::length<PolicyPath>(v29)) {
            let v31 = 0x1::vector::borrow<PolicyPath>(v29, v30);
            0x1::vector::push_back<u64>(&mut v26, 0x1::vector::length<PathRequirement>(&v31.requirements));
            let v32 = &v31.requirements;
            let v33 = 0;
            while (v33 < 0x1::vector::length<PathRequirement>(v32)) {
                let v34 = 0x1::vector::borrow<PathRequirement>(v32, v33);
                0x1::vector::push_back<u64>(&mut v27, v34.group_idx);
                0x1::vector::push_back<u64>(&mut v28, v34.threshold);
                v33 = v33 + 1;
            };
            v30 = v30 + 1;
        };
        let v35 = ConfigChangedEvent{
            account_addr              : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg0),
            group_names               : v1,
            group_member_counts       : v2,
            all_member_addresses      : v3,
            all_member_weights        : v4,
            time_band_counts          : v5,
            all_time_band_afters      : v6,
            all_time_band_weights     : v7,
            approve_path_req_counts   : v17,
            all_approve_group_indices : v18,
            all_approve_thresholds    : v19,
            cancel_path_req_counts    : v26,
            all_cancel_group_indices  : v27,
            all_cancel_thresholds     : v28,
            propose_groups            : v0.propose_groups,
            execute_groups            : v0.execute_groups,
            cancel_groups             : v0.cancel_groups,
            intent_expiry_ms          : v0.intent_expiry_ms,
            config_nonce              : v0.config_nonce,
        };
        0x2::event::emit<ConfigChangedEvent>(v35);
    }

    fun emit_intent_cancelled(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: address, arg3: u8) {
        let v0 = IntentCancelledEvent{
            account_addr : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg0),
            key          : arg1,
            canceller    : arg2,
            reason       : arg3,
        };
        0x2::event::emit<IntentCancelledEvent>(v0);
    }

    public(friend) fun emit_intent_created(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: address) {
        let v0 = IntentCreatedEvent{
            account_addr : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg0),
            key          : arg1,
            description  : arg2,
            creator      : arg3,
        };
        0x2::event::emit<IntentCreatedEvent>(v0);
    }

    public fun evaluate_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = *0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        if (!0x1::vector::is_empty<u64>(&v0.execute_groups)) {
            assert!(is_member_of_any_group(&v0, 0x2::tx_context::sender(arg3)), 0);
            assert!(is_in_execute_groups(&v0, 0x2::tx_context::sender(arg3)), 2);
        };
        let v1 = ConfigWitness{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get_mut<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v1), arg1);
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome_mut<Approvals>(v2);
        assert!(v3.config_nonce == v0.config_nonce, 7);
        assert!(v3.status == 0, 6);
        let v4 = 0x2::clock::timestamp_ms(arg2) - 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::creation_time<Approvals>(v2);
        let v5 = find_satisfied_reject_path(&v0, &v3.rejected, v4);
        if (0x1::option::is_some<u64>(&v5)) {
            v3.status = 2;
            v3.matched_vote_path = 0x1::option::none<u64>();
            v3.approved_at_ms = 0;
            return
        };
        let v6 = find_satisfied_vote_path(&v0, &v3.approved, v4);
        if (0x1::option::is_some<u64>(&v6)) {
            v3.status = 1;
            v3.matched_vote_path = v6;
            v3.approved_at_ms = 0x2::clock::timestamp_ms(arg2);
        };
    }

    public fun execute_groups(arg0: &MultisigConfig) : &vector<u64> {
        &arg0.execute_groups
    }

    public fun execute_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x1::string::String, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::executable::Executable<Approvals> {
        let v0 = *0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        if (!0x1::vector::is_empty<u64>(&v0.execute_groups)) {
            assert!(is_member_of_any_group(&v0, 0x2::tx_context::sender(arg4)), 0);
            assert!(is_in_execute_groups(&v0, 0x2::tx_context::sender(arg4)), 2);
        };
        let v1 = ConfigWitness{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get_mut<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v1), arg2);
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome_mut<Approvals>(v2);
        assert!(v3.config_nonce == v0.config_nonce, 7);
        assert!(v3.status == 1, 6);
        assert!(path_satisfied(&v0, 0x1::vector::borrow<PolicyPath>(&v0.approve_policy.paths, *0x1::option::borrow<u64>(&v3.matched_vote_path)), &v3.approved, 0x2::clock::timestamp_ms(arg3) - 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::creation_time<Approvals>(v2), true), 9);
        v3.status = 4;
        let v4 = IntentExecutedEvent{
            account_addr : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(arg0),
            key          : arg2,
            executor     : 0x2::tx_context::sender(arg4),
        };
        0x2::event::emit<IntentExecutedEvent>(v4);
        let v5 = ConfigWitness{dummy_field: false};
        let (_, v7) = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::create_executable<MultisigConfig, Approvals, ConfigWitness>(arg0, arg1, arg2, arg3, v5, arg4);
        v7
    }

    public fun fee_recipient(arg0: &MultisigFeeVault) : address {
        arg0.fee_recipient
    }

    fun find_satisfied_path(arg0: &RolePolicy, arg1: &MultisigConfig, arg2: &0x2::vec_set::VecSet<address>, arg3: u64, arg4: bool) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<PolicyPath>(&arg0.paths)) {
            if (path_satisfied(arg1, 0x1::vector::borrow<PolicyPath>(&arg0.paths, v0), arg2, arg3, arg4)) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun find_satisfied_reject_path(arg0: &MultisigConfig, arg1: &0x2::vec_set::VecSet<address>, arg2: u64) : 0x1::option::Option<u64> {
        find_satisfied_path(&arg0.cancel_policy, arg0, arg1, arg2, false)
    }

    fun find_satisfied_vote_path(arg0: &MultisigConfig, arg1: &0x2::vec_set::VecSet<address>, arg2: u64) : 0x1::option::Option<u64> {
        find_satisfied_path(&arg0.approve_policy, arg0, arg1, arg2, true)
    }

    public fun group_at(arg0: &MultisigConfig, arg1: u64) : &Group {
        0x1::vector::borrow<Group>(&arg0.groups, arg1)
    }

    public fun group_count(arg0: &MultisigConfig) : u64 {
        0x1::vector::length<Group>(&arg0.groups)
    }

    fun group_member_vote_weight(arg0: &Group, arg1: &0x2::vec_set::VecSet<address>) : u64 {
        let v0 = 0;
        let v1 = &arg0.members;
        let v2 = 0;
        while (v2 < 0x1::vector::length<GroupMember>(v1)) {
            let v3 = 0x1::vector::borrow<GroupMember>(v1, v2);
            if (0x2::vec_set::contains<address>(arg1, &v3.addr)) {
                v0 = v0 + v3.weight;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun group_members(arg0: &Group) : &vector<GroupMember> {
        &arg0.members
    }

    public fun group_name(arg0: &Group) : &0x1::string::String {
        &arg0.name
    }

    public fun group_time_bands(arg0: &Group) : &vector<TimeBand> {
        &arg0.time_bands
    }

    public fun groups(arg0: &MultisigConfig) : &vector<Group> {
        &arg0.groups
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg0);
        let v1 = MultisigAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<MultisigAdminCap>(v1, v0);
        let v2 = MultisigFeeVault{
            id            : 0x2::object::new(arg0),
            balance       : 0x2::balance::zero<0x2::sui::SUI>(),
            creation_fee  : 20000000000,
            fee_recipient : v0,
        };
        0x2::transfer::share_object<MultisigFeeVault>(v2);
    }

    public fun intent_cancelled_event_account_addr(arg0: &IntentCancelledEvent) : address {
        arg0.account_addr
    }

    public fun intent_cancelled_event_canceller(arg0: &IntentCancelledEvent) : address {
        arg0.canceller
    }

    public fun intent_cancelled_event_key(arg0: &IntentCancelledEvent) : 0x1::string::String {
        arg0.key
    }

    public fun intent_cancelled_event_reason(arg0: &IntentCancelledEvent) : u8 {
        arg0.reason
    }

    public fun intent_expiry_ms(arg0: &MultisigConfig) : u64 {
        arg0.intent_expiry_ms
    }

    public(friend) fun intent_has_config_change_action(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String) : bool {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_specs<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents(arg0), arg1));
        let v1 = 0;
        while (v1 < 0x1::vector::length<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v0)) {
            if (is_config_change_action_spec(0x1::vector::borrow<0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec>(v0, v1))) {
                return true
            };
            v1 = v1 + 1;
        };
        false
    }

    fun is_config_change_action_spec(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::ActionSpec) : bool {
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_type(arg0);
        if (0x1::type_name::is_primitive(&v0)) {
            return false
        };
        if (0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_spec_package_addr(arg0) == @0x0) {
            let v2 = 0x1::type_name::module_string(&v0);
            let v3 = b"config";
            if (0x1::ascii::as_bytes(&v2) == &v3) {
                let v4 = 0x1::type_name::datatype_string(&v0);
                let v5 = b"ConfigChange";
                0x1::ascii::as_bytes(&v4) == &v5
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_config_change_intent_witness<T0: drop>() : bool {
        let v0 = 0x1::type_name::with_original_ids<T0>();
        if (0x1::type_name::is_primitive(&v0)) {
            return false
        };
        if (0x1::type_name::original_id<T0>() == @0x0) {
            let v2 = 0x1::type_name::module_string(&v0);
            let v3 = b"config";
            if (0x1::ascii::as_bytes(&v2) == &v3) {
                let v4 = 0x1::type_name::datatype_string(&v0);
                let v5 = b"ConfigChangeIntent";
                0x1::ascii::as_bytes(&v4) == &v5
            } else {
                false
            }
        } else {
            false
        }
    }

    fun is_in_cancel_groups(arg0: &MultisigConfig, arg1: address) : bool {
        let v0 = &arg0.cancel_groups;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            let v3 = &0x1::vector::borrow<Group>(&arg0.groups, *0x1::vector::borrow<u64>(v0, v1)).members;
            let v4 = 0;
            let v5;
            while (v4 < 0x1::vector::length<GroupMember>(v3)) {
                if (0x1::vector::borrow<GroupMember>(v3, v4).addr == arg1) {
                    v5 = true;
                    /* label 9 */
                    if (v5) {
                        v2 = true;
                        return v2
                    };
                    v1 = v1 + 1;
                    /* goto 1 */
                    continue
                };
                v4 = v4 + 1;
            };
            v5 = false;
            /* goto 9 */
        };
        v2 = false;
        v2
    }

    fun is_in_execute_groups(arg0: &MultisigConfig, arg1: address) : bool {
        let v0 = &arg0.execute_groups;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            let v3 = &0x1::vector::borrow<Group>(&arg0.groups, *0x1::vector::borrow<u64>(v0, v1)).members;
            let v4 = 0;
            let v5;
            while (v4 < 0x1::vector::length<GroupMember>(v3)) {
                if (0x1::vector::borrow<GroupMember>(v3, v4).addr == arg1) {
                    v5 = true;
                    /* label 9 */
                    if (v5) {
                        v2 = true;
                        return v2
                    };
                    v1 = v1 + 1;
                    /* goto 1 */
                    continue
                };
                v4 = v4 + 1;
            };
            v5 = false;
            /* goto 9 */
        };
        v2 = false;
        v2
    }

    fun is_in_propose_groups(arg0: &MultisigConfig, arg1: address) : bool {
        let v0 = &arg0.propose_groups;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<u64>(v0)) {
            let v3 = &0x1::vector::borrow<Group>(&arg0.groups, *0x1::vector::borrow<u64>(v0, v1)).members;
            let v4 = 0;
            let v5;
            while (v4 < 0x1::vector::length<GroupMember>(v3)) {
                if (0x1::vector::borrow<GroupMember>(v3, v4).addr == arg1) {
                    v5 = true;
                    /* label 9 */
                    if (v5) {
                        v2 = true;
                        return v2
                    };
                    v1 = v1 + 1;
                    /* goto 1 */
                    continue
                };
                v4 = v4 + 1;
            };
            v5 = false;
            /* goto 9 */
        };
        v2 = false;
        v2
    }

    public fun is_member_of_any_group(arg0: &MultisigConfig, arg1: address) : bool {
        let v0 = &arg0.groups;
        let v1 = 0;
        let v2;
        while (v1 < 0x1::vector::length<Group>(v0)) {
            let v3 = &0x1::vector::borrow<Group>(v0, v1).members;
            let v4 = 0;
            let v5;
            while (v4 < 0x1::vector::length<GroupMember>(v3)) {
                if (0x1::vector::borrow<GroupMember>(v3, v4).addr == arg1) {
                    v5 = true;
                    /* label 9 */
                    if (v5) {
                        v2 = true;
                        return v2
                    };
                    v1 = v1 + 1;
                    /* goto 1 */
                    continue
                };
                v4 = v4 + 1;
            };
            v5 = false;
            /* goto 9 */
        };
        v2 = false;
        v2
    }

    public fun matched_vote_path(arg0: &Approvals) : &0x1::option::Option<u64> {
        &arg0.matched_vote_path
    }

    public fun max_action_specs_per_intent() : u64 {
        10
    }

    public fun max_groups() : u64 {
        20
    }

    public fun max_members() : u64 {
        200
    }

    public fun max_paths() : u64 {
        20
    }

    fun max_possible_group_member_weight(arg0: &Group, arg1: &0x2::vec_set::VecSet<address>) : u64 {
        let v0 = 0;
        let v1 = &arg0.members;
        let v2 = 0;
        while (v2 < 0x1::vector::length<GroupMember>(v1)) {
            let v3 = 0x1::vector::borrow<GroupMember>(v1, v2);
            if (!0x2::vec_set::contains<address>(arg1, &v3.addr)) {
                v0 = v0 + v3.weight;
            };
            v2 = v2 + 1;
        };
        v0
    }

    fun max_possible_group_weight(arg0: &Group, arg1: &0x2::vec_set::VecSet<address>, arg2: bool) : u64 {
        let v0 = max_possible_group_member_weight(arg0, arg1);
        let v1 = v0;
        if (arg2) {
            let v2 = 0x1::vector::length<TimeBand>(&arg0.time_bands);
            if (v2 > 0) {
                v1 = v0 + 0x1::vector::borrow<TimeBand>(&arg0.time_bands, v2 - 1).weight;
            };
        };
        v1
    }

    public fun max_time_bands() : u64 {
        10
    }

    public fun member_addr(arg0: &GroupMember) : address {
        arg0.addr
    }

    public fun member_weight(arg0: &GroupMember) : u64 {
        arg0.weight
    }

    public fun new_account(arg0: &mut MultisigFeeVault, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0x2::coin::Coin<0x2::sui::SUI>, arg3: vector<0x1::string::String>, arg4: vector<0x1::string::String>, arg5: vector<0x1::string::String>, arg6: vector<u64>, arg7: vector<address>, arg8: vector<u64>, arg9: vector<u64>, arg10: vector<u64>, arg11: vector<u64>, arg12: vector<u64>, arg13: vector<u64>, arg14: vector<u64>, arg15: vector<u64>, arg16: vector<u64>, arg17: vector<u64>, arg18: vector<u64>, arg19: vector<u64>, arg20: vector<u64>, arg21: u64, arg22: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account {
        let v0 = arg0.creation_fee;
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg2) >= v0, 33);
        if (v0 > 0) {
            0x2::balance::join<0x2::sui::SUI>(&mut arg0.balance, 0x2::coin::into_balance<0x2::sui::SUI>(0x2::coin::split<0x2::sui::SUI>(&mut arg2, v0, arg22)));
        };
        if (0x2::coin::value<0x2::sui::SUI>(&arg2) > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg2, 0x2::tx_context::sender(arg22));
        } else {
            0x2::coin::destroy_zero<0x2::sui::SUI>(arg2);
        };
        let v1 = ConfigWitness{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::new<MultisigConfig, ConfigWitness>(build_config_from_flat_vectors(arg5, arg6, arg7, arg8, arg9, arg10, arg11, arg12, arg13, arg14, arg15, arg16, arg17, arg18, arg19, arg20, arg21), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::metadata::from_keys_values(arg3, arg4), 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::deps::new(arg1), v1, arg22);
        let v3 = AccountCreatedEvent{
            account_addr : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::addr(&v2),
            creator      : 0x2::tx_context::sender(arg22),
        };
        0x2::event::emit<AccountCreatedEvent>(v3);
        v2
    }

    public(friend) fun new_config(arg0: vector<Group>, arg1: RolePolicy, arg2: RolePolicy, arg3: vector<u64>, arg4: vector<u64>, arg5: vector<u64>, arg6: u64) : MultisigConfig {
        let v0 = MultisigConfig{
            groups           : arg0,
            approve_policy   : arg1,
            cancel_policy    : arg2,
            propose_groups   : arg3,
            execute_groups   : arg4,
            cancel_groups    : arg5,
            intent_expiry_ms : arg6,
            config_nonce     : 0,
        };
        validate_config(&v0);
        v0
    }

    public fun new_outcome(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account) : Approvals {
        Approvals{
            config_nonce      : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0).config_nonce,
            status            : 0,
            approved          : 0x2::vec_set::empty<address>(),
            rejected          : 0x2::vec_set::empty<address>(),
            matched_vote_path : 0x1::option::none<u64>(),
            approved_at_ms    : 0,
        }
    }

    public fun new_params_from_config(arg0: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: 0x1::string::String, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) : 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::Params {
        let v0 = 0x1::vector::empty<u64>();
        0x1::vector::push_back<u64>(&mut v0, arg3);
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::new_params(arg1, arg2, v0, 0x2::clock::timestamp_ms(arg4) + 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0).intent_expiry_ms, arg4, arg5)
    }

    public(friend) fun new_proposed_config_key(arg0: 0x1::string::String) : ProposedConfigKey {
        ProposedConfigKey{intent_key: arg0}
    }

    public fun outcome_config_nonce(arg0: &Approvals) : u64 {
        arg0.config_nonce
    }

    public fun outcome_status(arg0: &Approvals) : u8 {
        arg0.status
    }

    fun path_can_be_satisfied(arg0: &MultisigConfig, arg1: &PolicyPath, arg2: &0x2::vec_set::VecSet<address>, arg3: bool) : bool {
        if (0x1::vector::is_empty<PathRequirement>(&arg1.requirements)) {
            return false
        };
        let v0 = true;
        let v1 = &arg1.requirements;
        let v2 = 0;
        while (v2 < 0x1::vector::length<PathRequirement>(v1)) {
            let v3 = 0x1::vector::borrow<PathRequirement>(v1, v2);
            let v4 = 0x1::vector::borrow<Group>(&arg0.groups, v3.group_idx);
            let v5 = if (v3.threshold == 0) {
                true
            } else if (max_possible_group_weight(v4, arg2, arg3) < v3.threshold) {
                true
            } else {
                arg3 && max_possible_group_member_weight(v4, arg2) == 0
            };
            if (v5) {
                v0 = false;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun path_requirements(arg0: &PolicyPath) : &vector<PathRequirement> {
        &arg0.requirements
    }

    fun path_satisfied(arg0: &MultisigConfig, arg1: &PolicyPath, arg2: &0x2::vec_set::VecSet<address>, arg3: u64, arg4: bool) : bool {
        if (0x1::vector::is_empty<PathRequirement>(&arg1.requirements)) {
            return false
        };
        let v0 = true;
        let v1 = &arg1.requirements;
        let v2 = 0;
        while (v2 < 0x1::vector::length<PathRequirement>(v1)) {
            let v3 = 0x1::vector::borrow<PathRequirement>(v1, v2);
            let v4 = 0x1::vector::borrow<Group>(&arg0.groups, v3.group_idx);
            let v5 = group_member_vote_weight(v4, arg2);
            if (v3.threshold == 0 || v5 + active_time_band_weight(v4, arg3, arg4) < v3.threshold) {
                v0 = false;
            };
            if (arg4 && v5 == 0) {
                v0 = false;
            };
            v2 = v2 + 1;
        };
        v0
    }

    public fun policy_paths(arg0: &RolePolicy) : &vector<PolicyPath> {
        &arg0.paths
    }

    public fun propose_groups(arg0: &MultisigConfig) : &vector<u64> {
        &arg0.propose_groups
    }

    public fun reject_intent(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: 0x1::string::String, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = *0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::config<MultisigConfig>(arg0);
        assert!(is_member_of_any_group(&v0, 0x2::tx_context::sender(arg3)), 0);
        let v1 = ConfigWitness{dummy_field: false};
        let v2 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::get_mut<Approvals>(0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::intents_mut<MultisigConfig, ConfigWitness>(arg0, v1), arg1);
        let v3 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome_mut<Approvals>(v2);
        assert!(v3.config_nonce == v0.config_nonce, 7);
        assert!(v3.status == 0 || v3.status == 1, 6);
        let v4 = 0x2::tx_context::sender(arg3);
        if (0x2::vec_set::contains<address>(&v3.approved, &v4)) {
            let v5 = 0x2::tx_context::sender(arg3);
            0x2::vec_set::remove<address>(&mut v3.approved, &v5);
        };
        let v6 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::vec_set::contains<address>(&v3.rejected, &v6), 4);
        0x2::vec_set::insert<address>(&mut v3.rejected, 0x2::tx_context::sender(arg3));
        let v7 = 0x2::clock::timestamp_ms(arg2) - 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::creation_time<Approvals>(v2);
        let v8 = find_satisfied_reject_path(&v0, &v3.rejected, v7);
        if (0x1::option::is_some<u64>(&v8)) {
            v3.status = 2;
            v3.matched_vote_path = 0x1::option::none<u64>();
            v3.approved_at_ms = 0;
        } else if (!can_any_approve_path_be_satisfied(&v0, &v3.rejected)) {
            v3.status = 2;
            v3.matched_vote_path = 0x1::option::none<u64>();
            v3.approved_at_ms = 0;
        } else {
            let v9 = find_satisfied_vote_path(&v0, &v3.approved, v7);
            if (0x1::option::is_some<u64>(&v9)) {
                v3.status = 1;
                v3.matched_vote_path = v9;
                if (v3.approved_at_ms == 0) {
                    v3.approved_at_ms = 0x2::clock::timestamp_ms(arg2);
                };
            } else {
                v3.status = 0;
                v3.matched_vote_path = 0x1::option::none<u64>();
                v3.approved_at_ms = 0;
            };
        };
    }

    public fun rejected(arg0: &Approvals) : vector<address> {
        *0x2::vec_set::keys<address>(&arg0.rejected)
    }

    public fun requirement_group_idx(arg0: &PathRequirement) : u64 {
        arg0.group_idx
    }

    public fun requirement_threshold(arg0: &PathRequirement) : u64 {
        arg0.threshold
    }

    public(friend) fun set_config_nonce(arg0: &mut MultisigConfig, arg1: u64) {
        arg0.config_nonce = arg1;
    }

    public(friend) fun set_intent_expiry_ms(arg0: &mut MultisigConfig, arg1: u64) {
        assert_valid_intent_policy(arg1);
        arg0.intent_expiry_ms = arg1;
    }

    public fun share(arg0: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account) {
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::share_account(arg0);
    }

    public fun stage_intent<T0: drop>(arg0: &mut 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::Account, arg1: &0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::package_registry::PackageRegistry, arg2: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::PendingIntent<Approvals>, arg3: 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::version_witness::VersionWitness, arg4: T0, arg5: &0x2::tx_context::TxContext) {
        assert_sender_can_propose(arg0, 0x2::tx_context::sender(arg5));
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::assert_package_witness_authorized(arg0, arg1, arg3);
        let v0 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::pending_inner<Approvals>(&arg2);
        let v1 = 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::action_count<Approvals>(v0);
        assert!(v1 > 0, 12);
        assert!(v1 <= 10, 11);
        assert_valid_config_change_intent<T0>(v0);
        assert_intent_matches_config_policy(arg0, v0);
        assert_fresh_pending_outcome(arg0, 0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::intents::outcome<Approvals>(v0));
        let v2 = ConfigWitness{dummy_field: false};
        0xf6ef484a0867ccffe219fa1f4648e58f8c3fd04a4ddcfb318a27f9cc6d2f3d9::account::insert_intent<MultisigConfig, Approvals, ConfigWitness, T0>(arg0, arg1, arg2, v2, arg4);
    }

    public fun status_active() : u8 {
        0
    }

    public fun status_approved() : u8 {
        1
    }

    public fun status_executed() : u8 {
        4
    }

    public fun status_rejected() : u8 {
        2
    }

    public fun sweep_fees(arg0: &MultisigAdminCap, arg1: &mut MultisigFeeVault, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0x2::sui::SUI>(&arg1.balance);
        if (v0 == 0) {
            return
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(0x2::coin::from_balance<0x2::sui::SUI>(0x2::balance::split<0x2::sui::SUI>(&mut arg1.balance, v0), arg2), arg1.fee_recipient);
    }

    public fun time_band_after_ms(arg0: &TimeBand) : u64 {
        arg0.after_ms
    }

    public fun time_band_weight(arg0: &TimeBand) : u64 {
        arg0.weight
    }

    public fun update_creation_fee(arg0: &MultisigAdminCap, arg1: &mut MultisigFeeVault, arg2: u64) {
        arg1.creation_fee = arg2;
    }

    public fun update_fee_recipient(arg0: &MultisigAdminCap, arg1: &mut MultisigFeeVault, arg2: address) {
        arg1.fee_recipient = arg2;
    }

    public(friend) fun validate_config(arg0: &MultisigConfig) {
        assert_valid_intent_policy(arg0.intent_expiry_ms);
        assert!(0x1::vector::length<Group>(&arg0.groups) > 0, 21);
        assert!(0x1::vector::length<Group>(&arg0.groups) <= 20, 21);
        assert!(0x1::vector::length<PolicyPath>(&arg0.approve_policy.paths) > 0, 22);
        assert!(0x1::vector::length<PolicyPath>(&arg0.approve_policy.paths) <= 20, 22);
        assert!(0x1::vector::length<PolicyPath>(&arg0.cancel_policy.paths) > 0, 22);
        assert!(0x1::vector::length<PolicyPath>(&arg0.cancel_policy.paths) <= 20, 22);
        let v0 = 0;
        let v1 = 0x2::vec_set::empty<0x1::string::String>();
        let v2 = &arg0.groups;
        let v3 = 0;
        while (v3 < 0x1::vector::length<Group>(v2)) {
            let v4 = 0x1::vector::borrow<Group>(v2, v3);
            assert!(0x1::string::length(&v4.name) > 0, 31);
            assert!(!0x2::vec_set::contains<0x1::string::String>(&v1, &v4.name), 30);
            0x2::vec_set::insert<0x1::string::String>(&mut v1, v4.name);
            let v5 = 0x2::vec_set::empty<address>();
            let v6 = &v4.members;
            let v7 = 0;
            while (v7 < 0x1::vector::length<GroupMember>(v6)) {
                let v8 = 0x1::vector::borrow<GroupMember>(v6, v7);
                assert!(!0x2::vec_set::contains<address>(&v5, &v8.addr), 24);
                0x2::vec_set::insert<address>(&mut v5, v8.addr);
                assert!(v8.weight > 0, 25);
                v7 = v7 + 1;
            };
            v0 = v0 + 0x1::vector::length<GroupMember>(&v4.members);
            let v9 = 0;
            let v10 = 0;
            let v11 = true;
            let v12 = &v4.time_bands;
            let v13 = 0;
            while (v13 < 0x1::vector::length<TimeBand>(v12)) {
                let v14 = 0x1::vector::borrow<TimeBand>(v12, v13);
                assert!(v14.weight > 0, 27);
                assert!(v14.after_ms > 0, 43);
                assert!(v14.after_ms < arg0.intent_expiry_ms, 42);
                if (!v11) {
                    assert!(v14.after_ms > v9, 26);
                    assert!(v14.weight >= v10, 26);
                };
                v9 = v14.after_ms;
                v10 = v14.weight;
                v11 = false;
                v13 = v13 + 1;
            };
            assert!(0x1::vector::length<TimeBand>(&v4.time_bands) <= 10, 26);
            v3 = v3 + 1;
        };
        assert!(v0 <= 200, 32);
        validate_role_policy(&arg0.approve_policy, arg0);
        validate_role_policy(&arg0.cancel_policy, arg0);
        validate_group_indices(&arg0.propose_groups, 0x1::vector::length<Group>(&arg0.groups));
        validate_group_indices(&arg0.execute_groups, 0x1::vector::length<Group>(&arg0.groups));
        validate_group_indices(&arg0.cancel_groups, 0x1::vector::length<Group>(&arg0.groups));
        let v15 = &arg0.propose_groups;
        let v16 = 0;
        let v17;
        while (v16 < 0x1::vector::length<u64>(v15)) {
            if (0x1::vector::length<GroupMember>(&0x1::vector::borrow<Group>(&arg0.groups, *0x1::vector::borrow<u64>(v15, v16)).members) > 0) {
                v17 = true;
                /* label 65 */
                assert!(v17, 29);
                let v18 = &arg0.cancel_groups;
                let v19 = 0;
                let v20;
                while (v19 < 0x1::vector::length<u64>(v18)) {
                    if (0x1::vector::length<GroupMember>(&0x1::vector::borrow<Group>(&arg0.groups, *0x1::vector::borrow<u64>(v18, v19)).members) > 0) {
                        v20 = true;
                        /* label 74 */
                        assert!(v20, 35);
                        let v21 = if (0x1::vector::is_empty<u64>(&arg0.execute_groups)) {
                            true
                        } else {
                            let v22 = &arg0.execute_groups;
                            let v23 = 0;
                            let v21;
                            while (v23 < 0x1::vector::length<u64>(v22)) {
                                if (0x1::vector::length<GroupMember>(&0x1::vector::borrow<Group>(&arg0.groups, *0x1::vector::borrow<u64>(v22, v23)).members) > 0) {
                                    v21 = true;
                                    /* goto 86 */
                                } else {
                                    /* goto 104 */
                                };
                            };
                            v21
                        };
                        /* label 86 */
                        assert!(v21, 44);
                        let v24 = 0x2::vec_set::empty<address>();
                        let v25 = &arg0.approve_policy.paths;
                        let v26 = 0;
                        while (v26 < 0x1::vector::length<PolicyPath>(v25)) {
                            assert!(path_can_be_satisfied(arg0, 0x1::vector::borrow<PolicyPath>(v25, v26), &v24, true), 28);
                            v26 = v26 + 1;
                        };
                        let v27 = &arg0.cancel_policy.paths;
                        let v28 = 0;
                        while (v28 < 0x1::vector::length<PolicyPath>(v27)) {
                            assert!(path_can_be_satisfied(arg0, 0x1::vector::borrow<PolicyPath>(v27, v28), &v24, false), 28);
                            v28 = v28 + 1;
                        };
                        return
                    };
                    v19 = v19 + 1;
                };
                v20 = false;
                /* goto 74 */
            } else {
                v16 = v16 + 1;
            };
        };
        v17 = false;
        /* goto 65 */
    }

    fun validate_group_indices(arg0: &vector<u64>, arg1: u64) {
        assert!(0x1::vector::length<u64>(arg0) <= 20, 47);
        let v0 = 0x2::vec_set::empty<u64>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<u64>(arg0)) {
            let v2 = 0x1::vector::borrow<u64>(arg0, v1);
            assert!(*v2 < arg1, 23);
            assert!(!0x2::vec_set::contains<u64>(&v0, v2), 46);
            0x2::vec_set::insert<u64>(&mut v0, *v2);
            v1 = v1 + 1;
        };
    }

    fun validate_role_policy(arg0: &RolePolicy, arg1: &MultisigConfig) {
        let v0 = &arg0.paths;
        let v1 = 0;
        while (v1 < 0x1::vector::length<PolicyPath>(v0)) {
            let v2 = 0x1::vector::borrow<PolicyPath>(v0, v1);
            assert!(0x1::vector::length<PathRequirement>(&v2.requirements) > 0, 36);
            assert!(0x1::vector::length<PathRequirement>(&v2.requirements) <= 20, 45);
            let v3 = 0x2::vec_set::empty<u64>();
            let v4 = &v2.requirements;
            let v5 = 0;
            while (v5 < 0x1::vector::length<PathRequirement>(v4)) {
                let v6 = 0x1::vector::borrow<PathRequirement>(v4, v5);
                assert!(v6.group_idx < 0x1::vector::length<Group>(&arg1.groups), 23);
                assert!(!0x2::vec_set::contains<u64>(&v3, &v6.group_idx), 46);
                0x2::vec_set::insert<u64>(&mut v3, v6.group_idx);
                assert!(v6.threshold > 0, 37);
                v5 = v5 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun vault_balance(arg0: &MultisigFeeVault) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.balance)
    }

    public(friend) fun witness() : ConfigWitness {
        ConfigWitness{dummy_field: false}
    }

    // decompiled from Move bytecode v6
}

