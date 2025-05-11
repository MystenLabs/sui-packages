module 0x11db45c9cb04ee496185b38cc5c8cf8fae0726cdc8196c6be5ed2cb7c546b727::reward_governance {
    struct FORGE has drop {
        dummy_field: bool,
    }

    struct InvestmentVault has key {
        id: 0x2::object::UID,
        stakes: 0x2::table::Table<address, StakeInfo>,
        total_staked: u64,
    }

    struct StakeInfo has drop, store {
        amount: u64,
        lock_until: u64,
        voting_power: u64,
    }

    struct FeeConfig has key {
        id: 0x2::object::UID,
        fee_amount: u64,
        fee_collector: address,
    }

    struct Proposal has key {
        id: 0x2::object::UID,
        description: 0x1::string::String,
        creator: address,
        voting_deadline: u64,
        votes_for: u64,
        votes_against: u64,
        voted: 0x2::table::Table<address, bool>,
    }

    struct StakeEvent has copy, drop {
        staker: address,
        amount: u64,
        lock_until: u64,
    }

    struct UnstakeEvent has copy, drop {
        staker: address,
        amount: u64,
    }

    struct ProposalCreatedEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        creator: address,
        description: 0x1::string::String,
    }

    struct VoteEvent has copy, drop {
        proposal_id: 0x2::object::ID,
        voter: address,
        in_favor: bool,
        voting_power: u64,
    }

    struct FeeCollectedEvent has copy, drop {
        action: 0x1::string::String,
        amount: u64,
        collector: address,
    }

    public entry fun create_proposal(arg0: &mut InvestmentVault, arg1: vector<u8>, arg2: &FeeConfig, arg3: 0x2::coin::Coin<0x2::sui::SUI>, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.stakes, v0), 0);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg3) >= arg2.fee_amount, 2);
        let v1 = Proposal{
            id              : 0x2::object::new(arg5),
            description     : 0x1::string::utf8(arg1),
            creator         : v0,
            voting_deadline : 0x2::clock::timestamp_ms(arg4) + 7 * 24 * 60 * 60 * 1000,
            votes_for       : 0,
            votes_against   : 0,
            voted           : 0x2::table::new<address, bool>(arg5),
        };
        let v2 = ProposalCreatedEvent{
            proposal_id : 0x2::object::id<Proposal>(&v1),
            creator     : v0,
            description : 0x1::string::utf8(arg1),
        };
        0x2::event::emit<ProposalCreatedEvent>(v2);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg3, arg2.fee_collector);
        let v3 = FeeCollectedEvent{
            action    : 0x1::string::utf8(b"create_proposal"),
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg3),
            collector : arg2.fee_collector,
        };
        0x2::event::emit<FeeCollectedEvent>(v3);
        0x2::transfer::share_object<Proposal>(v1);
    }

    fun init(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = InvestmentVault{
            id           : 0x2::object::new(arg0),
            stakes       : 0x2::table::new<address, StakeInfo>(arg0),
            total_staked : 0,
        };
        let v1 = FeeConfig{
            id            : 0x2::object::new(arg0),
            fee_amount    : 200000000,
            fee_collector : @0x576dd55fd0976f0042f6f78e48e5063f6fca8988fb6f976a9abc1bef571873fd,
        };
        0x2::transfer::share_object<InvestmentVault>(v0);
        0x2::transfer::share_object<FeeConfig>(v1);
    }

    public fun stake_forge(arg0: &mut InvestmentVault, arg1: 0x2::coin::Coin<FORGE>, arg2: u64, arg3: &FeeConfig, arg4: 0x2::coin::Coin<0x2::sui::SUI>, arg5: &0x2::clock::Clock, arg6: &mut 0x2::tx_context::TxContext) : 0x2::coin::Coin<FORGE> {
        let v0 = 0x2::coin::value<FORGE>(&arg1);
        assert!(v0 > 0, 0);
        assert!(arg2 >= 30 && arg2 <= 365, 1);
        assert!(0x2::coin::value<0x2::sui::SUI>(&arg4) >= arg3.fee_amount, 2);
        let v1 = 0x2::tx_context::sender(arg6);
        let v2 = 0x2::clock::timestamp_ms(arg5) + arg2 * 24 * 60 * 60 * 1000;
        if (0x2::table::contains<address, StakeInfo>(&arg0.stakes, v1)) {
            let v3 = 0x2::table::borrow_mut<address, StakeInfo>(&mut arg0.stakes, v1);
            v3.amount = v3.amount + v0;
            let v4 = if (v2 > v3.lock_until) {
                v2
            } else {
                v3.lock_until
            };
            v3.lock_until = v4;
            v3.voting_power = v3.voting_power + v0 * arg2 / 30;
        } else {
            let v5 = StakeInfo{
                amount       : v0,
                lock_until   : v2,
                voting_power : v0 * arg2 / 30,
            };
            0x2::table::add<address, StakeInfo>(&mut arg0.stakes, v1, v5);
        };
        arg0.total_staked = arg0.total_staked + v0;
        let v6 = StakeEvent{
            staker     : v1,
            amount     : v0,
            lock_until : v2,
        };
        0x2::event::emit<StakeEvent>(v6);
        0x2::transfer::public_transfer<0x2::coin::Coin<0x2::sui::SUI>>(arg4, arg3.fee_collector);
        let v7 = FeeCollectedEvent{
            action    : 0x1::string::utf8(b"stake_forge"),
            amount    : 0x2::coin::value<0x2::sui::SUI>(&arg4),
            collector : arg3.fee_collector,
        };
        0x2::event::emit<FeeCollectedEvent>(v7);
        arg1
    }

    public entry fun unstake_forge(arg0: &mut InvestmentVault, arg1: u64, arg2: &0x2::clock::Clock, arg3: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg3);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.stakes, v0), 0);
        let v1 = 0x2::table::borrow_mut<address, StakeInfo>(&mut arg0.stakes, v0);
        assert!(v1.amount >= arg1, 0);
        assert!(0x2::clock::timestamp_ms(arg2) >= v1.lock_until, 1);
        v1.amount = v1.amount - arg1;
        v1.voting_power = v1.voting_power * v1.amount / (v1.amount + arg1);
        arg0.total_staked = arg0.total_staked - arg1;
        if (v1.amount == 0) {
            0x2::table::remove<address, StakeInfo>(&mut arg0.stakes, v0);
        };
        let v2 = UnstakeEvent{
            staker : v0,
            amount : arg1,
        };
        0x2::event::emit<UnstakeEvent>(v2);
    }

    public entry fun update_fee(arg0: &mut InvestmentVault, arg1: &mut FeeConfig, arg2: u64, arg3: &mut 0x2::tx_context::TxContext) {
        assert!(arg2 > 0, 0);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.stakes, 0x2::tx_context::sender(arg3)), 0);
        arg1.fee_amount = arg2;
    }

    public entry fun vote_on_proposal(arg0: &mut InvestmentVault, arg1: &mut Proposal, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg4);
        assert!(0x2::table::contains<address, StakeInfo>(&arg0.stakes, v0), 0);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg1.voting_deadline, 5);
        assert!(!0x2::table::contains<address, bool>(&arg1.voted, v0), 4);
        let v1 = 0x2::table::borrow<address, StakeInfo>(&arg0.stakes, v0).voting_power;
        if (arg2) {
            arg1.votes_for = arg1.votes_for + v1;
        } else {
            arg1.votes_against = arg1.votes_against + v1;
        };
        0x2::table::add<address, bool>(&mut arg1.voted, v0, true);
        let v2 = VoteEvent{
            proposal_id  : 0x2::object::id<Proposal>(arg1),
            voter        : v0,
            in_favor     : arg2,
            voting_power : v1,
        };
        0x2::event::emit<VoteEvent>(v2);
    }

    // decompiled from Move bytecode v6
}

