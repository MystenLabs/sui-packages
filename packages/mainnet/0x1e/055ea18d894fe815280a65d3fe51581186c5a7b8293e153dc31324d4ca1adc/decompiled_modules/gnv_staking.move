module 0x1e055ea18d894fe815280a65d3fe51581186c5a7b8293e153dc31324d4ca1adc::gnv_staking {
    struct AdminCap has store, key {
        id: 0x2::object::UID,
    }

    struct StakingPool has key {
        id: 0x2::object::UID,
        staked_balance: 0x2::balance::Balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>,
        reward_balance: 0x2::balance::Balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>,
        total_staked: u64,
        total_burned: u64,
        total_rewards_paid: u64,
        active: bool,
        committed_rewards: u64,
    }

    struct Stake has store, key {
        id: 0x2::object::UID,
        owner: address,
        principal: u64,
        lock_days: u64,
        apy_bp: u64,
        max_reward: u64,
        start_ms: u64,
        end_ms: u64,
    }

    struct StakeCreated has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        principal: u64,
        lock_days: u64,
        apy_bp: u64,
        max_reward: u64,
        end_ms: u64,
    }

    struct StakeWithdrawn has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        principal: u64,
        reward_earned: u64,
        reward_burned: u64,
        days_staked: u64,
        completed: bool,
    }

    struct StakeBurned has copy, drop {
        stake_id: 0x2::object::ID,
        owner: address,
        amount_burned: u64,
    }

    struct RewardPoolFunded has copy, drop {
        amount: u64,
        new_balance: u64,
    }

    struct UnusedRewardsWithdrawn has copy, drop {
        amount: u64,
        new_balance: u64,
        recipient: address,
    }

    struct StakingStatusChanged has copy, drop {
        active: bool,
    }

    struct GovernanceProposal has store, key {
        id: 0x2::object::UID,
        proposal_idx: u64,
        proposer: address,
        description: vector<u8>,
        votes_for: u64,
        votes_against: u64,
        deadline_ms: u64,
        executed: bool,
        voted: 0x2::table::Table<0x2::object::ID, bool>,
    }

    struct GovernancePool has key {
        id: 0x2::object::UID,
        proposals: 0x2::table::Table<u64, 0x2::object::ID>,
        count: u64,
    }

    struct ProposalCreated has copy, drop {
        proposal_id: u64,
        proposer: address,
        deadline_ms: u64,
    }

    struct VoteCast has copy, drop {
        proposal_id: u64,
        voter: address,
        vote_for: bool,
        weight: u64,
    }

    public fun admin_burn_stake(arg0: &AdminCap, arg1: &mut StakingPool, arg2: Stake, arg3: &mut 0x2::tx_context::TxContext) {
        let Stake {
            id         : v0,
            owner      : v1,
            principal  : v2,
            lock_days  : _,
            apy_bp     : _,
            max_reward : v5,
            start_ms   : _,
            end_ms     : _,
        } = arg2;
        let v8 = v0;
        0x2::object::delete(v8);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>>(0x2::coin::from_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(0x2::balance::split<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut arg1.staked_balance, v2), arg3), @0x0);
        arg1.total_staked = arg1.total_staked - v2;
        arg1.total_burned = arg1.total_burned + v2;
        arg1.committed_rewards = arg1.committed_rewards - v5;
        let v9 = StakeBurned{
            stake_id      : 0x2::object::uid_to_inner(&v8),
            owner         : v1,
            amount_burned : v2,
        };
        0x2::event::emit<StakeBurned>(v9);
    }

    public fun admin_withdraw_unused_rewards(arg0: &AdminCap, arg1: &mut StakingPool, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::balance::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg1.reward_balance);
        let v1 = if (v0 > arg1.committed_rewards) {
            v0 - arg1.committed_rewards
        } else {
            0
        };
        assert!(arg2 > 0, 3);
        assert!(arg2 <= v1, 6);
        let v2 = 0x2::tx_context::sender(arg3);
        0x2::transfer::public_transfer<0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>>(0x2::coin::from_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(0x2::balance::split<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut arg1.reward_balance, arg2), arg3), v2);
        let v3 = UnusedRewardsWithdrawn{
            amount      : arg2,
            new_balance : 0x2::balance::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg1.reward_balance),
            recipient   : v2,
        };
        0x2::event::emit<UnusedRewardsWithdrawn>(v3);
    }

    public fun create_proposal(arg0: &mut GovernancePool, arg1: &Stake, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg5), 13);
        assert!(0x1::vector::length<u8>(&arg2) <= 500, 14);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg3 * 86400000;
        let v1 = arg0.count;
        let v2 = GovernanceProposal{
            id            : 0x2::object::new(arg5),
            proposal_idx  : v1,
            proposer      : 0x2::tx_context::sender(arg5),
            description   : arg2,
            votes_for     : 0,
            votes_against : 0,
            deadline_ms   : v0,
            executed      : false,
            voted         : 0x2::table::new<0x2::object::ID, bool>(arg5),
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg0.proposals, v1, 0x2::object::id<GovernanceProposal>(&v2));
        arg0.count = v1 + 1;
        let v3 = ProposalCreated{
            proposal_id : v1,
            proposer    : 0x2::tx_context::sender(arg5),
            deadline_ms : v0,
        };
        0x2::event::emit<ProposalCreated>(v3);
        0x2::transfer::share_object<GovernanceProposal>(v2);
    }

    public fun create_proposal_by_admin(arg0: &AdminCap, arg1: &mut GovernancePool, arg2: vector<u8>, arg3: u64, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x1::vector::length<u8>(&arg2) <= 500, 14);
        let v0 = 0x2::clock::timestamp_ms(arg4) + arg3 * 86400000;
        let v1 = arg1.count;
        let v2 = GovernanceProposal{
            id            : 0x2::object::new(arg5),
            proposal_idx  : v1,
            proposer      : 0x2::tx_context::sender(arg5),
            description   : arg2,
            votes_for     : 0,
            votes_against : 0,
            deadline_ms   : v0,
            executed      : false,
            voted         : 0x2::table::new<0x2::object::ID, bool>(arg5),
        };
        0x2::table::add<u64, 0x2::object::ID>(&mut arg1.proposals, v1, 0x2::object::id<GovernanceProposal>(&v2));
        arg1.count = v1 + 1;
        let v3 = ProposalCreated{
            proposal_id : v1,
            proposer    : 0x2::tx_context::sender(arg5),
            deadline_ms : v0,
        };
        0x2::event::emit<ProposalCreated>(v3);
        0x2::transfer::share_object<GovernanceProposal>(v2);
    }

    public fun fund_rewards(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>) {
        0x2::balance::join<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut arg0.reward_balance, 0x2::coin::into_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(arg1));
        let v0 = RewardPoolFunded{
            amount      : 0x2::coin::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg1),
            new_balance : 0x2::balance::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg0.reward_balance),
        };
        0x2::event::emit<RewardPoolFunded>(v0);
    }

    public fun get_apy_bp(arg0: u64) : u64 {
        if (arg0 < 30) {
            return 200
        };
        if (arg0 <= 30) {
            return 500
        };
        if (arg0 <= 90) {
            return lerp(30, 500, 90, 1200, arg0)
        };
        if (arg0 <= 180) {
            return lerp(90, 1200, 180, 2500, arg0)
        };
        if (arg0 <= 365) {
            return lerp(180, 2500, 365, 5000, arg0)
        };
        if (arg0 <= 730) {
            return lerp(365, 5000, 730, 8000, arg0)
        };
        if (arg0 <= 1825) {
            return lerp(730, 8000, 1825, 12000, arg0)
        };
        12000
    }

    public fun gov_count(arg0: &GovernancePool) : u64 {
        arg0.count
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = AdminCap{id: 0x2::object::new(arg0)};
        0x2::transfer::transfer<AdminCap>(v0, 0x2::tx_context::sender(arg0));
        let v1 = StakingPool{
            id                 : 0x2::object::new(arg0),
            staked_balance     : 0x2::balance::zero<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(),
            reward_balance     : 0x2::balance::zero<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(),
            total_staked       : 0,
            total_burned       : 0,
            total_rewards_paid : 0,
            active             : false,
            committed_rewards  : 0,
        };
        0x2::transfer::share_object<StakingPool>(v1);
        init_governance(arg0);
    }

    fun init_governance(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernancePool{
            id        : 0x2::object::new(arg0),
            proposals : 0x2::table::new<u64, 0x2::object::ID>(arg0),
            count     : 0,
        };
        0x2::transfer::share_object<GovernancePool>(v0);
    }

    fun lerp(arg0: u64, arg1: u64, arg2: u64, arg3: u64, arg4: u64) : u64 {
        if (arg4 <= arg0) {
            return arg1
        };
        if (arg4 >= arg2) {
            return arg3
        };
        arg1 + (arg3 - arg1) * (arg4 - arg0) / (arg2 - arg0)
    }

    public fun pool_active(arg0: &StakingPool) : bool {
        arg0.active
    }

    public fun pool_committed_rewards(arg0: &StakingPool) : u64 {
        arg0.committed_rewards
    }

    public fun pool_reward_balance(arg0: &StakingPool) : u64 {
        0x2::balance::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg0.reward_balance)
    }

    public fun pool_rewards_paid(arg0: &StakingPool) : u64 {
        arg0.total_rewards_paid
    }

    public fun pool_total_burned(arg0: &StakingPool) : u64 {
        arg0.total_burned
    }

    public fun pool_total_staked(arg0: &StakingPool) : u64 {
        arg0.total_staked
    }

    public fun pool_unused_rewards(arg0: &StakingPool) : u64 {
        let v0 = 0x2::balance::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg0.reward_balance);
        if (v0 > arg0.committed_rewards) {
            v0 - arg0.committed_rewards
        } else {
            0
        }
    }

    public fun proposal_deadline(arg0: &GovernanceProposal) : u64 {
        arg0.deadline_ms
    }

    public fun proposal_executed(arg0: &GovernanceProposal) : bool {
        arg0.executed
    }

    public fun proposal_idx(arg0: &GovernanceProposal) : u64 {
        arg0.proposal_idx
    }

    public fun proposal_proposer(arg0: &GovernanceProposal) : address {
        arg0.proposer
    }

    public fun proposal_votes_against(arg0: &GovernanceProposal) : u64 {
        arg0.votes_against
    }

    public fun proposal_votes_for(arg0: &GovernanceProposal) : u64 {
        arg0.votes_for
    }

    public fun set_active(arg0: &AdminCap, arg1: &mut StakingPool, arg2: bool) {
        arg1.active = arg2;
        let v0 = StakingStatusChanged{active: arg2};
        0x2::event::emit<StakingStatusChanged>(v0);
    }

    public fun stake(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : Stake {
        assert!(arg0.active, 1);
        assert!(arg2 >= 1 && arg2 <= 1825, 2);
        let v0 = 0x2::coin::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg1);
        assert!(v0 >= 100000000, 3);
        let v1 = get_apy_bp(arg2);
        let v2 = (((v0 as u128) * (v1 as u128) * (arg2 as u128) / 3650000) as u64);
        let v3 = 0x2::balance::value<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&arg0.reward_balance);
        let v4 = if (v3 > arg0.committed_rewards) {
            v3 - arg0.committed_rewards
        } else {
            0
        };
        assert!(v4 >= v2, 4);
        let v5 = 0x2::clock::timestamp_ms(arg3);
        let v6 = v5 + arg2 * 86400000;
        0x2::balance::join<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut arg0.staked_balance, 0x2::coin::into_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(arg1));
        arg0.total_staked = arg0.total_staked + v0;
        arg0.committed_rewards = arg0.committed_rewards + v2;
        let v7 = Stake{
            id         : 0x2::object::new(arg4),
            owner      : 0x2::tx_context::sender(arg4),
            principal  : v0,
            lock_days  : arg2,
            apy_bp     : v1,
            max_reward : v2,
            start_ms   : v5,
            end_ms     : v6,
        };
        let v8 = StakeCreated{
            stake_id   : 0x2::object::id<Stake>(&v7),
            owner      : 0x2::tx_context::sender(arg4),
            principal  : v0,
            lock_days  : arg2,
            apy_bp     : v1,
            max_reward : v2,
            end_ms     : v6,
        };
        0x2::event::emit<StakeCreated>(v8);
        v7
    }

    public fun stake_apy_bp(arg0: &Stake) : u64 {
        arg0.apy_bp
    }

    public fun stake_end_ms(arg0: &Stake) : u64 {
        arg0.end_ms
    }

    entry fun stake_entry(arg0: &mut StakingPool, arg1: 0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>, arg2: u64, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = stake(arg0, arg1, arg2, arg3, arg4);
        0x2::transfer::public_transfer<Stake>(v0, 0x2::tx_context::sender(arg4));
    }

    public fun stake_lock_days(arg0: &Stake) : u64 {
        arg0.lock_days
    }

    public fun stake_max_reward(arg0: &Stake) : u64 {
        arg0.max_reward
    }

    public fun stake_owner(arg0: &Stake) : address {
        arg0.owner
    }

    public fun stake_principal(arg0: &Stake) : u64 {
        arg0.principal
    }

    public fun stake_start_ms(arg0: &Stake) : u64 {
        arg0.start_ms
    }

    public fun unstake(arg0: &mut StakingPool, arg1: Stake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let Stake {
            id         : v0,
            owner      : v1,
            principal  : v2,
            lock_days  : v3,
            apy_bp     : _,
            max_reward : v5,
            start_ms   : v6,
            end_ms     : v7,
        } = arg1;
        let v8 = v0;
        assert!(v1 == 0x2::tx_context::sender(arg3), 5);
        0x2::object::delete(v8);
        let v9 = 0x2::clock::timestamp_ms(arg2);
        let v10 = v9 >= v7;
        let v11 = if (v10) {
            v3
        } else {
            (v9 - v6) / 86400000
        };
        let v12 = if (v3 == 0) {
            0
        } else {
            (((v5 as u128) * (v11 as u128) / (v3 as u128)) as u64)
        };
        let v13 = v5 - v12;
        let v14 = 0x2::coin::from_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(0x2::balance::split<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut arg0.staked_balance, v2), arg3);
        arg0.total_staked = arg0.total_staked - v2;
        arg0.committed_rewards = arg0.committed_rewards - v5;
        if (v12 > 0) {
            0x2::coin::join<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut v14, 0x2::coin::from_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(0x2::balance::split<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut arg0.reward_balance, v12), arg3));
            arg0.total_rewards_paid = arg0.total_rewards_paid + v12;
        };
        if (v13 > 0) {
            0x2::transfer::public_transfer<0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>>(0x2::coin::from_balance<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(0x2::balance::split<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>(&mut arg0.reward_balance, v13), arg3), @0x0);
            arg0.total_burned = arg0.total_burned + v13;
        };
        0x2::transfer::public_transfer<0x2::coin::Coin<0xddf9eb12eab3f3c7107977b389d604eda4b589ec5811c2266da0d8afabfbaee::gnv_token::GNV_TOKEN>>(v14, v1);
        let v15 = StakeWithdrawn{
            stake_id      : 0x2::object::uid_to_inner(&v8),
            owner         : v1,
            principal     : v2,
            reward_earned : v12,
            reward_burned : v13,
            days_staked   : v11,
            completed     : v10,
        };
        0x2::event::emit<StakeWithdrawn>(v15);
    }

    entry fun unstake_entry(arg0: &mut StakingPool, arg1: Stake, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        unstake(arg0, arg1, arg2, arg3);
    }

    public fun vote(arg0: &mut GovernanceProposal, arg1: &Stake, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        assert!(arg1.owner == 0x2::tx_context::sender(arg4), 13);
        assert!(0x2::clock::timestamp_ms(arg3) < arg0.deadline_ms, 11);
        let v0 = 0x2::object::id<Stake>(arg1);
        assert!(!0x2::table::contains<0x2::object::ID, bool>(&arg0.voted, v0), 12);
        0x2::table::add<0x2::object::ID, bool>(&mut arg0.voted, v0, true);
        let v1 = arg1.principal;
        if (arg2) {
            arg0.votes_for = arg0.votes_for + v1;
        } else {
            arg0.votes_against = arg0.votes_against + v1;
        };
        let v2 = VoteCast{
            proposal_id : arg0.proposal_idx,
            voter       : 0x2::tx_context::sender(arg4),
            vote_for    : arg2,
            weight      : v1,
        };
        0x2::event::emit<VoteCast>(v2);
    }

    // decompiled from Move bytecode v7
}

