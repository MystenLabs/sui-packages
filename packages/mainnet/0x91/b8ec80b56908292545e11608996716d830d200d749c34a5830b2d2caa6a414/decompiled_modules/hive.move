module 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::hive {
    struct Hive has store, key {
        id: 0x2::object::UID,
        name: vector<u8>,
        description: vector<u8>,
        members: 0x2::table::Table<address, MemberRecord>,
        total_weight: u64,
        member_count: u64,
        treasury: 0x2::balance::Balance<0x2::sui::SUI>,
        shared_memory_vault: 0x1::option::Option<0x2::object::ID>,
        shared_signer: 0x1::option::Option<0x2::object::ID>,
        governance_params: 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::GovernanceParams,
        treasury_config: 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::TreasuryConfig,
        active_proposals: u64,
        collective_reputation: u64,
        bls_public_key: vector<u8>,
        created_at: u64,
        total_proposals: u64,
        total_spent: u64,
    }

    struct MemberRecord has store {
        agent_id: 0x1::option::Option<0x2::object::ID>,
        weight: u64,
        joined_at: u64,
        contributions: u64,
        bls_key_info: 0x1::option::Option<0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::BlsKeyInfo>,
        status: u8,
        stake: u64,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        hive_id: 0x2::object::ID,
        proposer: address,
        action_type: u8,
        action_data: vector<u8>,
        description: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        voters: 0x2::table::Table<address, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::Vote>,
        created_at: u64,
        voting_ends: u64,
        executable_after: u64,
        status: u8,
        bond: 0x2::balance::Balance<0x2::sui::SUI>,
    }

    struct ThresholdSignRequest has store, key {
        id: 0x2::object::UID,
        hive_id: 0x2::object::ID,
        message_hash: vector<u8>,
        required_weight: u64,
        partials: 0x2::table::Table<address, vector<u8>>,
        accumulated_weight: u64,
        signer_count: u64,
        aggregated_signature: 0x1::option::Option<vector<u8>>,
        created_at: u64,
        expires_at: u64,
    }

    struct MembershipCap has store, key {
        id: 0x2::object::UID,
        hive_id: 0x2::object::ID,
        member: address,
    }

    public fun active_proposals(arg0: &Hive) : u64 {
        arg0.active_proposals
    }

    public fun aggregate_signatures(arg0: &Hive, arg1: &mut ThresholdSignRequest, arg2: vector<u8>, arg3: &0x2::clock::Clock) {
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(arg1.accumulated_weight >= arg1.required_weight, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::signature_threshold_not_reached());
        assert!(0x1::option::is_none<vector<u8>>(&arg1.aggregated_signature), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::already_completed());
        assert!(0x1::vector::length<u8>(&arg2) == 96, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::invalid_aggregated_signature());
        if (!0x1::vector::is_empty<u8>(&arg0.bls_public_key)) {
            assert!(0x2::bls12381::bls12381_min_sig_verify(&arg2, &arg0.bls_public_key, &arg1.message_hash), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::invalid_aggregated_signature());
        };
        arg1.aggregated_signature = 0x1::option::some<vector<u8>>(arg2);
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_signature_aggregated(0x2::object::id<Hive>(arg0), 0x2::object::id<ThresholdSignRequest>(arg1), arg1.accumulated_weight, arg1.signer_count, 0x2::clock::timestamp_ms(arg3));
    }

    fun calculate_weight_from_stake(arg0: u64) : u64 {
        arg0 / 100000000
    }

    public fun collective_reputation(arg0: &Hive) : u64 {
        arg0.collective_reputation
    }

    public fun create_hive(arg0: vector<u8>, arg1: vector<u8>, arg2: 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::GovernanceParams, arg3: 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::TreasuryConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : (Hive, MembershipCap) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = Hive{
            id                    : 0x2::object::new(arg6),
            name                  : arg0,
            description           : arg1,
            members               : 0x2::table::new<address, MemberRecord>(arg6),
            total_weight          : 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::default_member_weight(),
            member_count          : 1,
            treasury              : 0x2::coin::into_balance<0x2::sui::SUI>(arg4),
            shared_memory_vault   : 0x1::option::none<0x2::object::ID>(),
            shared_signer         : 0x1::option::none<0x2::object::ID>(),
            governance_params     : arg2,
            treasury_config       : arg3,
            active_proposals      : 0,
            collective_reputation : 0,
            bls_public_key        : 0x1::vector::empty<u8>(),
            created_at            : v0,
            total_proposals       : 0,
            total_spent           : 0,
        };
        let v3 = 0x2::object::id<Hive>(&v2);
        let v4 = MemberRecord{
            agent_id      : 0x1::option::none<0x2::object::ID>(),
            weight        : 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::default_member_weight(),
            joined_at     : v0,
            contributions : 0,
            bls_key_info  : 0x1::option::none<0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::BlsKeyInfo>(),
            status        : 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::member_status_active(),
            stake         : 0x2::coin::value<0x2::sui::SUI>(&arg4),
        };
        0x2::table::add<address, MemberRecord>(&mut v2.members, v1, v4);
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_hive_created(v3, arg0, v1, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::params_decision_threshold(&arg2), v0);
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_member_joined(v3, v1, 0x1::option::none<0x2::object::ID>(), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::default_member_weight(), v0);
        let v5 = MembershipCap{
            id      : 0x2::object::new(arg6),
            hive_id : v3,
            member  : v1,
        };
        (v2, v5)
    }

    public fun create_proposal(arg0: &mut Hive, arg1: &MembershipCap, arg2: u8, arg3: vector<u8>, arg4: vector<u8>, arg5: 0x2::coin::Coin<0x2::sui::SUI>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) : Proposal {
        let v0 = 0x2::clock::timestamp_ms(arg6);
        let v1 = 0x2::tx_context::sender(arg7);
        assert!(arg1.member == v1, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_authorized());
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(0x2::table::contains<address, MemberRecord>(&arg0.members, v1), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_member());
        assert!(0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::is_member_active(0x2::table::borrow<address, MemberRecord>(&arg0.members, v1).status), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::membership_suspended());
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg5) >= 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::params_proposal_bond(&arg0.governance_params), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::insufficient_proposal_bond());
        let v2 = 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::params_voting_period(&arg0.governance_params);
        let v3 = Proposal{
            id               : 0x2::object::new(arg7),
            hive_id          : 0x2::object::id<Hive>(arg0),
            proposer         : v1,
            action_type      : arg2,
            action_data      : arg3,
            description      : arg4,
            votes_for        : 0,
            votes_against    : 0,
            voters           : 0x2::table::new<address, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::Vote>(arg7),
            created_at       : v0,
            voting_ends      : v0 + v2,
            executable_after : v0 + v2 + 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::params_execution_delay(&arg0.governance_params),
            status           : 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::proposal_status_active(),
            bond             : 0x2::coin::into_balance<0x2::sui::SUI>(arg5),
        };
        arg0.active_proposals = arg0.active_proposals + 1;
        arg0.total_proposals = arg0.total_proposals + 1;
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_proposal_created(0x2::object::id<Hive>(arg0), 0x2::object::id<Proposal>(&v3), v1, arg2, v3.voting_ends, v0);
        v3
    }

    public fun create_signature_request(arg0: &Hive, arg1: &MembershipCap, arg2: vector<u8>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : ThresholdSignRequest {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        assert!(arg1.member == 0x2::tx_context::sender(arg4), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_authorized());
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(0x1::vector::length<u8>(&arg2) == 32, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::invalid_amount());
        let v1 = arg0.total_weight * (0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::params_decision_threshold(&arg0.governance_params) as u64) / 10000;
        let v2 = ThresholdSignRequest{
            id                   : 0x2::object::new(arg4),
            hive_id              : 0x2::object::id<Hive>(arg0),
            message_hash         : arg2,
            required_weight      : v1,
            partials             : 0x2::table::new<address, vector<u8>>(arg4),
            accumulated_weight   : 0,
            signer_count         : 0,
            aggregated_signature : 0x1::option::none<vector<u8>>(),
            created_at           : v0,
            expires_at           : v0 + 3600000,
        };
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_signature_request_created(0x2::object::id<Hive>(arg0), 0x2::object::id<ThresholdSignRequest>(&v2), arg2, v1, v0);
        v2
    }

    public fun deposit_to_treasury(arg0: &mut Hive, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_treasury_deposit(0x2::object::id<Hive>(arg0), 0x2::tx_context::sender(arg3), 0x2::coin::value<0x2::sui::SUI>(&arg1), 0x2::balance::value<0x2::sui::SUI>(&arg0.treasury), 0x2::clock::timestamp_ms(arg2));
    }

    public fun execute_proposal(arg0: &mut Hive, arg1: &mut Proposal, arg2: &0x2::clock::Clock, arg3: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::is_proposal_passed(arg1.status), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::proposal_not_passed());
        assert!(v0 >= arg1.executable_after, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::invalid_timestamp());
        arg1.status = 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::proposal_status_executed();
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_proposal_executed(0x2::object::id<Hive>(arg0), 0x2::object::id<Proposal>(arg1), 0x2::tx_context::sender(arg3), v0);
    }

    public fun finalize_proposal(arg0: &mut Hive, arg1: &mut Proposal, arg2: &0x2::clock::Clock) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::is_proposal_active(arg1.status), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::invalid_status());
        assert!(v0 >= arg1.voting_ends, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::voting_period_not_ended());
        if (arg1.votes_for >= arg0.total_weight * (0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::params_decision_threshold(&arg0.governance_params) as u64) / 10000 && arg1.votes_for > arg1.votes_against) {
            arg1.status = 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::proposal_status_passed();
            0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_proposal_passed(0x2::object::id<Hive>(arg0), 0x2::object::id<Proposal>(arg1), arg1.votes_for, arg1.votes_against, v0);
        } else {
            arg1.status = 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::proposal_status_failed();
            0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_proposal_failed(0x2::object::id<Hive>(arg0), 0x2::object::id<Proposal>(arg1), arg1.votes_for, arg1.votes_against, v0);
        };
        arg0.active_proposals = arg0.active_proposals - 1;
    }

    public fun get_aggregated_signature(arg0: &ThresholdSignRequest) : &0x1::option::Option<vector<u8>> {
        &arg0.aggregated_signature
    }

    public fun get_member_weight(arg0: &Hive, arg1: address) : u64 {
        0x2::table::borrow<address, MemberRecord>(&arg0.members, arg1).weight
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
    }

    public fun is_member(arg0: &Hive, arg1: address) : bool {
        0x2::table::contains<address, MemberRecord>(&arg0.members, arg1)
    }

    public fun is_signature_complete(arg0: &ThresholdSignRequest) : bool {
        0x1::option::is_some<vector<u8>>(&arg0.aggregated_signature)
    }

    public fun join_hive(arg0: &mut Hive, arg1: 0x2::coin::Coin<0x2::sui::SUI>, arg2: 0x1::option::Option<0x2::object::ID>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : MembershipCap {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        let v2 = 0x2::coin::value<0x2::sui::SUI>(&arg1);
        assert!(!0x2::table::contains<address, MemberRecord>(&arg0.members, v1), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::already_member());
        assert!(arg0.member_count < 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::max_hive_members(), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::capacity_reached());
        let v3 = calculate_weight_from_stake(v2);
        let v4 = MemberRecord{
            agent_id      : arg2,
            weight        : v3,
            joined_at     : v0,
            contributions : 0,
            bls_key_info  : 0x1::option::none<0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::BlsKeyInfo>(),
            status        : 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::member_status_active(),
            stake         : v2,
        };
        0x2::table::add<address, MemberRecord>(&mut arg0.members, v1, v4);
        0x2::balance::join<0x2::sui::SUI>(&mut arg0.treasury, 0x2::coin::into_balance<0x2::sui::SUI>(arg1));
        arg0.total_weight = arg0.total_weight + v3;
        arg0.member_count = arg0.member_count + 1;
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_member_joined(0x2::object::id<Hive>(arg0), v1, arg2, v3, v0);
        MembershipCap{
            id      : 0x2::object::new(arg4),
            hive_id : 0x2::object::id<Hive>(arg0),
            member  : v1,
        }
    }

    public fun leave_hive(arg0: &mut Hive, arg1: MembershipCap, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<0x2::sui::SUI> {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(arg1.member == v0, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_authorized());
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(0x2::table::contains<address, MemberRecord>(&arg0.members, v0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_member());
        let v1 = 0x2::table::remove<address, MemberRecord>(&mut arg0.members, v0);
        arg0.total_weight = arg0.total_weight - v1.weight;
        arg0.member_count = arg0.member_count - 1;
        let MemberRecord {
            agent_id      : _,
            weight        : _,
            joined_at     : _,
            contributions : _,
            bls_key_info  : _,
            status        : _,
            stake         : v8,
        } = v1;
        let MembershipCap {
            id      : v9,
            hive_id : _,
            member  : _,
        } = arg1;
        0x2::object::delete(v9);
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_member_left(0x2::object::id<Hive>(arg0), v0, true, v8, 0x2::clock::timestamp_ms(arg2));
        0x2::coin::take<0x2::sui::SUI>(&mut arg0.treasury, v8, arg3)
    }

    public fun member_count(arg0: &Hive) : u64 {
        arg0.member_count
    }

    public fun proposal_status(arg0: &Proposal) : u8 {
        arg0.status
    }

    public fun proposal_votes(arg0: &Proposal) : (u64, u64) {
        (arg0.votes_for, arg0.votes_against)
    }

    public fun register_bls_key(arg0: &mut Hive, arg1: &MembershipCap, arg2: 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::BlsKeyInfo, arg3: &0x2::clock::Clock, arg4: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(arg1.member == v0, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_authorized());
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(0x2::table::contains<address, MemberRecord>(&arg0.members, v0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_member());
        let v1 = 0x2::table::borrow_mut<address, MemberRecord>(&mut arg0.members, v0);
        assert!(0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::is_member_active(v1.status), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::membership_suspended());
        let v2 = *0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::bls_public_key_share(&arg2);
        assert!(0x1::vector::length<u8>(&v2) == 48, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::invalid_key_share());
        v1.bls_key_info = 0x1::option::some<0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::BlsKeyInfo>(arg2);
        if (0x1::vector::is_empty<u8>(&arg0.bls_public_key)) {
            arg0.bls_public_key = v2;
        };
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_bls_key_registered(0x2::object::id<Hive>(arg0), v0, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::bls_share_index(&arg2), 0x2::clock::timestamp_ms(arg3));
    }

    public fun submit_partial_signature(arg0: &Hive, arg1: &mut ThresholdSignRequest, arg2: &MembershipCap, arg3: vector<u8>, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg4);
        let v1 = 0x2::tx_context::sender(arg5);
        assert!(arg2.member == v1, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_authorized());
        assert!(arg2.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(v0 < arg1.expires_at, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::signature_request_expired());
        assert!(!0x2::table::contains<address, vector<u8>>(&arg1.partials, v1), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::already_submitted_partial());
        assert!(0x1::option::is_none<vector<u8>>(&arg1.aggregated_signature), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::already_completed());
        let v2 = 0x2::table::borrow<address, MemberRecord>(&arg0.members, v1);
        assert!(0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::is_member_active(v2.status), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::membership_suspended());
        assert!(0x1::option::is_some<0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::BlsKeyInfo>(&v2.bls_key_info), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::bls_key_not_registered());
        assert!(0x1::vector::length<u8>(&arg3) == 96, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::invalid_partial_signature());
        0x2::table::add<address, vector<u8>>(&mut arg1.partials, v1, arg3);
        arg1.accumulated_weight = arg1.accumulated_weight + v2.weight;
        arg1.signer_count = arg1.signer_count + 1;
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_partial_signature_submitted(0x2::object::id<Hive>(arg0), 0x2::object::id<ThresholdSignRequest>(arg1), v1, v2.weight, arg1.accumulated_weight, v0);
    }

    public fun total_weight(arg0: &Hive) : u64 {
        arg0.total_weight
    }

    public fun treasury_balance(arg0: &Hive) : u64 {
        0x2::balance::value<0x2::sui::SUI>(&arg0.treasury)
    }

    public fun vote(arg0: &mut Hive, arg1: &mut Proposal, arg2: &MembershipCap, arg3: bool, arg4: vector<u8>, arg5: &0x2::clock::Clock, arg6: &0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg5);
        let v1 = 0x2::tx_context::sender(arg6);
        assert!(arg2.member == v1, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_authorized());
        assert!(arg2.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(arg1.hive_id == 0x2::object::id<Hive>(arg0), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_found());
        assert!(0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::is_proposal_active(arg1.status), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::invalid_status());
        assert!(v0 < arg1.voting_ends, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::voting_period_ended());
        assert!(!0x2::table::contains<address, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::Vote>(&arg1.voters, v1), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::already_voted());
        assert!(0x2::table::contains<address, MemberRecord>(&arg0.members, v1), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::not_member());
        let v2 = 0x2::table::borrow<address, MemberRecord>(&arg0.members, v1);
        assert!(0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::is_member_active(v2.status), 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::errors::membership_suspended());
        let v3 = v2.weight;
        0x2::table::add<address, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::Vote>(&mut arg1.voters, v1, 0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::types::new_vote(arg3, v3, arg4, v0));
        if (arg3) {
            arg1.votes_for = arg1.votes_for + v3;
        } else {
            arg1.votes_against = arg1.votes_against + v3;
        };
        0x91b8ec80b56908292545e11608996716d830d200d749c34a5830b2d2caa6a414::events::emit_vote_cast(0x2::object::id<Hive>(arg0), 0x2::object::id<Proposal>(arg1), v1, arg3, v3, v0);
    }

    // decompiled from Move bytecode v6
}

