module 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance_voting {
    struct GovernanceConfig has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        pprf_total_supply: u64,
        proposer_threshold: u64,
        proposal_duration_epochs: u64,
        next_proposal_id: u64,
        proposal_creation_paused: bool,
        active_proposal_id: 0x1::option::Option<u64>,
        proposal_id_to_object: 0x2::table::Table<u64, 0x2::object::ID>,
        enabled_actions: 0x2::table::Table<u8, bool>,
    }

    struct VoteRecord has drop, store {
        side: u8,
        voting_power: u64,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        version: u64,
        registry_id: 0x2::object::ID,
        proposal_id: u64,
        proposer: address,
        proposal_type: u8,
        action_type: u8,
        title: 0x1::string::String,
        description: 0x1::string::String,
        payload_u64_1: u64,
        payload_u64_2: u64,
        payload_address: address,
        payload_object_id: 0x1::option::Option<0x2::object::ID>,
        payload_bytes: vector<u8>,
        yes_votes: u64,
        no_votes: u64,
        yes_locked_balance: 0x2::balance::Balance<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>,
        no_locked_balance: 0x2::balance::Balance<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>,
        start_epoch: u64,
        end_epoch: u64,
        status: u8,
        executed: bool,
        votes: 0x2::table::Table<address, VoteRecord>,
    }

    struct GovernanceConfigCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        governance_config_id: 0x2::object::ID,
        pprf_total_supply: u64,
        proposer_threshold: u64,
        proposal_duration_epochs: u64,
    }

    struct ProposalCreatedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        proposal_id: u64,
        proposer: address,
        proposal_type: u8,
        action_type: u8,
        proposal_object_id: 0x2::object::ID,
        proposer_stake: u64,
    }

    struct VoteCastEvent has copy, drop {
        registry_id: 0x2::object::ID,
        proposal_id: u64,
        voter: address,
        side: u8,
        voting_power: u64,
    }

    struct ProposalFinalizedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        proposal_id: u64,
        yes_votes: u64,
        no_votes: u64,
        status: u8,
    }

    struct ProposalExecutedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        proposal_id: u64,
        action_type: u8,
        executed_by: address,
    }

    struct ProposalExpiredEvent has copy, drop {
        registry_id: 0x2::object::ID,
        proposal_id: u64,
        expired_at_epoch: u64,
    }

    struct VoteClaimedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        proposal_id: u64,
        voter: address,
        side: u8,
        voting_power: u64,
    }

    struct GovernanceConfigMigratedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        migrated_by: address,
        new_version: u64,
    }

    struct ProposalMigratedEvent has copy, drop {
        proposal_id: u64,
        registry_id: 0x2::object::ID,
        migrated_by: address,
        new_version: u64,
    }

    struct ProposalCreationPausedChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        old_paused: bool,
        paused: bool,
    }

    struct ProposerThresholdChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        old_threshold: u64,
        new_threshold: u64,
    }

    struct ProposalDurationChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        old_duration_epochs: u64,
        new_duration_epochs: u64,
    }

    struct GovernanceActionStatusChangedEvent has copy, drop {
        registry_id: 0x2::object::ID,
        changed_by: address,
        action_type: u8,
        old_enabled: bool,
        enabled: bool,
    }

    public fun action_activate_artifact_type() : u8 {
        11
    }

    public fun action_cancel_operator_transfer() : u8 {
        14
    }

    public fun action_enabled(arg0: &GovernanceConfig, arg1: u8) : bool {
        0x2::table::contains<u8, bool>(&arg0.enabled_actions, arg1) && *0x2::table::borrow<u8, bool>(&arg0.enabled_actions, arg1)
    }

    public fun action_nominate_operator() : u8 {
        4
    }

    public fun action_set_artifact_fee_level() : u8 {
        10
    }

    public fun action_set_artifact_type_enabled() : u8 {
        9
    }

    public fun action_set_comments_fee_level() : u8 {
        2
    }

    public fun action_set_direct_authority_mode() : u8 {
        13
    }

    public fun action_set_fee_recipient() : u8 {
        3
    }

    public fun action_set_governance_action_enabled() : u8 {
        12
    }

    public fun action_set_governance_authority() : u8 {
        15
    }

    public fun action_set_proposal_creation_paused() : u8 {
        5
    }

    public fun action_set_proposal_duration_epochs() : u8 {
        8
    }

    public fun action_set_proposer_threshold() : u8 {
        6
    }

    public fun action_set_upgrade_authority() : u8 {
        7
    }

    public fun action_signal_feature_direction() : u8 {
        102
    }

    public fun action_signal_policy_position() : u8 {
        103
    }

    public fun action_signal_replace_operator() : u8 {
        101
    }

    public fun action_type(arg0: &Proposal) : u8 {
        arg0.action_type
    }

    public fun active_proposal_id(arg0: &GovernanceConfig) : 0x1::option::Option<u64> {
        arg0.active_proposal_id
    }

    fun apply_action_enabled(arg0: &mut GovernanceConfig, arg1: u8, arg2: bool, arg3: address) {
        assert_valid_action_enable_target(arg1);
        if (0x2::table::contains<u8, bool>(&arg0.enabled_actions, arg1)) {
            *0x2::table::borrow_mut<u8, bool>(&mut arg0.enabled_actions, arg1) = arg2;
        } else {
            0x2::table::add<u8, bool>(&mut arg0.enabled_actions, arg1, arg2);
        };
        let v0 = GovernanceActionStatusChangedEvent{
            registry_id : arg0.registry_id,
            changed_by  : arg3,
            action_type : arg1,
            old_enabled : action_enabled(arg0, arg1),
            enabled     : arg2,
        };
        0x2::event::emit<GovernanceActionStatusChangedEvent>(v0);
    }

    fun assert_action_enabled(arg0: &GovernanceConfig, arg1: u8) {
        assert!(action_enabled(arg0, arg1), 28);
    }

    fun assert_current_config(arg0: &GovernanceConfig) {
        assert!(arg0.version == 1, 23);
    }

    fun assert_current_proposal(arg0: &Proposal) {
        assert!(arg0.version == 1, 24);
    }

    fun assert_known_action(arg0: u8) {
        let v0 = if (arg0 == 2) {
            true
        } else if (arg0 == 3) {
            true
        } else if (arg0 == 4) {
            true
        } else if (arg0 == 5) {
            true
        } else if (arg0 == 6) {
            true
        } else if (arg0 == 7) {
            true
        } else if (arg0 == 8) {
            true
        } else if (arg0 == 9) {
            true
        } else if (arg0 == 10) {
            true
        } else if (arg0 == 11) {
            true
        } else if (arg0 == 12) {
            true
        } else if (arg0 == 13) {
            true
        } else if (arg0 == 14) {
            true
        } else if (arg0 == 15) {
            true
        } else if (arg0 == 101) {
            true
        } else if (arg0 == 102) {
            true
        } else {
            arg0 == 103
        };
        assert!(v0, 4);
    }

    fun assert_proposal_belongs_to_config(arg0: &GovernanceConfig, arg1: &Proposal) {
        assert!(arg1.registry_id == arg0.registry_id, 13);
        assert!(0x2::table::contains<u64, 0x2::object::ID>(&arg0.proposal_id_to_object, arg1.proposal_id), 31);
        assert!(*0x2::table::borrow<u64, 0x2::object::ID>(&arg0.proposal_id_to_object, arg1.proposal_id) == 0x2::object::id<Proposal>(arg1), 31);
    }

    fun assert_valid_action_enable_target(arg0: u8) {
        assert_known_action(arg0);
        assert!(arg0 != 12, 29);
    }

    fun assert_valid_proposal_action_pair(arg0: u8, arg1: u8) {
        if (arg0 == 1) {
            let v0 = if (arg1 == 2) {
                true
            } else if (arg1 == 3) {
                true
            } else if (arg1 == 4) {
                true
            } else if (arg1 == 5) {
                true
            } else if (arg1 == 6) {
                true
            } else if (arg1 == 7) {
                true
            } else if (arg1 == 8) {
                true
            } else if (arg1 == 9) {
                true
            } else if (arg1 == 10) {
                true
            } else if (arg1 == 11) {
                true
            } else if (arg1 == 12) {
                true
            } else if (arg1 == 13) {
                true
            } else if (arg1 == 14) {
                true
            } else {
                arg1 == 15
            };
            assert!(v0, 15);
        } else {
            assert!(arg0 == 2, 3);
            let v1 = if (arg1 == 101) {
                true
            } else if (arg1 == 102) {
                true
            } else {
                arg1 == 103
            };
            assert!(v1, 16);
        };
    }

    fun assert_valid_proposal_duration_epochs(arg0: u64) {
        assert!(arg0 >= 7 && arg0 <= 14, 25);
    }

    fun assert_valid_proposal_payload(arg0: u8, arg1: u8, arg2: u64, arg3: u64, arg4: address) {
        if (arg0 == 2) {
            return
        };
        if (arg1 == 2) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_valid_fee_level((arg2 as u8));
        } else if (arg1 == 3) {
            assert!(arg4 != @0x0, 4);
        } else if (arg1 == 4) {
            assert!(arg4 != @0x0, 4);
        } else if (arg1 == 5) {
            assert!(arg2 == 0 || arg2 == 1, 12);
        } else if (arg1 == 6) {
            assert_valid_proposer_threshold(arg2);
        } else if (arg1 == 7) {
            assert!(arg4 != @0x0, 4);
        } else if (arg1 == 8) {
            assert_valid_proposal_duration_epochs(arg2);
        } else if (arg1 == 9) {
            assert!(arg3 == 0 || arg3 == 1, 12);
        } else if (arg1 == 10) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_valid_fee_level((arg3 as u8));
        } else if (arg1 == 11) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_valid_fee_level((arg3 as u8));
        } else if (arg1 == 12) {
            assert_valid_action_enable_target((arg2 as u8));
            assert!(arg3 == 0 || arg3 == 1, 12);
        } else if (arg1 == 13) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_valid_direct_authority_mode((arg2 as u8));
        } else if (arg1 == 14) {
        } else {
            assert!(arg1 == 15, 4);
            assert!(arg4 != @0x0, 4);
        };
    }

    fun assert_valid_proposal_text(arg0: &0x1::string::String, arg1: &0x1::string::String) {
        assert!(0x1::string::length(arg0) > 0, 32);
        assert!(0x1::string::length(arg0) <= 256, 33);
        assert!(0x1::string::length(arg1) <= 4096, 33);
    }

    fun assert_valid_proposer_threshold(arg0: u64) {
        assert!(arg0 >= 100000000000000 && arg0 <= 1000000000000000000, 22);
    }

    public fun can_claim_locked_tokens(arg0: &Proposal, arg1: address) : bool {
        arg0.status != 1 && 0x2::table::contains<address, VoteRecord>(&arg0.votes, arg1)
    }

    fun cast_vote(arg0: &mut Proposal, arg1: u8, arg2: 0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>, arg3: &0x2::tx_context::TxContext) {
        assert!(arg0.status == 1, 5);
        assert!(0x2::tx_context::epoch(arg3) < arg0.end_epoch, 14);
        let v0 = 0x2::coin::value<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&arg2);
        assert!(v0 > 100000000000, 20);
        let v1 = 0x2::tx_context::sender(arg3);
        assert!(!0x2::table::contains<address, VoteRecord>(&arg0.votes, v1), 6);
        if (arg1 == 1) {
            arg0.yes_votes = arg0.yes_votes + v0;
            0x2::balance::join<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&mut arg0.yes_locked_balance, 0x2::coin::into_balance<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(arg2));
        } else {
            assert!(arg1 == 2, 4);
            arg0.no_votes = arg0.no_votes + v0;
            0x2::balance::join<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&mut arg0.no_locked_balance, 0x2::coin::into_balance<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(arg2));
        };
        let v2 = VoteRecord{
            side         : arg1,
            voting_power : v0,
        };
        0x2::table::add<address, VoteRecord>(&mut arg0.votes, v1, v2);
        let v3 = VoteCastEvent{
            registry_id  : arg0.registry_id,
            proposal_id  : arg0.proposal_id,
            voter        : v1,
            side         : arg1,
            voting_power : v0,
        };
        0x2::event::emit<VoteCastEvent>(v3);
    }

    public fun claim_locked_tokens(arg0: &mut Proposal, arg1: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF> {
        assert_current_proposal(arg0);
        assert!(arg0.status != 1, 18);
        let v0 = 0x2::tx_context::sender(arg1);
        assert!(0x2::table::contains<address, VoteRecord>(&arg0.votes, v0), 19);
        let VoteRecord {
            side         : v1,
            voting_power : v2,
        } = 0x2::table::remove<address, VoteRecord>(&mut arg0.votes, v0);
        let v3 = if (v1 == 1) {
            0x2::balance::split<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&mut arg0.yes_locked_balance, v2)
        } else {
            assert!(v1 == 2, 4);
            0x2::balance::split<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&mut arg0.no_locked_balance, v2)
        };
        let v4 = VoteClaimedEvent{
            registry_id  : arg0.registry_id,
            proposal_id  : arg0.proposal_id,
            voter        : v0,
            side         : v1,
            voting_power : v2,
        };
        0x2::event::emit<VoteClaimedEvent>(v4);
        0x2::coin::from_balance<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(v3, arg1)
    }

    fun clear_active_proposal(arg0: &mut GovernanceConfig, arg1: u64) {
        if (0x1::option::is_some<u64>(&arg0.active_proposal_id)) {
            if (*0x1::option::borrow<u64>(&arg0.active_proposal_id) == arg1) {
                0x1::option::extract<u64>(&mut arg0.active_proposal_id);
            };
        };
    }

    public fun config_registry_id(arg0: &GovernanceConfig) : 0x2::object::ID {
        arg0.registry_id
    }

    public fun config_version(arg0: &GovernanceConfig) : u64 {
        arg0.version
    }

    public fun configured_proposal_duration_epochs(arg0: &GovernanceConfig) : u64 {
        arg0.proposal_duration_epochs
    }

    public fun consume_executable_proposal_action(arg0: &mut GovernanceConfig, arg1: &mut Proposal, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceActionExecutorCap, arg4: 0x2::object::ID, arg5: u8, arg6: &mut 0x2::tx_context::TxContext) : 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceActionTicket {
        assert_current_config(arg0);
        assert_current_proposal(arg1);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg2);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_action_executor_cap(arg2, arg3);
        assert_proposal_belongs_to_config(arg0, arg1);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::action_executor_cap_registry_id(arg3) == arg4, 13);
        assert!(arg1.registry_id == arg0.registry_id, 13);
        assert!(arg0.registry_id == arg4, 13);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg2) == arg4, 13);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::governance_config_id(arg2) == 0x2::object::id<GovernanceConfig>(arg0), 13);
        assert!(arg1.proposal_type == 1, 10);
        assert!(arg1.status == 2, 9);
        assert!(!arg1.executed, 11);
        assert!(arg1.action_type == arg5, 4);
        let v0 = if (arg5 == 2) {
            true
        } else if (arg5 == 9) {
            true
        } else if (arg5 == 10) {
            true
        } else {
            arg5 == 11
        };
        assert!(v0, 4);
        assert!(0x2::tx_context::epoch(arg6) <= execution_expiry_epoch(arg1), 26);
        arg1.executed = true;
        arg1.status = 4;
        let v1 = ProposalExecutedEvent{
            registry_id : arg1.registry_id,
            proposal_id : arg1.proposal_id,
            action_type : arg1.action_type,
            executed_by : 0x2::tx_context::sender(arg6),
        };
        0x2::event::emit<ProposalExecutedEvent>(v1);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::new_action_ticket(arg4, arg1.action_type, arg1.payload_u64_1, arg1.payload_u64_2, 0x2::tx_context::sender(arg6))
    }

    public fun create_proposal(arg0: &mut GovernanceConfig, arg1: u8, arg2: u8, arg3: 0x1::string::String, arg4: 0x1::string::String, arg5: u64, arg6: u64, arg7: address, arg8: 0x1::option::Option<0x2::object::ID>, arg9: vector<u8>, arg10: 0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>, arg11: &mut 0x2::tx_context::TxContext) : u64 {
        assert_current_config(arg0);
        assert!(!arg0.proposal_creation_paused, 2);
        assert!(0x1::option::is_none<u64>(&arg0.active_proposal_id), 17);
        assert_valid_proposal_text(&arg3, &arg4);
        assert_valid_proposal_action_pair(arg1, arg2);
        assert_action_enabled(arg0, arg2);
        assert_valid_proposal_payload(arg1, arg2, arg5, arg6, arg7);
        let v0 = 0x2::tx_context::sender(arg11);
        let v1 = 0x2::coin::value<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&arg10);
        assert!(v1 >= arg0.proposer_threshold, 21);
        let v2 = arg0.next_proposal_id;
        arg0.next_proposal_id = v2 + 1;
        let v3 = 0x2::tx_context::epoch(arg11);
        let v4 = Proposal{
            id                 : 0x2::object::new(arg11),
            version            : 1,
            registry_id        : arg0.registry_id,
            proposal_id        : v2,
            proposer           : v0,
            proposal_type      : arg1,
            action_type        : arg2,
            title              : arg3,
            description        : arg4,
            payload_u64_1      : arg5,
            payload_u64_2      : arg6,
            payload_address    : arg7,
            payload_object_id  : arg8,
            payload_bytes      : arg9,
            yes_votes          : v1,
            no_votes           : 0,
            yes_locked_balance : 0x2::balance::zero<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(),
            no_locked_balance  : 0x2::balance::zero<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(),
            start_epoch        : v3,
            end_epoch          : v3 + arg0.proposal_duration_epochs,
            status             : 1,
            executed           : false,
            votes              : 0x2::table::new<address, VoteRecord>(arg11),
        };
        0x2::balance::join<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&mut v4.yes_locked_balance, 0x2::coin::into_balance<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(arg10));
        let v5 = VoteRecord{
            side         : 1,
            voting_power : v1,
        };
        0x2::table::add<address, VoteRecord>(&mut v4.votes, v0, v5);
        let v6 = 0x2::object::id<Proposal>(&v4);
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.proposal_id_to_object, v2, v6);
        0x1::option::fill<u64>(&mut arg0.active_proposal_id, v2);
        let v7 = ProposalCreatedEvent{
            registry_id        : arg0.registry_id,
            proposal_id        : v2,
            proposer           : v0,
            proposal_type      : arg1,
            action_type        : arg2,
            proposal_object_id : v6,
            proposer_stake     : v1,
        };
        0x2::event::emit<ProposalCreatedEvent>(v7);
        let v8 = VoteCastEvent{
            registry_id  : arg0.registry_id,
            proposal_id  : v2,
            voter        : v0,
            side         : 1,
            voting_power : v1,
        };
        0x2::event::emit<VoteCastEvent>(v8);
        0x2::transfer::share_object<Proposal>(v4);
        v2
    }

    public fun current_config_version() : u64 {
        1
    }

    public fun current_proposal_version() : u64 {
        1
    }

    fun default_enabled_actions(arg0: &mut 0x2::tx_context::TxContext) : 0x2::table::Table<u8, bool> {
        let v0 = 0x2::table::new<u8, bool>(arg0);
        0x2::table::add<u8, bool>(&mut v0, 2, true);
        0x2::table::add<u8, bool>(&mut v0, 3, true);
        0x2::table::add<u8, bool>(&mut v0, 4, true);
        0x2::table::add<u8, bool>(&mut v0, 5, true);
        0x2::table::add<u8, bool>(&mut v0, 6, true);
        0x2::table::add<u8, bool>(&mut v0, 7, true);
        0x2::table::add<u8, bool>(&mut v0, 8, true);
        0x2::table::add<u8, bool>(&mut v0, 9, true);
        0x2::table::add<u8, bool>(&mut v0, 10, true);
        0x2::table::add<u8, bool>(&mut v0, 11, true);
        0x2::table::add<u8, bool>(&mut v0, 12, true);
        0x2::table::add<u8, bool>(&mut v0, 13, true);
        0x2::table::add<u8, bool>(&mut v0, 14, true);
        0x2::table::add<u8, bool>(&mut v0, 15, true);
        0x2::table::add<u8, bool>(&mut v0, 101, true);
        0x2::table::add<u8, bool>(&mut v0, 102, true);
        0x2::table::add<u8, bool>(&mut v0, 103, true);
        v0
    }

    public fun default_proposal_duration_epochs() : u64 {
        1
    }

    fun deterministic_fail(arg0: &GovernanceConfig, arg1: &Proposal, arg2: u64) : bool {
        !passage_rule_satisfied(arg0, arg1.yes_votes + arg2, arg1.no_votes)
    }

    fun deterministic_pass(arg0: &GovernanceConfig, arg1: &Proposal, arg2: u64) : bool {
        passage_rule_satisfied(arg0, arg1.yes_votes, arg1.no_votes + arg2)
    }

    public fun execute_cancel_operator_transfer_proposal(arg0: &mut GovernanceConfig, arg1: &mut Proposal, arg2: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: 0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::PendingOwnershipTransfer<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::OperatorPermit>, arg4: 0x2::transfer::Receiving<0xa031c162f9982ee32b199b98fbfbb6561051f2c4d2e17d358b09beafc20ce45::two_step_transfer::TwoStepTransferWrapper<0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::OperatorPermit>>, arg5: &mut 0x2::tx_context::TxContext) {
        assert_current_config(arg0);
        assert_current_proposal(arg1);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg2);
        assert_proposal_belongs_to_config(arg0, arg1);
        assert!(arg1.registry_id == arg0.registry_id, 13);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg2) == arg0.registry_id, 13);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::governance_config_id(arg2) == 0x2::object::id<GovernanceConfig>(arg0), 13);
        assert!(arg1.proposal_type == 1, 10);
        assert!(arg1.status == 2, 9);
        assert!(!arg1.executed, 11);
        assert!(arg1.action_type == 14, 4);
        assert!(0x2::tx_context::epoch(arg5) <= execution_expiry_epoch(arg1), 26);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::cancel_operator_transfer_from_vote(arg2, arg3, arg4, arg5);
        arg1.executed = true;
        arg1.status = 4;
        let v0 = ProposalExecutedEvent{
            registry_id : arg1.registry_id,
            proposal_id : arg1.proposal_id,
            action_type : arg1.action_type,
            executed_by : 0x2::tx_context::sender(arg5),
        };
        0x2::event::emit<ProposalExecutedEvent>(v0);
    }

    public fun execute_comments_fee_level_proposal(arg0: &mut GovernanceConfig, arg1: &mut Proposal, arg2: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceActionExecutorCap, arg4: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::FeeManager, arg5: &mut 0x2::tx_context::TxContext) {
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::apply_comments_fee_level_from_ticket(arg2, arg4, consume_executable_proposal_action(arg0, arg1, arg2, arg3, 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg2), 2, arg5));
    }

    public fun execute_proposal(arg0: &mut GovernanceConfig, arg1: &mut Proposal, arg2: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg3: &mut 0x2::tx_context::TxContext) {
        assert_current_config(arg0);
        assert_current_proposal(arg1);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg2);
        assert_proposal_belongs_to_config(arg0, arg1);
        assert!(arg1.registry_id == arg0.registry_id, 13);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg2) == arg0.registry_id, 13);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::governance_config_id(arg2) == 0x2::object::id<GovernanceConfig>(arg0), 13);
        assert!(arg1.proposal_type == 1, 10);
        assert!(arg1.status == 2, 9);
        assert!(!arg1.executed, 11);
        let v0 = 0x2::tx_context::epoch(arg3);
        if (v0 > execution_expiry_epoch(arg1)) {
            expire_proposal_internal(arg1, v0);
            return
        };
        if (arg1.action_type == 3) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::apply_fee_recipient(arg2, arg1.payload_address, 0x2::tx_context::sender(arg3));
        } else if (arg1.action_type == 4) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::nominate_operator_from_vote(arg2, arg1.payload_address, arg3);
        } else if (arg1.action_type == 5) {
            assert!(arg1.payload_u64_1 == 0 || arg1.payload_u64_1 == 1, 12);
            arg0.proposal_creation_paused = arg1.payload_u64_1 == 1;
            let v1 = ProposalCreationPausedChangedEvent{
                registry_id : arg0.registry_id,
                changed_by  : 0x2::tx_context::sender(arg3),
                old_paused  : arg0.proposal_creation_paused,
                paused      : arg0.proposal_creation_paused,
            };
            0x2::event::emit<ProposalCreationPausedChangedEvent>(v1);
        } else if (arg1.action_type == 6) {
            assert_valid_proposer_threshold(arg1.payload_u64_1);
            arg0.proposer_threshold = arg1.payload_u64_1;
            let v2 = ProposerThresholdChangedEvent{
                registry_id   : arg0.registry_id,
                changed_by    : 0x2::tx_context::sender(arg3),
                old_threshold : arg0.proposer_threshold,
                new_threshold : arg0.proposer_threshold,
            };
            0x2::event::emit<ProposerThresholdChangedEvent>(v2);
        } else if (arg1.action_type == 7) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::apply_upgrade_authority(arg2, arg1.payload_address, 0x2::tx_context::sender(arg3));
        } else if (arg1.action_type == 8) {
            assert_valid_proposal_duration_epochs(arg1.payload_u64_1);
            arg0.proposal_duration_epochs = arg1.payload_u64_1;
            let v3 = ProposalDurationChangedEvent{
                registry_id         : arg0.registry_id,
                changed_by          : 0x2::tx_context::sender(arg3),
                old_duration_epochs : arg0.proposal_duration_epochs,
                new_duration_epochs : arg0.proposal_duration_epochs,
            };
            0x2::event::emit<ProposalDurationChangedEvent>(v3);
        } else if (arg1.action_type == 12) {
            let v4 = (arg1.payload_u64_1 as u8);
            assert_valid_action_enable_target(v4);
            assert!(arg1.payload_u64_2 == 0 || arg1.payload_u64_2 == 1, 12);
            apply_action_enabled(arg0, v4, arg1.payload_u64_2 == 1, 0x2::tx_context::sender(arg3));
        } else if (arg1.action_type == 13) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::apply_direct_authority_mode_from_vote(arg2, (arg1.payload_u64_1 as u8), 0x2::tx_context::sender(arg3));
        } else if (arg1.action_type == 15) {
            0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::apply_governance_authority(arg2, arg1.payload_address, 0x2::tx_context::sender(arg3));
        } else {
            assert!(arg1.action_type == 14, 4);
            abort 4
        };
        arg1.executed = true;
        arg1.status = 4;
        let v5 = ProposalExecutedEvent{
            registry_id : arg1.registry_id,
            proposal_id : arg1.proposal_id,
            action_type : arg1.action_type,
            executed_by : 0x2::tx_context::sender(arg3),
        };
        0x2::event::emit<ProposalExecutedEvent>(v5);
    }

    public fun execution_expiry_epoch(arg0: &Proposal) : u64 {
        arg0.end_epoch + 3
    }

    public fun execution_validity_epochs() : u64 {
        3
    }

    public fun expire_passed_proposal(arg0: &mut Proposal, arg1: &0x2::tx_context::TxContext) {
        assert_current_proposal(arg0);
        assert!(arg0.proposal_type == 1, 10);
        assert!(arg0.status == 2, 9);
        assert!(!arg0.executed, 11);
        let v0 = 0x2::tx_context::epoch(arg1);
        assert!(v0 > execution_expiry_epoch(arg0), 26);
        expire_proposal_internal(arg0, v0);
    }

    fun expire_proposal_internal(arg0: &mut Proposal, arg1: u64) {
        arg0.status = 5;
        arg0.executed = false;
        let v0 = ProposalExpiredEvent{
            registry_id      : arg0.registry_id,
            proposal_id      : arg0.proposal_id,
            expired_at_epoch : arg1,
        };
        0x2::event::emit<ProposalExpiredEvent>(v0);
    }

    fun finalize_active_proposal(arg0: &mut GovernanceConfig, arg1: &mut Proposal) {
        if (passage_rule_satisfied(arg0, arg1.yes_votes, arg1.no_votes)) {
            arg1.status = 2;
        } else {
            arg1.status = 3;
        };
        clear_active_proposal(arg0, arg1.proposal_id);
        let v0 = ProposalFinalizedEvent{
            registry_id : arg1.registry_id,
            proposal_id : arg1.proposal_id,
            yes_votes   : arg1.yes_votes,
            no_votes    : arg1.no_votes,
            status      : arg1.status,
        };
        0x2::event::emit<ProposalFinalizedEvent>(v0);
    }

    public fun finalize_proposal(arg0: &mut GovernanceConfig, arg1: &mut Proposal, arg2: &0x2::tx_context::TxContext) {
        assert_current_config(arg0);
        assert_current_proposal(arg1);
        assert_proposal_belongs_to_config(arg0, arg1);
        assert!(arg1.status == 1, 8);
        assert!(arg1.registry_id == arg0.registry_id, 13);
        assert!(0x2::tx_context::epoch(arg2) >= arg1.end_epoch, 7);
        finalize_active_proposal(arg0, arg1);
    }

    public fun has_voted(arg0: &Proposal, arg1: address) : bool {
        0x2::table::contains<address, VoteRecord>(&arg0.votes, arg1)
    }

    public fun is_proposal_executable(arg0: &Proposal) : bool {
        if (arg0.proposal_type == 1) {
            if (arg0.status == 2) {
                !arg0.executed
            } else {
                false
            }
        } else {
            false
        }
    }

    public fun maximum_proposal_duration_epochs() : u64 {
        14
    }

    public fun maximum_proposer_threshold() : u64 {
        1000000000000000000
    }

    public fun migrate_config(arg0: &mut GovernanceConfig, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &0x2::tx_context::TxContext) {
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg1);
        assert!(arg0.registry_id == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg1), 13);
        assert!(0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::governance_config_id(arg1) == 0x2::object::id<GovernanceConfig>(arg0), 13);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_upgrade_authority(arg1, 0x2::tx_context::sender(arg2));
        migrate_config_version(arg0);
        if (!0x2::table::contains<u8, bool>(&arg0.enabled_actions, 15)) {
            0x2::table::add<u8, bool>(&mut arg0.enabled_actions, 15, true);
        };
        let v0 = GovernanceConfigMigratedEvent{
            registry_id : arg0.registry_id,
            migrated_by : 0x2::tx_context::sender(arg2),
            new_version : arg0.version,
        };
        0x2::event::emit<GovernanceConfigMigratedEvent>(v0);
    }

    fun migrate_config_version(arg0: &mut GovernanceConfig) {
        assert!(arg0.version <= 1, 23);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun migrate_proposal(arg0: &mut Proposal, arg1: &0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg2: &0x2::tx_context::TxContext) {
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg1);
        assert!(arg0.registry_id == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg1), 13);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_upgrade_authority(arg1, 0x2::tx_context::sender(arg2));
        migrate_proposal_version(arg0);
        let v0 = ProposalMigratedEvent{
            proposal_id : arg0.proposal_id,
            registry_id : arg0.registry_id,
            migrated_by : 0x2::tx_context::sender(arg2),
            new_version : arg0.version,
        };
        0x2::event::emit<ProposalMigratedEvent>(v0);
    }

    fun migrate_proposal_version(arg0: &mut Proposal) {
        assert!(arg0.version <= 1, 24);
        if (arg0.version < 1) {
            arg0.version = 1;
        };
    }

    public fun minimum_proposal_duration_epochs() : u64 {
        7
    }

    public fun minimum_proposer_threshold() : u64 {
        100000000000000
    }

    public fun minimum_vote_stake() : u64 {
        100000000000
    }

    public fun new_governance_config(arg0: &mut 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::GovernanceVault, arg1: &mut 0x2::tx_context::TxContext) : GovernanceConfig {
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::assert_current_vault(arg0);
        assert!(0x2::tx_context::sender(arg1) == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::governance_authority(arg0) || 0x2::tx_context::sender(arg1) == 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::upgrade_authority(arg0), 30);
        let v0 = 0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::total_supply_base_units();
        assert!(v0 > 0, 1);
        let v1 = default_enabled_actions(arg1);
        let v2 = 0x2::object::new(arg1);
        0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::bind_governance_config(arg0, *0x2::object::uid_as_inner(&v2), arg1);
        GovernanceConfig{
            id                       : v2,
            version                  : 1,
            registry_id              : 0x75923624e354789e995537e88afaab698bd405a61f91926e3f8837fb7cc6b5cf::governance::registry_id(arg0),
            pprf_total_supply        : v0,
            proposer_threshold       : 10000000000000000,
            proposal_duration_epochs : 1,
            next_proposal_id         : 1,
            proposal_creation_paused : false,
            active_proposal_id       : 0x1::option::none<u64>(),
            proposal_id_to_object    : 0x2::table::new<u64, 0x2::object::ID>(arg1),
            enabled_actions          : v1,
        }
    }

    public fun next_proposal_id(arg0: &GovernanceConfig) : u64 {
        arg0.next_proposal_id
    }

    public fun no_locked_value(arg0: &Proposal) : u64 {
        0x2::balance::value<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&arg0.no_locked_balance)
    }

    public fun no_votes(arg0: &Proposal) : u64 {
        arg0.no_votes
    }

    public fun outcome_determinable(arg0: &GovernanceConfig, arg1: &Proposal) : bool {
        let v0 = remaining_voting_supply(arg0, arg1);
        deterministic_pass(arg0, arg1, v0) || deterministic_fail(arg0, arg1, v0)
    }

    fun passage_rule_satisfied(arg0: &GovernanceConfig, arg1: u64, arg2: u64) : bool {
        let v0 = (arg1 as u128);
        v0 * 3 >= (arg2 as u128) * 4 && v0 * 10 > (arg0.pprf_total_supply as u128)
    }

    public fun proposal_creation_paused(arg0: &GovernanceConfig) : bool {
        arg0.proposal_creation_paused
    }

    public fun proposal_end_epoch(arg0: &Proposal) : u64 {
        arg0.end_epoch
    }

    public fun proposal_executed(arg0: &Proposal) : bool {
        arg0.executed
    }

    public fun proposal_id(arg0: &Proposal) : u64 {
        arg0.proposal_id
    }

    public fun proposal_object_id(arg0: &GovernanceConfig, arg1: u64) : 0x2::object::ID {
        *0x2::table::borrow<u64, 0x2::object::ID>(&arg0.proposal_id_to_object, arg1)
    }

    public fun proposal_start_epoch(arg0: &Proposal) : u64 {
        arg0.start_epoch
    }

    public fun proposal_status(arg0: &Proposal) : u8 {
        arg0.status
    }

    public fun proposal_status_active() : u8 {
        1
    }

    public fun proposal_status_executed() : u8 {
        4
    }

    public fun proposal_status_expired() : u8 {
        5
    }

    public fun proposal_status_passed() : u8 {
        2
    }

    public fun proposal_status_rejected() : u8 {
        3
    }

    public fun proposal_type(arg0: &Proposal) : u8 {
        arg0.proposal_type
    }

    public fun proposal_type_executable() : u8 {
        1
    }

    public fun proposal_type_signal() : u8 {
        2
    }

    public fun proposal_version(arg0: &Proposal) : u64 {
        arg0.version
    }

    public fun proposer_threshold(arg0: &GovernanceConfig) : u64 {
        arg0.proposer_threshold
    }

    public fun remaining_voting_supply(arg0: &GovernanceConfig, arg1: &Proposal) : u64 {
        arg0.pprf_total_supply - arg1.yes_votes - arg1.no_votes
    }

    public fun resolve_proposal_early(arg0: &mut GovernanceConfig, arg1: &mut Proposal) {
        assert_current_config(arg0);
        assert_current_proposal(arg1);
        assert_proposal_belongs_to_config(arg0, arg1);
        assert!(arg1.status == 1, 8);
        assert!(arg1.registry_id == arg0.registry_id, 13);
        assert!(outcome_determinable(arg0, arg1), 27);
        finalize_active_proposal(arg0, arg1);
    }

    public fun share_governance_config(arg0: GovernanceConfig) {
        0x2::transfer::share_object<GovernanceConfig>(arg0);
    }

    public fun total_supply(arg0: &GovernanceConfig) : u64 {
        arg0.pprf_total_supply
    }

    public fun vote_no(arg0: &mut Proposal, arg1: 0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>, arg2: &0x2::tx_context::TxContext) {
        assert_current_proposal(arg0);
        cast_vote(arg0, 2, arg1, arg2);
    }

    public fun vote_power_of(arg0: &Proposal, arg1: address) : u64 {
        if (0x2::table::contains<address, VoteRecord>(&arg0.votes, arg1)) {
            0x2::table::borrow<address, VoteRecord>(&arg0.votes, arg1).voting_power
        } else {
            0
        }
    }

    public fun vote_yes(arg0: &mut Proposal, arg1: 0x2::coin::Coin<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>, arg2: &0x2::tx_context::TxContext) {
        assert_current_proposal(arg0);
        cast_vote(arg0, 1, arg1, arg2);
    }

    public fun yes_locked_value(arg0: &Proposal) : u64 {
        0x2::balance::value<0x5d2ec9829a9e116de7c2008281a90b96690beb2252af120ad05a25fe13fae0da::pprf::PPRF>(&arg0.yes_locked_balance)
    }

    public fun yes_votes(arg0: &Proposal) : u64 {
        arg0.yes_votes
    }

    // decompiled from Move bytecode v7
}

