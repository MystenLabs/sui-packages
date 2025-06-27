module 0xee538ee4fa58b4447852f40328962a61693fe7baea92c6240fac0f7970d06839::gfs_governance {
    struct GFS_GOVERNANCE has drop {
        dummy_field: bool,
    }

    struct GovernanceRegistry has key {
        id: 0x2::object::UID,
        treasury_cap: 0x2::coin::TreasuryCap<GFS_GOVERNANCE>,
        treasury_balance: 0x2::balance::Balance<GFS_GOVERNANCE>,
        total_staked: u64,
        total_voting_power: u64,
        proposal_count: u64,
        proposals: 0x2::table::Table<u64, address>,
        voters: 0x2::table::Table<address, VoterInfo>,
        admin: address,
        emergency_mode: bool,
    }

    struct VoterInfo has store {
        staked_amount: u64,
        voting_power: u64,
        lock_end_time: u64,
        delegation_target: 0x1::option::Option<address>,
        total_votes_cast: u64,
    }

    struct StakingPosition has store, key {
        id: 0x2::object::UID,
        owner: address,
        amount: u64,
        lock_end_time: u64,
        voting_power_multiplier: u64,
        created_at: u64,
    }

    struct Proposal has store, key {
        id: 0x2::object::UID,
        proposal_id: u64,
        proposer: address,
        title: 0x1::string::String,
        description: 0x1::string::String,
        proposal_type: u8,
        target_contract: 0x1::option::Option<address>,
        function_name: 0x1::option::Option<0x1::string::String>,
        parameters: 0x2::bag::Bag,
        voting_start: u64,
        voting_end: u64,
        execution_time: u64,
        yes_votes: u64,
        no_votes: u64,
        total_voting_power_snapshot: u64,
        status: u8,
        voters: 0x2::table::Table<address, bool>,
    }

    struct Vote has store, key {
        id: 0x2::object::UID,
        proposal_id: u64,
        voter: address,
        vote: bool,
        voting_power: u64,
        timestamp: u64,
    }

    struct TreasuryProposal has store, key {
        id: 0x2::object::UID,
        recipient: address,
        amount: u64,
        token_type: 0x1::string::String,
        purpose: 0x1::string::String,
    }

    struct TokensStaked has copy, drop {
        staker: address,
        amount: u64,
        lock_period: u64,
        voting_power: u64,
    }

    struct TokensUnstaked has copy, drop {
        staker: address,
        amount: u64,
        voting_power_lost: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        proposer: address,
        title: 0x1::string::String,
        proposal_type: u8,
        voting_end: u64,
    }

    struct VoteCast has copy, drop {
        proposal_id: u64,
        voter: address,
        vote: bool,
        voting_power: u64,
    }

    struct ProposalExecuted has copy, drop {
        proposal_id: u64,
        executor: address,
        execution_successful: bool,
    }

    struct DelegationChanged has copy, drop {
        delegator: address,
        old_delegate: 0x1::option::Option<address>,
        new_delegate: 0x1::option::Option<address>,
        voting_power: u64,
    }

    public entry fun create_proposal(arg0: &mut GovernanceRegistry, arg1: vector<u8>, arg2: vector<u8>, arg3: u8, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, VoterInfo>(&arg0.voters, v0), 6);
        assert!(0x2::table::borrow<address, VoterInfo>(&arg0.voters, v0).voting_power >= 1000000, 6);
        let v1 = 0x2::clock::timestamp_ms(arg4);
        let v2 = arg0.proposal_count;
        arg0.proposal_count = arg0.proposal_count + 1;
        let v3 = Proposal{
            id                          : 0x2::object::new(arg5),
            proposal_id                 : v2,
            proposer                    : v0,
            title                       : 0x1::string::utf8(arg1),
            description                 : 0x1::string::utf8(arg2),
            proposal_type               : arg3,
            target_contract             : 0x1::option::none<address>(),
            function_name               : 0x1::option::none<0x1::string::String>(),
            parameters                  : 0x2::bag::new(arg5),
            voting_start                : v1,
            voting_end                  : v1 + 604800000,
            execution_time              : v1 + 604800000 + 172800000,
            yes_votes                   : 0,
            no_votes                    : 0,
            total_voting_power_snapshot : arg0.total_voting_power,
            status                      : 0,
            voters                      : 0x2::table::new<address, bool>(arg5),
        };
        0x2::table::add<u64, address>(&mut arg0.proposals, v2, 0x2::object::uid_to_address(&v3.id));
        let v4 = ProposalCreated{
            proposal_id   : v2,
            proposer      : v0,
            title         : v3.title,
            proposal_type : arg3,
            voting_end    : v3.voting_end,
        };
        0x2::event::emit<ProposalCreated>(v4);
        0x2::transfer::share_object<Proposal>(v3);
    }

    public entry fun delegate_votes(arg0: &mut GovernanceRegistry, arg1: address, arg2: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg2);
        assert!(0x2::table::contains<address, VoterInfo>(&arg0.voters, v0), 6);
        let v1 = 0x2::table::borrow_mut<address, VoterInfo>(&mut arg0.voters, v0);
        v1.delegation_target = 0x1::option::some<address>(arg1);
        let v2 = DelegationChanged{
            delegator    : v0,
            old_delegate : v1.delegation_target,
            new_delegate : 0x1::option::some<address>(arg1),
            voting_power : v1.voting_power,
        };
        0x2::event::emit<DelegationChanged>(v2);
    }

    public entry fun execute_proposal(arg0: &mut GovernanceRegistry, arg1: &mut Proposal, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg2);
        assert!(v0 >= arg1.execution_time, 5);
        assert!(v0 <= arg1.execution_time + 259200000, 8);
        assert!(arg1.status == 0, 3);
        let v1 = arg1.yes_votes + arg1.no_votes;
        if (v1 * 10000 / arg1.total_voting_power_snapshot >= 4000 && arg1.yes_votes * 10000 / v1 >= 5100) {
            arg1.status = 1;
            let v2 = execute_proposal_action(arg0, arg1, arg3);
            if (v2) {
                arg1.status = 3;
            };
            let v3 = ProposalExecuted{
                proposal_id          : arg1.proposal_id,
                executor             : 0x2::tx_context::sender(arg3),
                execution_successful : v2,
            };
            0x2::event::emit<ProposalExecuted>(v3);
        } else {
            arg1.status = 2;
        };
    }

    fun execute_proposal_action(arg0: &mut GovernanceRegistry, arg1: &Proposal, arg2: &mut 0x2::tx_context::TxContext) : bool {
        if (arg1.proposal_type == 2) {
            true
        } else if (arg1.proposal_type == 1) {
            true
        } else if (arg1.proposal_type == 4) {
            arg0.emergency_mode = true;
            true
        } else {
            false
        }
    }

    public fun get_governance_stats(arg0: &GovernanceRegistry) : (u64, u64, u64, bool) {
        (arg0.total_staked, arg0.total_voting_power, arg0.proposal_count, arg0.emergency_mode)
    }

    public fun get_proposal_status(arg0: &Proposal) : (u64, u64, u64, u8) {
        (arg0.yes_votes, arg0.no_votes, arg0.total_voting_power_snapshot, arg0.status)
    }

    public fun get_voter_info(arg0: &GovernanceRegistry, arg1: address) : (u64, u64, u64) {
        if (0x2::table::contains<address, VoterInfo>(&arg0.voters, arg1)) {
            let v3 = 0x2::table::borrow<address, VoterInfo>(&arg0.voters, arg1);
            (v3.staked_amount, v3.voting_power, v3.lock_end_time)
        } else {
            (0, 0, 0)
        }
    }

    fun init(arg0: GFS_GOVERNANCE, arg1: &mut 0x2::tx_context::TxContext) {
        let (v0, v1) = 0x2::coin::create_currency<GFS_GOVERNANCE>(arg0, 9, b"GFS", b"Gas Futures Governance Token", b"Governance token for Gas Futures Platform", 0x1::option::none<0x2::url::Url>(), arg1);
        let v2 = GovernanceRegistry{
            id                 : 0x2::object::new(arg1),
            treasury_cap       : v0,
            treasury_balance   : 0x2::balance::zero<GFS_GOVERNANCE>(),
            total_staked       : 0,
            total_voting_power : 0,
            proposal_count     : 0,
            proposals          : 0x2::table::new<u64, address>(arg1),
            voters             : 0x2::table::new<address, VoterInfo>(arg1),
            admin              : 0x2::tx_context::sender(arg1),
            emergency_mode     : false,
        };
        0x2::transfer::public_freeze_object<0x2::coin::CoinMetadata<GFS_GOVERNANCE>>(v1);
        0x2::transfer::share_object<GovernanceRegistry>(v2);
    }

    public entry fun mint_tokens(arg0: &mut GovernanceRegistry, arg1: u64, arg2: address, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg0.admin == 0x2::tx_context::sender(arg3), 1);
        0x2::transfer::public_transfer<0x2::coin::Coin<GFS_GOVERNANCE>>(0x2::coin::mint<GFS_GOVERNANCE>(&mut arg0.treasury_cap, arg1, arg3), arg2);
    }

    public entry fun stake_tokens(arg0: &mut GovernanceRegistry, arg1: 0x2::coin::Coin<GFS_GOVERNANCE>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::coin::value<GFS_GOVERNANCE>(&arg1);
        let v1 = 0x2::clock::timestamp_ms(arg3);
        let (v2, v3) = if (arg2 == 3) {
            (v1 + 7776000000, 1000)
        } else if (arg2 == 6) {
            (v1 + 15552000000, 1500)
        } else if (arg2 == 12) {
            (v1 + 31104000000, 2000)
        } else {
            (v1, 1000)
        };
        let v4 = v0 * v3 / 1000;
        let v5 = 0x2::tx_context::sender(arg4);
        if (0x2::table::contains<address, VoterInfo>(&arg0.voters, v5)) {
            let v6 = 0x2::table::borrow_mut<address, VoterInfo>(&mut arg0.voters, v5);
            v6.staked_amount = v6.staked_amount + v0;
            v6.voting_power = v6.voting_power + v4;
            if (v2 > v6.lock_end_time) {
                v6.lock_end_time = v2;
            };
        } else {
            let v7 = VoterInfo{
                staked_amount     : v0,
                voting_power      : v4,
                lock_end_time     : v2,
                delegation_target : 0x1::option::none<address>(),
                total_votes_cast  : 0,
            };
            0x2::table::add<address, VoterInfo>(&mut arg0.voters, v5, v7);
        };
        let v8 = StakingPosition{
            id                      : 0x2::object::new(arg4),
            owner                   : v5,
            amount                  : v0,
            lock_end_time           : v2,
            voting_power_multiplier : v3,
            created_at              : v1,
        };
        arg0.total_staked = arg0.total_staked + v0;
        arg0.total_voting_power = arg0.total_voting_power + v4;
        0x2::balance::join<GFS_GOVERNANCE>(&mut arg0.treasury_balance, 0x2::coin::into_balance<GFS_GOVERNANCE>(arg1));
        let v9 = TokensStaked{
            staker       : v5,
            amount       : v0,
            lock_period  : arg2,
            voting_power : v4,
        };
        0x2::event::emit<TokensStaked>(v9);
        0x2::transfer::transfer<StakingPosition>(v8, v5);
    }

    public entry fun unstake_tokens(arg0: &mut GovernanceRegistry, arg1: StakingPosition, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg2) >= arg1.lock_end_time, 5);
        assert!(arg1.owner == 0x2::tx_context::sender(arg3), 1);
        let v0 = 0x2::tx_context::sender(arg3);
        let v1 = arg1.amount;
        let v2 = v1 * arg1.voting_power_multiplier / 1000;
        let v3 = 0x2::table::borrow_mut<address, VoterInfo>(&mut arg0.voters, v0);
        v3.staked_amount = v3.staked_amount - v1;
        v3.voting_power = v3.voting_power - v2;
        arg0.total_staked = arg0.total_staked - v1;
        arg0.total_voting_power = arg0.total_voting_power - v2;
        0x2::transfer::public_transfer<0x2::coin::Coin<GFS_GOVERNANCE>>(0x2::coin::take<GFS_GOVERNANCE>(&mut arg0.treasury_balance, v1, arg3), v0);
        let v4 = TokensUnstaked{
            staker            : v0,
            amount            : v1,
            voting_power_lost : v2,
        };
        0x2::event::emit<TokensUnstaked>(v4);
        let StakingPosition {
            id                      : v5,
            owner                   : _,
            amount                  : _,
            lock_end_time           : _,
            voting_power_multiplier : _,
            created_at              : _,
        } = arg1;
        0x2::object::delete(v5);
    }

    public entry fun vote(arg0: &GovernanceRegistry, arg1: &mut Proposal, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::clock::timestamp_ms(arg3);
        let v1 = 0x2::tx_context::sender(arg4);
        assert!(arg1.status == 0, 3);
        assert!(v0 <= arg1.voting_end, 5);
        assert!(!0x2::table::contains<address, bool>(&arg1.voters, v1), 4);
        assert!(0x2::table::contains<address, VoterInfo>(&arg0.voters, v1), 6);
        let v2 = 0x2::table::borrow<address, VoterInfo>(&arg0.voters, v1).voting_power;
        assert!(v2 > 0, 6);
        0x2::table::add<address, bool>(&mut arg1.voters, v1, true);
        if (arg2) {
            arg1.yes_votes = arg1.yes_votes + v2;
        } else {
            arg1.no_votes = arg1.no_votes + v2;
        };
        let v3 = Vote{
            id           : 0x2::object::new(arg4),
            proposal_id  : arg1.proposal_id,
            voter        : v1,
            vote         : arg2,
            voting_power : v2,
            timestamp    : v0,
        };
        let v4 = VoteCast{
            proposal_id  : arg1.proposal_id,
            voter        : v1,
            vote         : arg2,
            voting_power : v2,
        };
        0x2::event::emit<VoteCast>(v4);
        0x2::transfer::transfer<Vote>(v3, v1);
    }

    // decompiled from Move bytecode v6
}

