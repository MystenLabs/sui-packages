module 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::governance {
    struct GovernanceConfig has key {
        id: 0x2::object::UID,
        pm_duration_ms: u64,
        votable_posting_fee: u64,
        pm_foundation_pct: u64,
        pm_gateway_pct: u64,
        pm_creator_pct: u64,
        pm_pool_pct: u64,
        post_foundation_pct: u64,
        post_gateway_pct: u64,
        post_creator_pct: u64,
        post_pm_pct: u64,
        proposal_duration_ms: u64,
        quorum_pct: u64,
        last_updated_ms: u64,
    }

    struct GovernanceAdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct GovernanceProposal has key {
        id: 0x2::object::UID,
        proposer: address,
        param_key: vector<u8>,
        param_value: u64,
        split_values: vector<u64>,
        eligible_voters_root: vector<u8>,
        eligible_voter_count: u64,
        created_at_ms: u64,
        expires_at_ms: u64,
        executed: bool,
    }

    struct GovernanceConfigUpdated has copy, drop {
        param_key: vector<u8>,
        old_value: u64,
        new_value: u64,
        updated_at_ms: u64,
    }

    struct GovernanceSplitsUpdated has copy, drop {
        param_key: vector<u8>,
        foundation_pct: u64,
        gateway_pct: u64,
        creator_pct: u64,
        pool_pct: u64,
        updated_at_ms: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: 0x2::object::ID,
        proposer: address,
        param_key: vector<u8>,
        param_value: u64,
        split_values: vector<u64>,
        expires_at_ms: u64,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: 0x2::object::ID,
        param_key: vector<u8>,
        yes_count: u64,
        no_count: u64,
    }

    fun apply_param(arg0: &mut GovernanceConfig, arg1: &vector<u8>, arg2: u64, arg3: &vector<u64>, arg4: u64) {
        if (*arg1 == b"pm_duration_ms") {
            arg0.pm_duration_ms = arg2;
            emit_config_updated(*arg1, arg0.pm_duration_ms, arg2, arg4);
        } else if (*arg1 == b"votable_posting_fee") {
            arg0.votable_posting_fee = arg2;
            emit_config_updated(*arg1, arg0.votable_posting_fee, arg2, arg4);
        } else if (*arg1 == b"proposal_duration_ms") {
            arg0.proposal_duration_ms = arg2;
            emit_config_updated(*arg1, arg0.proposal_duration_ms, arg2, arg4);
        } else if (*arg1 == b"quorum_pct") {
            assert!(arg2 > 0 && arg2 <= 100, 2);
            arg0.quorum_pct = arg2;
            emit_config_updated(*arg1, arg0.quorum_pct, arg2, arg4);
        } else if (*arg1 == b"pm_splits") {
            assert!(0x1::vector::length<u64>(arg3) == 4, 10);
            arg0.pm_foundation_pct = *0x1::vector::borrow<u64>(arg3, 0);
            arg0.pm_gateway_pct = *0x1::vector::borrow<u64>(arg3, 1);
            arg0.pm_creator_pct = *0x1::vector::borrow<u64>(arg3, 2);
            arg0.pm_pool_pct = *0x1::vector::borrow<u64>(arg3, 3);
            emit_splits_updated(*arg1, arg0.pm_foundation_pct, arg0.pm_gateway_pct, arg0.pm_creator_pct, arg0.pm_pool_pct, arg4);
        } else {
            assert!(*arg1 == b"post_splits", 1);
            assert!(0x1::vector::length<u64>(arg3) == 4, 10);
            arg0.post_foundation_pct = *0x1::vector::borrow<u64>(arg3, 0);
            arg0.post_gateway_pct = *0x1::vector::borrow<u64>(arg3, 1);
            arg0.post_creator_pct = *0x1::vector::borrow<u64>(arg3, 2);
            arg0.post_pm_pct = *0x1::vector::borrow<u64>(arg3, 3);
            emit_splits_updated(*arg1, arg0.post_foundation_pct, arg0.post_gateway_pct, arg0.post_creator_pct, arg0.post_pm_pct, arg4);
        };
        arg0.last_updated_ms = arg4;
    }

    public fun create_proposal(arg0: &GovernanceConfig, arg1: address, arg2: vector<u8>, arg3: u64, arg4: vector<u64>, arg5: vector<u8>, arg6: u64, arg7: &0x2::clock::Clock, arg8: &GovernanceAdminCap, arg9: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x1::vector::length<u8>(&arg2);
        assert!(v0 > 0 && v0 <= 64, 8);
        if (is_splits_key(&arg2)) {
            assert!(0x1::vector::length<u64>(&arg4) == 4, 10);
            assert!(*0x1::vector::borrow<u64>(&arg4, 0) + *0x1::vector::borrow<u64>(&arg4, 1) + *0x1::vector::borrow<u64>(&arg4, 2) + *0x1::vector::borrow<u64>(&arg4, 3) == 100, 6);
        };
        let v1 = 0x2::clock::timestamp_ms(arg7);
        let v2 = v1 + arg0.proposal_duration_ms;
        let v3 = 0x2::object::new(arg9);
        let v4 = ProposalCreated{
            proposal_id   : 0x2::object::uid_to_inner(&v3),
            proposer      : arg1,
            param_key     : arg2,
            param_value   : arg3,
            split_values  : arg4,
            expires_at_ms : v2,
        };
        0x2::event::emit<ProposalCreated>(v4);
        let v5 = GovernanceProposal{
            id                   : v3,
            proposer             : arg1,
            param_key            : arg2,
            param_value          : arg3,
            split_values         : arg4,
            eligible_voters_root : arg5,
            eligible_voter_count : arg6,
            created_at_ms        : v1,
            expires_at_ms        : v2,
            executed             : false,
        };
        0x2::transfer::share_object<GovernanceProposal>(v5);
    }

    fun emit_config_updated(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64) {
        let v0 = GovernanceConfigUpdated{
            param_key     : arg0,
            old_value     : arg1,
            new_value     : arg2,
            updated_at_ms : arg3,
        };
        0x2::event::emit<GovernanceConfigUpdated>(v0);
    }

    fun emit_splits_updated(arg0: vector<u8>, arg1: u64, arg2: u64, arg3: u64, arg4: u64, arg5: u64) {
        let v0 = GovernanceSplitsUpdated{
            param_key      : arg0,
            foundation_pct : arg1,
            gateway_pct    : arg2,
            creator_pct    : arg3,
            pool_pct       : arg4,
            updated_at_ms  : arg5,
        };
        0x2::event::emit<GovernanceSplitsUpdated>(v0);
    }

    public fun execute_proposal(arg0: &mut GovernanceConfig, arg1: &mut GovernanceProposal, arg2: vector<u8>, arg3: vector<vector<u8>>, arg4: vector<vector<vector<u8>>>, arg5: vector<vector<u8>>, arg6: u64, arg7: u64, arg8: &0x2::clock::Clock, arg9: &GovernanceAdminCap) {
        assert!(!arg1.executed, 4);
        let v0 = 0x2::clock::timestamp_ms(arg8);
        assert!(v0 >= arg1.expires_at_ms, 3);
        let v1 = arg6 + arg7;
        let v2 = arg1.eligible_voter_count * arg0.quorum_pct / 100;
        assert!(v1 >= v2, 5);
        assert!(arg6 > arg7, 9);
        let v3 = 0x1::vector::length<vector<u8>>(&arg3);
        assert!(v3 > 0, 7);
        assert!(v3 <= 200, 11);
        let v4 = 0x1::vector::empty<u8>();
        let v5 = 0;
        while (v5 < 0x1::vector::length<u8>(&arg1.param_key)) {
            0x1::vector::push_back<u8>(&mut v4, *0x1::vector::borrow<u8>(&arg1.param_key, v5));
            v5 = v5 + 1;
        };
        let v6 = 0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::merkle_verifier::create_merkle_root(v4, arg2, v1, v2);
        assert!(0x5bc3f9d6132ba769548d329498c8dcb0d84a2b979a5dd9554d05fd1763fd3b54::merkle_verifier::verify_batch_ad_views(&v6, arg3, arg4, arg5), 7);
        apply_param(arg0, &arg1.param_key, arg1.param_value, &arg1.split_values, v0);
        arg1.executed = true;
        let v7 = ProposalExecuted{
            proposal_id : 0x2::object::id<GovernanceProposal>(arg1),
            param_key   : arg1.param_key,
            yes_count   : arg6,
            no_count    : arg7,
        };
        0x2::event::emit<ProposalExecuted>(v7);
    }

    public fun get_pm_creator_pct(arg0: &GovernanceConfig) : u64 {
        arg0.pm_creator_pct
    }

    public fun get_pm_duration(arg0: &GovernanceConfig) : u64 {
        arg0.pm_duration_ms
    }

    public fun get_pm_foundation_pct(arg0: &GovernanceConfig) : u64 {
        arg0.pm_foundation_pct
    }

    public fun get_pm_gateway_pct(arg0: &GovernanceConfig) : u64 {
        arg0.pm_gateway_pct
    }

    public fun get_pm_pool_pct(arg0: &GovernanceConfig) : u64 {
        arg0.pm_pool_pct
    }

    public fun get_post_creator_pct(arg0: &GovernanceConfig) : u64 {
        arg0.post_creator_pct
    }

    public fun get_post_foundation_pct(arg0: &GovernanceConfig) : u64 {
        arg0.post_foundation_pct
    }

    public fun get_post_gateway_pct(arg0: &GovernanceConfig) : u64 {
        arg0.post_gateway_pct
    }

    public fun get_post_pm_pct(arg0: &GovernanceConfig) : u64 {
        arg0.post_pm_pct
    }

    public fun get_proposal_duration(arg0: &GovernanceConfig) : u64 {
        arg0.proposal_duration_ms
    }

    public fun get_quorum_pct(arg0: &GovernanceConfig) : u64 {
        arg0.quorum_pct
    }

    public fun get_votable_fee(arg0: &GovernanceConfig) : u64 {
        arg0.votable_posting_fee
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceAdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<GovernanceAdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = GovernanceConfig{
            id                   : 0x2::object::new(arg0),
            pm_duration_ms       : 259200000,
            votable_posting_fee  : 1000000000,
            pm_foundation_pct    : 10,
            pm_gateway_pct       : 9,
            pm_creator_pct       : 41,
            pm_pool_pct          : 40,
            post_foundation_pct  : 10,
            post_gateway_pct     : 9,
            post_creator_pct     : 81,
            post_pm_pct          : 0,
            proposal_duration_ms : 604800000,
            quorum_pct           : 51,
            last_updated_ms      : 0,
        };
        0x2::transfer::share_object<GovernanceConfig>(v1);
    }

    fun is_splits_key(arg0: &vector<u8>) : bool {
        *arg0 == b"pm_splits" || *arg0 == b"post_splits"
    }

    public fun pm_status_active() : u8 {
        0
    }

    public fun pm_status_failed() : u8 {
        2
    }

    public fun pm_status_passed() : u8 {
        1
    }

    // decompiled from Move bytecode v6
}

