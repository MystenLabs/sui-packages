module 0x1b602d575ddf1ced075f9d2986bfe53cd7d4e59967ec26a0d949009c7b2c9d6c::bulletin {
    struct BULLETIN has drop {
        dummy_field: bool,
    }

    struct Member has copy, drop, store {
        addr: address,
        status: u8,
    }

    struct Proposal has copy, drop, store {
        proposal_id: u64,
        committee_type: u8,
        action_type: u8,
        subject_type: u8,
        target_address: address,
        target_did: vector<u8>,
        authorized_domains: vector<vector<u8>>,
        policy_hash: vector<u8>,
        metadata_hash: vector<u8>,
        params_hash: vector<u8>,
        created_by: address,
        created_at_ms: u64,
        expires_at_ms: u64,
        effective_from_ms: u64,
        subject_expiry_ms: u64,
        threshold_value: u64,
        required_approvals: u64,
        status: u8,
        approvals: u64,
        rejections: u64,
        approval_voters: vector<address>,
        rejection_voters: vector<address>,
        finalized_at_ms: u64,
    }

    struct SubjectState has copy, drop, store {
        subject_did: vector<u8>,
        subject_type: u8,
        status: u8,
        authorized_domains: vector<vector<u8>>,
        policy_hash: vector<u8>,
        metadata_hash: vector<u8>,
        effective_from_ms: u64,
        expires_at_ms: u64,
        version: u64,
        updated_at_ms: u64,
    }

    struct GovernanceExecutionEvent has copy, drop {
        event_type: u8,
        sequence: u64,
        root_authority_did: vector<u8>,
        proposal_id: u64,
        committee_type: u8,
        target_address: address,
        subject_did: vector<u8>,
        subject_type: u8,
        subject_status: u8,
        authorized_domains: vector<vector<u8>>,
        effective_from_ms: u64,
        expires_at_ms: u64,
        policy_hash: vector<u8>,
        metadata_hash: vector<u8>,
        previous_event_digest: vector<u8>,
        event_digest: vector<u8>,
        emitted_at_ms: u64,
    }

    struct BulletinInitializedEvent has copy, drop {
        root_authority_did: vector<u8>,
        meta_admins: vector<address>,
        admins: vector<address>,
        admin_threshold: u64,
        publisher: address,
        package_address: address,
    }

    struct Bulletin has key {
        id: 0x2::object::UID,
        root_authority_did: vector<u8>,
        meta_admins: vector<Member>,
        admins: vector<Member>,
        admin_threshold: u64,
        next_proposal_id: u64,
        next_event_sequence: u64,
        proposals: vector<Proposal>,
        subjects: vector<SubjectState>,
        last_event_digest: vector<u8>,
        last_clock_ms: u64,
    }

    struct BulletinInitState has key {
        id: 0x2::object::UID,
        initialized: bool,
        publisher: address,
        package_address: address,
    }

    struct UpgradeManager has store, key {
        id: 0x2::object::UID,
        publisher: address,
        cap: 0x2::package::UpgradeCap,
    }

    public fun upgrade_policy(arg0: &UpgradeManager) : u8 {
        0x2::package::upgrade_policy(&arg0.cap)
    }

    public fun active_admin_count(arg0: &Bulletin) : u64 {
        count_active_members(&arg0.admins)
    }

    public fun active_meta_admin_count(arg0: &Bulletin) : u64 {
        count_active_members(&arg0.meta_admins)
    }

    fun add_member(arg0: &mut vector<Member>, arg1: address, arg2: u64, arg3: u64) {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Member>(arg0)) {
            assert!(0x1::vector::borrow<Member>(arg0, v0).addr != arg1, 2);
            v0 = v0 + 1;
        };
        assert!(count_configured_members(arg0) < arg2, arg3);
        let v1 = Member{
            addr   : arg1,
            status : 1,
        };
        0x1::vector::push_back<Member>(arg0, v1);
    }

    public fun admin_at(arg0: &Bulletin, arg1: u64) : (address, u8) {
        let v0 = 0x1::vector::borrow<Member>(&arg0.admins, arg1);
        (v0.addr, v0.status)
    }

    public fun admin_count_total(arg0: &Bulletin) : u64 {
        0x1::vector::length<Member>(&arg0.admins)
    }

    public fun admin_threshold(arg0: &Bulletin) : u64 {
        arg0.admin_threshold
    }

    fun apply_passed_proposal(arg0: &mut Bulletin, arg1: Proposal, arg2: u64) {
        if (arg1.action_type == 1) {
            let v0 = &mut arg0.meta_admins;
            add_member(v0, arg1.target_address, 15, 19);
        } else if (arg1.action_type == 2) {
            let v1 = &mut arg0.meta_admins;
            update_member_status(v1, arg1.target_address, 2, 4);
        } else if (arg1.action_type == 3) {
            let v2 = &mut arg0.meta_admins;
            enable_member(v2, arg1.target_address);
        } else if (arg1.action_type == 4) {
            let v3 = &mut arg0.meta_admins;
            update_member_status(v3, arg1.target_address, 3, 4);
        } else if (arg1.action_type == 11) {
            let v4 = &mut arg0.admins;
            add_member(v4, arg1.target_address, 25, 20);
        } else if (arg1.action_type == 12) {
            let v5 = &mut arg0.admins;
            update_member_status(v5, arg1.target_address, 2, 4);
        } else if (arg1.action_type == 13) {
            let v6 = &mut arg0.admins;
            enable_member(v6, arg1.target_address);
        } else if (arg1.action_type == 14) {
            let v7 = &mut arg0.admins;
            update_member_status(v7, arg1.target_address, 3, 4);
        } else if (arg1.action_type == 15) {
            validate_admin_threshold(arg1.threshold_value, count_active_members(&arg0.admins));
            arg0.admin_threshold = arg1.threshold_value;
        } else {
            apply_subject_proposal(arg0, &arg1, arg2);
        };
        emit_execution_event(arg0, &arg1, arg2);
    }

    fun apply_subject_proposal(arg0: &mut Bulletin, arg1: &Proposal, arg2: u64) {
        let v0 = if (arg1.action_type == 21) {
            true
        } else if (arg1.action_type == 31) {
            true
        } else {
            arg1.action_type == 41
        };
        if (v0) {
            0x1::option::destroy_none<u64>(find_subject_index_opt(&arg0.subjects, arg1.subject_type, &arg1.target_did));
            let v1 = &mut arg0.subjects;
            upsert_subject(v1, 0x1::option::none<u64>(), arg1.subject_type, arg1.target_did, 1, arg1.authorized_domains, arg1.policy_hash, arg1.metadata_hash, arg1.effective_from_ms, arg1.subject_expiry_ms, arg2);
        } else if (arg1.action_type == 25 || arg1.action_type == 32) {
            let v2 = 0x1::vector::borrow_mut<SubjectState>(&mut arg0.subjects, 0x1::option::destroy_some<u64>(find_subject_index_opt(&arg0.subjects, arg1.subject_type, &arg1.target_did)));
            assert!(v2.status == 1, 16);
            v2.authorized_domains = arg1.authorized_domains;
            v2.policy_hash = arg1.policy_hash;
            v2.metadata_hash = arg1.metadata_hash;
            v2.version = v2.version + 1;
            v2.updated_at_ms = arg2;
        } else {
            let v3 = if (arg1.action_type == 22) {
                true
            } else if (arg1.action_type == 33) {
                true
            } else {
                arg1.action_type == 42
            };
            if (v3) {
                let v4 = &mut arg0.subjects;
                transition_subject(v4, find_subject_index_opt(&arg0.subjects, arg1.subject_type, &arg1.target_did), 1, 2, arg2, arg1.policy_hash, arg1.metadata_hash);
            } else {
                let v5 = if (arg1.action_type == 23) {
                    true
                } else if (arg1.action_type == 34) {
                    true
                } else {
                    arg1.action_type == 43
                };
                if (v5) {
                    let v6 = &mut arg0.subjects;
                    transition_subject(v6, find_subject_index_opt(&arg0.subjects, arg1.subject_type, &arg1.target_did), 2, 1, arg2, arg1.policy_hash, arg1.metadata_hash);
                } else {
                    let v7 = if (arg1.action_type == 24) {
                        true
                    } else if (arg1.action_type == 35) {
                        true
                    } else {
                        arg1.action_type == 44
                    };
                    assert!(v7, 11);
                    let v8 = &mut arg0.subjects;
                    revoke_subject(v8, find_subject_index_opt(&arg0.subjects, arg1.subject_type, &arg1.target_did), arg2, arg1.policy_hash, arg1.metadata_hash);
                };
            };
        };
    }

    fun assert_is_active_member(arg0: &Bulletin, arg1: u8, arg2: address) {
        assert!(member_status(arg0, arg1, arg2) == 1, 1);
    }

    fun assert_package_publisher(arg0: &UpgradeManager, arg1: &0x2::tx_context::TxContext) {
        assert!(0x2::tx_context::sender(arg1) == arg0.publisher, 27);
    }

    public fun authorize_package_upgrade(arg0: &mut UpgradeManager, arg1: u8, arg2: vector<u8>, arg3: &0x2::tx_context::TxContext) : 0x2::package::UpgradeTicket {
        assert_package_publisher(arg0, arg3);
        0x2::package::authorize_upgrade(&mut arg0.cap, arg1, arg2)
    }

    fun borrow_proposal(arg0: &vector<Proposal>, arg1: u64) : &Proposal {
        0x1::vector::borrow<Proposal>(arg0, find_proposal_index(arg0, arg1))
    }

    fun borrow_proposal_mut(arg0: &mut vector<Proposal>, arg1: u64) : &mut Proposal {
        0x1::vector::borrow_mut<Proposal>(arg0, find_proposal_index(arg0, arg1))
    }

    fun can_apply_passed_proposal(arg0: &Bulletin, arg1: &Proposal) : bool {
        if (arg1.action_type == 1) {
            let v1 = find_member_index_opt(&arg0.meta_admins, arg1.target_address);
            0x1::option::is_none<u64>(&v1) && count_configured_members(&arg0.meta_admins) < 15
        } else if (arg1.action_type == 2 || arg1.action_type == 4) {
            can_transition_member_status(&arg0.meta_admins, arg1.target_address, 4, 1)
        } else if (arg1.action_type == 3) {
            has_member_status(&arg0.meta_admins, arg1.target_address, 2)
        } else if (arg1.action_type == 11) {
            let v2 = find_member_index_opt(&arg0.admins, arg1.target_address);
            0x1::option::is_none<u64>(&v2) && count_configured_members(&arg0.admins) < 25
        } else {
            (arg1.action_type == 12 || arg1.action_type == 14) && can_transition_member_status(&arg0.admins, arg1.target_address, 4, 1) || arg1.action_type == 13 && has_member_status(&arg0.admins, arg1.target_address, 2) || arg1.action_type == 15 && arg1.threshold_value >= 1 && arg1.threshold_value <= max_threshold(count_active_members(&arg0.admins)) || can_apply_subject_proposal(arg0, arg1)
        }
    }

    fun can_apply_subject_proposal(arg0: &Bulletin, arg1: &Proposal) : bool {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1.subject_type, &arg1.target_did);
        let v1 = if (arg1.action_type == 21) {
            true
        } else if (arg1.action_type == 31) {
            true
        } else {
            arg1.action_type == 41
        };
        if (v1) {
            0x1::option::is_none<u64>(&v0)
        } else if (arg1.action_type == 25) {
            subject_has_status(&arg0.subjects, arg1.subject_type, &arg1.target_did, 1)
        } else if (arg1.action_type == 32) {
            subject_has_status(&arg0.subjects, arg1.subject_type, &arg1.target_did, 1)
        } else {
            let v3 = if (arg1.action_type == 22) {
                true
            } else if (arg1.action_type == 33) {
                true
            } else {
                arg1.action_type == 42
            };
            if (v3) {
                subject_has_status(&arg0.subjects, arg1.subject_type, &arg1.target_did, 1)
            } else {
                let v4 = if (arg1.action_type == 23) {
                    true
                } else if (arg1.action_type == 34) {
                    true
                } else {
                    arg1.action_type == 43
                };
                if (v4) {
                    subject_has_status(&arg0.subjects, arg1.subject_type, &arg1.target_did, 2)
                } else {
                    let v5 = if (arg1.action_type == 24) {
                        true
                    } else if (arg1.action_type == 35) {
                        true
                    } else {
                        arg1.action_type == 44
                    };
                    v5 && subject_is_active_or_suspended(&arg0.subjects, arg1.subject_type, &arg1.target_did)
                }
            }
        }
    }

    fun can_transition_member_status(arg0: &vector<Member>, arg1: address, arg2: u64, arg3: u8) : bool {
        let v0 = find_member_index_opt(arg0, arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        if (0x1::vector::borrow<Member>(arg0, 0x1::option::destroy_some<u64>(v0)).status != arg3) {
            return false
        };
        count_active_members(arg0) > arg2
    }

    public fun commit_package_upgrade(arg0: &mut UpgradeManager, arg1: 0x2::package::UpgradeReceipt, arg2: &0x2::tx_context::TxContext) {
        assert_package_publisher(arg0, arg2);
        0x2::package::commit_upgrade(&mut arg0.cap, arg1);
    }

    fun compare_bytes(arg0: &vector<u8>, arg1: &vector<u8>) : u8 {
        let v0 = 0x1::vector::length<u8>(arg0);
        let v1 = 0x1::vector::length<u8>(arg1);
        let v2 = 0;
        let v3 = if (v0 < v1) {
            v0
        } else {
            v1
        };
        while (v2 < v3) {
            let v4 = *0x1::vector::borrow<u8>(arg0, v2);
            let v5 = *0x1::vector::borrow<u8>(arg1, v2);
            if (v4 < v5) {
                return 1
            };
            if (v4 > v5) {
                return 2
            };
            v2 = v2 + 1;
        };
        if (v0 < v1) {
            1
        } else if (v0 > v1) {
            2
        } else {
            0
        }
    }

    fun compute_event_digest(arg0: u64, arg1: vector<u8>, arg2: u8, arg3: u64, arg4: u8, arg5: address, arg6: u8, arg7: vector<u8>, arg8: u8, arg9: vector<vector<u8>>, arg10: u64, arg11: u64, arg12: vector<u8>, arg13: vector<u8>, arg14: vector<u8>, arg15: u64) : vector<u8> {
        let v0 = 0x1::bcs::to_bytes<u64>(&arg0);
        0x1::vector::append<u8>(&mut v0, arg1);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg2));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg3));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg4));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<address>(&arg5));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg6));
        0x1::vector::append<u8>(&mut v0, arg7);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u8>(&arg8));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<vector<vector<u8>>>(&arg9));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg10));
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg11));
        0x1::vector::append<u8>(&mut v0, arg12);
        0x1::vector::append<u8>(&mut v0, arg13);
        0x1::vector::append<u8>(&mut v0, arg14);
        0x1::vector::append<u8>(&mut v0, 0x1::bcs::to_bytes<u64>(&arg15));
        0x1::hash::sha3_256(v0)
    }

    fun count_active_members(arg0: &vector<Member>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Member>(arg0)) {
            if (0x1::vector::borrow<Member>(arg0, v1).status == 1) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun count_configured_members(arg0: &vector<Member>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v1 < 0x1::vector::length<Member>(arg0)) {
            if (0x1::vector::borrow<Member>(arg0, v1).status != 3) {
                v0 = v0 + 1;
            };
            v1 = v1 + 1;
        };
        v0
    }

    fun count_pending_proposals(arg0: &vector<Proposal>) : u64 {
        let v0 = 0;
        let v1 = 0;
        while (v0 < 0x1::vector::length<Proposal>(arg0)) {
            if (0x1::vector::borrow<Proposal>(arg0, v0).status == 1) {
                v1 = v1 + 1;
            };
            v0 = v0 + 1;
        };
        v1
    }

    public fun create_proposal(arg0: &mut Bulletin, arg1: u8, arg2: u8, arg3: address, arg4: vector<u8>, arg5: u8, arg6: vector<vector<u8>>, arg7: vector<u8>, arg8: vector<u8>, arg9: vector<u8>, arg10: u64, arg11: u64, arg12: u64, arg13: &0x2::clock::Clock, arg14: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg14);
        assert!(arg1 == expected_committee_for_action(arg2), 10);
        assert_is_active_member(arg0, arg1, v0);
        validate_action_subject(arg2, arg5);
        let v1 = 0x2::clock::timestamp_ms(arg13);
        validate_proposal_inputs(arg2, arg5, &arg4, &arg6, &arg7, &arg8, &arg9, arg10, arg11, v1);
        touch_clock(arg0, v1);
        let v2 = &mut arg0.proposals;
        prune_finalized_proposals_if_needed(v2);
        assert!(count_pending_proposals(&arg0.proposals) < 256, 21);
        if (arg2 == 15) {
            validate_admin_threshold(arg12, count_active_members(&arg0.admins));
        };
        let v3 = Proposal{
            proposal_id        : arg0.next_proposal_id,
            committee_type     : arg1,
            action_type        : arg2,
            subject_type       : arg5,
            target_address     : arg3,
            target_did         : arg4,
            authorized_domains : arg6,
            policy_hash        : arg7,
            metadata_hash      : arg8,
            params_hash        : arg9,
            created_by         : v0,
            created_at_ms      : v1,
            expires_at_ms      : v1 + 864000000,
            effective_from_ms  : arg10,
            subject_expiry_ms  : arg11,
            threshold_value    : arg12,
            required_approvals : current_threshold_for_new_proposal(arg0, arg1),
            status             : 1,
            approvals          : 0,
            rejections         : 0,
            approval_voters    : vector[],
            rejection_voters   : vector[],
            finalized_at_ms    : 0,
        };
        arg0.next_proposal_id = arg0.next_proposal_id + 1;
        0x1::vector::push_back<Proposal>(&mut arg0.proposals, v3);
    }

    fun current_threshold_for_new_proposal(arg0: &Bulletin, arg1: u8) : u64 {
        if (arg1 == 1) {
            max_threshold(count_active_members(&arg0.meta_admins))
        } else {
            assert!(arg1 == 2, 10);
            arg0.admin_threshold
        }
    }

    public fun discovery_is_authorized_at(arg0: &Bulletin, arg1: vector<u8>, arg2: u64) : bool {
        subject_is_authorized_at(arg0, 2, arg1, arg2)
    }

    fun emit_execution_event(arg0: &mut Bulletin, arg1: &Proposal, arg2: u64) {
        let (v0, v1, v2, v3, v4, v5) = execution_subject_snapshot(arg0, arg1);
        let v6 = arg0.next_event_sequence + 1;
        let v7 = arg0.last_event_digest;
        let v8 = compute_event_digest(v6, arg0.root_authority_did, arg1.action_type, arg1.proposal_id, arg1.committee_type, arg1.target_address, arg1.subject_type, arg1.target_did, v0, v1, v2, v3, v4, v5, v7, arg2);
        let v9 = GovernanceExecutionEvent{
            event_type            : arg1.action_type,
            sequence              : v6,
            root_authority_did    : arg0.root_authority_did,
            proposal_id           : arg1.proposal_id,
            committee_type        : arg1.committee_type,
            target_address        : arg1.target_address,
            subject_did           : arg1.target_did,
            subject_type          : arg1.subject_type,
            subject_status        : v0,
            authorized_domains    : v1,
            effective_from_ms     : v2,
            expires_at_ms         : v3,
            policy_hash           : v4,
            metadata_hash         : v5,
            previous_event_digest : v7,
            event_digest          : v8,
            emitted_at_ms         : arg2,
        };
        0x2::event::emit<GovernanceExecutionEvent>(v9);
        arg0.next_event_sequence = v6;
        arg0.last_event_digest = v8;
    }

    fun enable_member(arg0: &mut vector<Member>, arg1: address) {
        let v0 = find_member_index(arg0, arg1);
        assert!(0x1::vector::borrow<Member>(arg0, v0).status == 2, 13);
        0x1::vector::borrow_mut<Member>(arg0, v0).status = 1;
    }

    fun execution_subject_snapshot(arg0: &Bulletin, arg1: &Proposal) : (u8, vector<vector<u8>>, u64, u64, vector<u8>, vector<u8>) {
        if (arg1.subject_type == 0) {
            (0, vector[], 0, 0, arg1.policy_hash, arg1.metadata_hash)
        } else {
            let v6 = 0x1::vector::borrow<SubjectState>(&arg0.subjects, find_subject_index(&arg0.subjects, arg1.subject_type, &arg1.target_did));
            (v6.status, v6.authorized_domains, v6.effective_from_ms, v6.expires_at_ms, v6.policy_hash, v6.metadata_hash)
        }
    }

    fun expected_committee_for_action(arg0: u8) : u8 {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 11) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 13) {
            true
        } else if (arg0 == 14) {
            true
        } else {
            arg0 == 15
        };
        if (v0) {
            1
        } else {
            let v2 = if (arg0 == 21) {
                true
            } else if (arg0 == 22) {
                true
            } else if (arg0 == 23) {
                true
            } else if (arg0 == 24) {
                true
            } else if (arg0 == 25) {
                true
            } else if (arg0 == 31) {
                true
            } else if (arg0 == 32) {
                true
            } else if (arg0 == 33) {
                true
            } else if (arg0 == 34) {
                true
            } else if (arg0 == 35) {
                true
            } else if (arg0 == 41) {
                true
            } else if (arg0 == 42) {
                true
            } else if (arg0 == 43) {
                true
            } else {
                arg0 == 44
            };
            assert!(v2, 11);
            2
        }
    }

    fun find_member_index(arg0: &vector<Member>, arg1: address) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Member>(arg0)) {
            if (0x1::vector::borrow<Member>(arg0, v0).addr == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 12
    }

    fun find_member_index_opt(arg0: &vector<Member>, arg1: address) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Member>(arg0)) {
            if (0x1::vector::borrow<Member>(arg0, v0).addr == arg1) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun find_oldest_finalized_proposal_index(arg0: &vector<Proposal>) : 0x1::option::Option<u64> {
        let v0 = 0;
        let v1 = false;
        let v2 = 0;
        while (v0 < 0x1::vector::length<Proposal>(arg0)) {
            let v3 = 0x1::vector::borrow<Proposal>(arg0, v0);
            if (v3.status != 1) {
                if (!v1 || v3.proposal_id < v2) {
                    v1 = true;
                    v2 = v3.proposal_id;
                };
            };
            v0 = v0 + 1;
        };
        if (v1) {
            0x1::option::some<u64>(0)
        } else {
            0x1::option::none<u64>()
        }
    }

    fun find_proposal_index(arg0: &vector<Proposal>, arg1: u64) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<Proposal>(arg0)) {
            if (0x1::vector::borrow<Proposal>(arg0, v0).proposal_id == arg1) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 6
    }

    fun find_subject_index(arg0: &vector<SubjectState>, arg1: u8, arg2: &vector<u8>) : u64 {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SubjectState>(arg0)) {
            let v1 = 0x1::vector::borrow<SubjectState>(arg0, v0);
            if (v1.subject_type == arg1 && &v1.subject_did == arg2) {
                return v0
            };
            v0 = v0 + 1;
        };
        abort 15
    }

    fun find_subject_index_opt(arg0: &vector<SubjectState>, arg1: u8, arg2: &vector<u8>) : 0x1::option::Option<u64> {
        let v0 = 0;
        while (v0 < 0x1::vector::length<SubjectState>(arg0)) {
            let v1 = 0x1::vector::borrow<SubjectState>(arg0, v0);
            if (v1.subject_type == arg1 && &v1.subject_did == arg2) {
                return 0x1::option::some<u64>(v0)
            };
            v0 = v0 + 1;
        };
        0x1::option::none<u64>()
    }

    fun has_address(arg0: &vector<address>, arg1: address) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<address>(arg0)) {
            if (*0x1::vector::borrow<address>(arg0, v0) == arg1) {
                return true
            };
            v0 = v0 + 1;
        };
        false
    }

    fun has_member_status(arg0: &vector<Member>, arg1: address, arg2: u8) : bool {
        let v0 = find_member_index_opt(arg0, arg1);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        0x1::vector::borrow<Member>(arg0, 0x1::option::destroy_some<u64>(v0)).status == arg2
    }

    fun init(arg0: BULLETIN, arg1: &mut 0x2::tx_context::TxContext) {
        let v0 = BulletinInitState{
            id              : 0x2::object::new(arg1),
            initialized     : false,
            publisher       : 0x2::tx_context::sender(arg1),
            package_address : 0x1::type_name::defining_id<BULLETIN>(),
        };
        0x2::transfer::share_object<BulletinInitState>(v0);
    }

    public fun initialize(arg0: &mut BulletinInitState, arg1: vector<u8>, arg2: vector<address>, arg3: vector<address>, arg4: u64, arg5: 0x2::package::UpgradeCap, arg6: &mut 0x2::tx_context::TxContext) {
        assert!(!arg0.initialized, 26);
        assert!(0x2::tx_context::sender(arg6) == arg0.publisher, 28);
        let v0 = 0x2::package::upgrade_package(&arg5);
        assert!(0x2::object::id_to_address(&v0) == arg0.package_address, 29);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = new_bulletin(arg1, arg2, arg3, arg4, arg6);
        arg0.initialized = true;
        let v3 = BulletinInitializedEvent{
            root_authority_did : v2.root_authority_did,
            meta_admins        : arg2,
            admins             : arg3,
            admin_threshold    : arg4,
            publisher          : v1,
            package_address    : arg0.package_address,
        };
        0x2::event::emit<BulletinInitializedEvent>(v3);
        0x2::transfer::share_object<Bulletin>(v2);
        0x2::transfer::transfer<UpgradeManager>(new_upgrade_manager(v1, arg5, arg6), v1);
    }

    fun is_canonical_authorized_domain(arg0: &vector<u8>) : bool {
        let v0 = 0;
        while (v0 < 0x1::vector::length<u8>(arg0)) {
            let v1 = *0x1::vector::borrow<u8>(arg0, v0);
            if (v1 >= 65 && v1 <= 90) {
                return false
            };
            v0 = v0 + 1;
        };
        true
    }

    fun is_wildcard_authorized_domain(arg0: &vector<u8>) : bool {
        0x1::vector::length<u8>(arg0) == 1 && *0x1::vector::borrow<u8>(arg0, 0) == 42
    }

    public fun latest_event_sequence(arg0: &Bulletin) : u64 {
        arg0.next_event_sequence
    }

    fun max_threshold(arg0: u64) : u64 {
        arg0 * 2 / 3 + 1
    }

    public fun member_status(arg0: &Bulletin, arg1: u8, arg2: address) : u8 {
        if (arg1 == 1) {
            0x1::vector::borrow<Member>(&arg0.meta_admins, find_member_index(&arg0.meta_admins, arg2)).status
        } else {
            assert!(arg1 == 2, 10);
            0x1::vector::borrow<Member>(&arg0.admins, find_member_index(&arg0.admins, arg2)).status
        }
    }

    fun members_from_addresses(arg0: vector<address>) : vector<Member> {
        let v0 = 0x1::vector::empty<Member>();
        let v1 = 0;
        while (v1 < 0x1::vector::length<address>(&arg0)) {
            let v2 = Member{
                addr   : *0x1::vector::borrow<address>(&arg0, v1),
                status : 1,
            };
            0x1::vector::push_back<Member>(&mut v0, v2);
            v1 = v1 + 1;
        };
        v0
    }

    public fun meta_admin_at(arg0: &Bulletin, arg1: u64) : (address, u8) {
        let v0 = 0x1::vector::borrow<Member>(&arg0.meta_admins, arg1);
        (v0.addr, v0.status)
    }

    public fun meta_admin_count_total(arg0: &Bulletin) : u64 {
        0x1::vector::length<Member>(&arg0.meta_admins)
    }

    fun new_bulletin(arg0: vector<u8>, arg1: vector<address>, arg2: vector<address>, arg3: u64, arg4: &mut 0x2::tx_context::TxContext) : Bulletin {
        assert!(0x1::vector::length<u8>(&arg0) > 0, 23);
        assert!(0x1::vector::length<u8>(&arg0) <= 128, 22);
        assert!(0x1::vector::length<address>(&arg1) >= 4, 3);
        assert!(0x1::vector::length<address>(&arg2) >= 4, 4);
        assert!(0x1::vector::length<address>(&arg1) <= 15, 19);
        assert!(0x1::vector::length<address>(&arg2) <= 25, 20);
        validate_unique_addresses(&arg1);
        validate_unique_addresses(&arg2);
        validate_admin_threshold(arg3, 0x1::vector::length<address>(&arg2));
        Bulletin{
            id                  : 0x2::object::new(arg4),
            root_authority_did  : arg0,
            meta_admins         : members_from_addresses(arg1),
            admins              : members_from_addresses(arg2),
            admin_threshold     : arg3,
            next_proposal_id    : 1,
            next_event_sequence : 0,
            proposals           : 0x1::vector::empty<Proposal>(),
            subjects            : 0x1::vector::empty<SubjectState>(),
            last_event_digest   : b"",
            last_clock_ms       : 0,
        }
    }

    fun new_upgrade_manager(arg0: address, arg1: 0x2::package::UpgradeCap, arg2: &mut 0x2::tx_context::TxContext) : UpgradeManager {
        UpgradeManager{
            id        : 0x2::object::new(arg2),
            publisher : arg0,
            cap       : arg1,
        }
    }

    public fun proposal_status(arg0: &Bulletin, arg1: u64) : u8 {
        borrow_proposal(&arg0.proposals, arg1).status
    }

    fun prune_finalized_proposals_if_needed(arg0: &mut vector<Proposal>) {
        while (0x1::vector::length<Proposal>(arg0) >= 300) {
            let v0 = find_oldest_finalized_proposal_index(arg0);
            if (0x1::option::is_none<u64>(&v0)) {
                return
            };
            0x1::vector::remove<Proposal>(arg0, 0x1::option::destroy_some<u64>(v0));
        };
    }

    public fun refresh_proposal_status(arg0: &mut Bulletin, arg1: u64, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        touch_clock(arg0, v0);
        let v1 = find_proposal_index(&arg0.proposals, arg1);
        let v2 = *0x1::vector::borrow<Proposal>(&arg0.proposals, v1);
        assert!(v2.status == 1, 8);
        if (v2.approvals >= v2.required_approvals) {
            if (!can_apply_passed_proposal(arg0, &v2)) {
                let v3 = 0x1::vector::borrow_mut<Proposal>(&mut arg0.proposals, v1);
                v3.status = 4;
                v3.finalized_at_ms = v0;
                return
            };
            let v4 = 0x1::vector::borrow_mut<Proposal>(&mut arg0.proposals, v1);
            v4.status = 2;
            v4.finalized_at_ms = v0;
            apply_passed_proposal(arg0, v2, v0);
        } else if (v0 > v2.expires_at_ms) {
            let v5 = 0x1::vector::borrow_mut<Proposal>(&mut arg0.proposals, v1);
            v5.status = 3;
            v5.finalized_at_ms = v0;
        };
    }

    public fun registrar_is_authorized_at(arg0: &Bulletin, arg1: vector<u8>, arg2: u64) : bool {
        subject_is_authorized_at(arg0, 1, arg1, arg2)
    }

    public fun restrict_upgrade_policy_to_additive(arg0: &mut UpgradeManager, arg1: &0x2::tx_context::TxContext) {
        assert_package_publisher(arg0, arg1);
        0x2::package::only_additive_upgrades(&mut arg0.cap);
    }

    public fun restrict_upgrade_policy_to_dep_only(arg0: &mut UpgradeManager, arg1: &0x2::tx_context::TxContext) {
        assert_package_publisher(arg0, arg1);
        0x2::package::only_dep_upgrades(&mut arg0.cap);
    }

    fun revoke_subject(arg0: &mut vector<SubjectState>, arg1: 0x1::option::Option<u64>, arg2: u64, arg3: vector<u8>, arg4: vector<u8>) {
        let v0 = 0x1::vector::borrow_mut<SubjectState>(arg0, 0x1::option::destroy_some<u64>(arg1));
        assert!(v0.status == 1 || v0.status == 2, 16);
        v0.status = 3;
        v0.policy_hash = arg3;
        v0.metadata_hash = arg4;
        v0.version = v0.version + 1;
        v0.updated_at_ms = arg2;
    }

    public fun root_authority_did(arg0: &Bulletin) : vector<u8> {
        arg0.root_authority_did
    }

    public fun subject_authorization_snapshot_at(arg0: &Bulletin, arg1: u8, arg2: vector<u8>, arg3: u64) : (bool, bool, u8, u64, u64, u64) {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return (false, false, 0, 0, 0, 0)
        };
        let v1 = 0x1::vector::borrow<SubjectState>(&arg0.subjects, 0x1::option::destroy_some<u64>(v0));
        let v2 = if (v1.status == 1) {
            if (v1.effective_from_ms == 0 || v1.effective_from_ms <= arg3) {
                v1.expires_at_ms == 0 || arg3 < v1.expires_at_ms
            } else {
                false
            }
        } else {
            false
        };
        (true, v2, v1.status, v1.version, v1.effective_from_ms, v1.expires_at_ms)
    }

    public fun subject_authorized_domains(arg0: &Bulletin, arg1: u8, arg2: vector<u8>) : vector<vector<u8>> {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return vector[]
        };
        0x1::vector::borrow<SubjectState>(&arg0.subjects, 0x1::option::destroy_some<u64>(v0)).authorized_domains
    }

    public fun subject_domain_count(arg0: &Bulletin, arg1: u8, arg2: vector<u8>) : u64 {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        0x1::vector::length<vector<u8>>(&0x1::vector::borrow<SubjectState>(&arg0.subjects, 0x1::option::destroy_some<u64>(v0)).authorized_domains)
    }

    public fun subject_exists(arg0: &Bulletin, arg1: u8, arg2: vector<u8>) : bool {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        0x1::option::is_some<u64>(&v0)
    }

    fun subject_has_status(arg0: &vector<SubjectState>, arg1: u8, arg2: &vector<u8>, arg3: u8) : bool {
        let v0 = find_subject_index_opt(arg0, arg1, arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        0x1::vector::borrow<SubjectState>(arg0, 0x1::option::destroy_some<u64>(v0)).status == arg3
    }

    fun subject_is_active_or_suspended(arg0: &vector<SubjectState>, arg1: u8, arg2: &vector<u8>) : bool {
        let v0 = find_subject_index_opt(arg0, arg1, arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return false
        };
        let v1 = 0x1::vector::borrow<SubjectState>(arg0, 0x1::option::destroy_some<u64>(v0)).status;
        v1 == 1 || v1 == 2
    }

    public fun subject_is_authorized_at(arg0: &Bulletin, arg1: u8, arg2: vector<u8>, arg3: u64) : bool {
        let (_, v1, _, _, _, _) = subject_authorization_snapshot_at(arg0, arg1, arg2, arg3);
        v1
    }

    public fun subject_metadata_hash(arg0: &Bulletin, arg1: u8, arg2: vector<u8>) : vector<u8> {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return b""
        };
        0x1::vector::borrow<SubjectState>(&arg0.subjects, 0x1::option::destroy_some<u64>(v0)).metadata_hash
    }

    public fun subject_policy_hash(arg0: &Bulletin, arg1: u8, arg2: vector<u8>) : vector<u8> {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return b""
        };
        0x1::vector::borrow<SubjectState>(&arg0.subjects, 0x1::option::destroy_some<u64>(v0)).policy_hash
    }

    public fun subject_snapshot(arg0: &Bulletin, arg1: u8, arg2: vector<u8>) : (bool, u8, u64, u64, u64) {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return (false, 0, 0, 0, 0)
        };
        let v1 = 0x1::vector::borrow<SubjectState>(&arg0.subjects, 0x1::option::destroy_some<u64>(v0));
        (true, v1.status, v1.version, v1.effective_from_ms, v1.expires_at_ms)
    }

    public fun subject_status(arg0: &Bulletin, arg1: u8, arg2: vector<u8>) : u8 {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        0x1::vector::borrow<SubjectState>(&arg0.subjects, 0x1::option::destroy_some<u64>(v0)).status
    }

    public fun subject_version(arg0: &Bulletin, arg1: u8, arg2: vector<u8>) : u64 {
        let v0 = find_subject_index_opt(&arg0.subjects, arg1, &arg2);
        if (0x1::option::is_none<u64>(&v0)) {
            return 0
        };
        0x1::vector::borrow<SubjectState>(&arg0.subjects, 0x1::option::destroy_some<u64>(v0)).version
    }

    fun touch_clock(arg0: &mut Bulletin, arg1: u64) {
        assert!(arg1 >= arg0.last_clock_ms, 18);
        arg0.last_clock_ms = arg1;
    }

    fun transition_subject(arg0: &mut vector<SubjectState>, arg1: 0x1::option::Option<u64>, arg2: u8, arg3: u8, arg4: u64, arg5: vector<u8>, arg6: vector<u8>) {
        let v0 = 0x1::vector::borrow_mut<SubjectState>(arg0, 0x1::option::destroy_some<u64>(arg1));
        assert!(v0.status == arg2, 16);
        v0.status = arg3;
        v0.policy_hash = arg5;
        v0.metadata_hash = arg6;
        v0.version = v0.version + 1;
        v0.updated_at_ms = arg4;
    }

    fun update_member_status(arg0: &mut vector<Member>, arg1: address, arg2: u8, arg3: u64) {
        let v0 = find_member_index(arg0, arg1);
        assert!(0x1::vector::borrow<Member>(arg0, v0).status == 1, 13);
        assert!(count_active_members(arg0) - 1 >= arg3, 14);
        0x1::vector::borrow_mut<Member>(arg0, v0).status = arg2;
    }

    public fun upgrade_package_id(arg0: &UpgradeManager) : 0x2::object::ID {
        0x2::package::upgrade_package(&arg0.cap)
    }

    public fun upgrade_publisher(arg0: &UpgradeManager) : address {
        arg0.publisher
    }

    public fun upgrade_version(arg0: &UpgradeManager) : u64 {
        0x2::package::version(&arg0.cap)
    }

    fun upsert_subject(arg0: &mut vector<SubjectState>, arg1: 0x1::option::Option<u64>, arg2: u8, arg3: vector<u8>, arg4: u8, arg5: vector<vector<u8>>, arg6: vector<u8>, arg7: vector<u8>, arg8: u64, arg9: u64, arg10: u64) {
        if (0x1::option::is_some<u64>(&arg1)) {
            let v0 = 0x1::vector::borrow_mut<SubjectState>(arg0, 0x1::option::destroy_some<u64>(arg1));
            v0.status = arg4;
            v0.authorized_domains = arg5;
            v0.policy_hash = arg6;
            v0.metadata_hash = arg7;
            v0.effective_from_ms = arg8;
            v0.expires_at_ms = arg9;
            v0.version = v0.version + 1;
            v0.updated_at_ms = arg10;
        } else {
            0x1::option::destroy_none<u64>(arg1);
            let v1 = SubjectState{
                subject_did        : arg3,
                subject_type       : arg2,
                status             : arg4,
                authorized_domains : arg5,
                policy_hash        : arg6,
                metadata_hash      : arg7,
                effective_from_ms  : arg8,
                expires_at_ms      : arg9,
                version            : 1,
                updated_at_ms      : arg10,
            };
            0x1::vector::push_back<SubjectState>(arg0, v1);
        };
    }

    fun validate_action_subject(arg0: u8, arg1: u8) {
        let v0 = if (arg0 == 1) {
            true
        } else if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 11) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 13) {
            true
        } else if (arg0 == 14) {
            true
        } else {
            arg0 == 15
        };
        if (v0) {
            assert!(arg1 == 0, 17);
        } else {
            let v1 = if (arg0 == 21) {
                true
            } else if (arg0 == 22) {
                true
            } else if (arg0 == 23) {
                true
            } else if (arg0 == 24) {
                true
            } else {
                arg0 == 25
            };
            if (v1) {
                assert!(arg1 == 1, 17);
            } else {
                let v2 = if (arg0 == 31) {
                    true
                } else if (arg0 == 32) {
                    true
                } else if (arg0 == 33) {
                    true
                } else if (arg0 == 34) {
                    true
                } else {
                    arg0 == 35
                };
                if (v2) {
                    assert!(arg1 == 2, 17);
                } else {
                    let v3 = if (arg0 == 41) {
                        true
                    } else if (arg0 == 42) {
                        true
                    } else if (arg0 == 43) {
                        true
                    } else {
                        arg0 == 44
                    };
                    assert!(v3, 11);
                    assert!(arg1 == 3, 17);
                };
            };
        };
    }

    fun validate_admin_threshold(arg0: u64, arg1: u64) {
        assert!(arg0 >= 1, 5);
        assert!(arg0 <= max_threshold(arg1), 5);
    }

    fun validate_authorized_domains(arg0: &vector<vector<u8>>) {
        let v0 = 0x1::vector::length<vector<u8>>(arg0);
        assert!(v0 > 0, 25);
        assert!(v0 <= 116, 22);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = 0x1::vector::borrow<vector<u8>>(arg0, v1);
            assert!(0x1::vector::length<u8>(v2) > 0, 25);
            assert!(0x1::vector::length<u8>(v2) <= 128, 22);
            assert!(is_canonical_authorized_domain(v2), 32);
            if (is_wildcard_authorized_domain(v2)) {
                assert!(v0 == 1, 33);
            };
            if (v1 > 0) {
                assert!(compare_bytes(0x1::vector::borrow<vector<u8>>(arg0, v1 - 1), v2) == 1, 31);
            };
            v1 = v1 + 1;
        };
    }

    fun validate_proposal_inputs(arg0: u8, arg1: u8, arg2: &vector<u8>, arg3: &vector<vector<u8>>, arg4: &vector<u8>, arg5: &vector<u8>, arg6: &vector<u8>, arg7: u64, arg8: u64, arg9: u64) {
        assert!(0x1::vector::length<u8>(arg5) > 0, 30);
        assert!(0x1::vector::length<u8>(arg6) > 0, 30);
        assert!(0x1::vector::length<u8>(arg4) <= 256, 22);
        assert!(0x1::vector::length<u8>(arg5) <= 256, 22);
        assert!(0x1::vector::length<u8>(arg6) <= 256, 22);
        if (arg1 == 0) {
            assert!(0x1::vector::length<u8>(arg2) == 0, 17);
            assert!(0x1::vector::length<vector<u8>>(arg3) == 0, 17);
            return
        };
        assert!(0x1::vector::length<u8>(arg2) > 0, 23);
        assert!(0x1::vector::length<u8>(arg2) <= 256, 22);
        assert!(arg7 == 0 || arg7 <= arg9, 24);
        assert!(arg8 == 0 || arg8 > arg9, 24);
        assert!(arg8 == 0 || arg7 <= arg8, 24);
        if (arg1 == 1) {
            if (arg0 == 21 || arg0 == 25) {
                validate_authorized_domains(arg3);
            } else {
                assert!(0x1::vector::length<vector<u8>>(arg3) == 0, 17);
            };
        } else if (arg1 == 2) {
            if (arg0 == 31 || arg0 == 32) {
                validate_authorized_domains(arg3);
            } else {
                assert!(0x1::vector::length<vector<u8>>(arg3) == 0, 17);
            };
        } else {
            assert!(0x1::vector::length<vector<u8>>(arg3) == 0, 17);
        };
    }

    fun validate_unique_addresses(arg0: &vector<address>) {
        let v0 = 0x1::vector::length<address>(arg0);
        let v1 = 0;
        while (v1 < v0) {
            let v2 = v1 + 1;
            while (v2 < v0) {
                assert!(*0x1::vector::borrow<address>(arg0, v1) != *0x1::vector::borrow<address>(arg0, v2), 2);
                v2 = v2 + 1;
            };
            v1 = v1 + 1;
        };
    }

    public fun vc_issuer_is_authorized_at(arg0: &Bulletin, arg1: vector<u8>, arg2: u64) : bool {
        subject_is_authorized_at(arg0, 3, arg1, arg2)
    }

    public fun vote(arg0: &mut Bulletin, arg1: u64, arg2: bool, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        let v1 = borrow_proposal(&arg0.proposals, arg1).committee_type;
        let v2 = 0x2::clock::timestamp_ms(arg3);
        touch_clock(arg0, v2);
        assert_is_active_member(arg0, v1, v0);
        let v3 = &mut arg0.proposals;
        let v4 = borrow_proposal_mut(v3, arg1);
        assert!(v4.status == 1, 8);
        assert!(v2 <= v4.expires_at_ms, 9);
        assert!(!has_address(&v4.approval_voters, v0) && !has_address(&v4.rejection_voters, v0), 7);
        if (arg2) {
            0x1::vector::push_back<address>(&mut v4.approval_voters, v0);
            v4.approvals = v4.approvals + 1;
        } else {
            0x1::vector::push_back<address>(&mut v4.rejection_voters, v0);
            v4.rejections = v4.rejections + 1;
        };
    }

    // decompiled from Move bytecode v7
}

