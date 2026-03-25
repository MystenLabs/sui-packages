module 0xa402ca8f25da822c4d6e19e27c1b7eadf051f4642b4ea3c6a670458fe493f68f::governance {
    struct GovernanceVault<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<T0>,
        min_propose_balance: u64,
        proposal_deposit: u64,
        voting_period_ms: u64,
        quorum_bps: u64,
        proposal_count: u64,
    }

    struct Proposal<phantom T0> has key {
        id: 0x2::object::UID,
        proposal_id: u64,
        proposer: address,
        action_type: u8,
        payload: vector<u8>,
        total_eligible: u64,
        yes_votes: u64,
        no_votes: u64,
        voters: 0x2::table::Table<address, bool>,
        created_ms: u64,
        voting_end_ms: u64,
        executed: bool,
        deposit: 0x2::balance::Balance<T0>,
    }

    struct ProposalCreatedEvent has copy, drop {
        proposal_id: u64,
        proposer: address,
        action_type: u8,
        voting_end_ms: u64,
    }

    struct VoteEvent has copy, drop {
        proposal_id: u64,
        voter: address,
        approve: bool,
        weight: u64,
    }

    struct ProposalExecutedEvent has copy, drop {
        proposal_id: u64,
        action_type: u8,
        yes_votes: u64,
        no_votes: u64,
        passed: bool,
    }

    struct GrantPayoutEvent has copy, drop {
        proposal_id: u64,
        recipient: address,
        amount: u64,
    }

    struct AdminCapBurnedByGovernanceEvent has copy, drop {
        burned_by_proposal: u64,
    }

    struct TreasuryDepositEvent has copy, drop {
        amount: u64,
    }

    public fun action_burn_admin_cap() : u8 {
        7
    }

    public fun action_grant_payout() : u8 {
        5
    }

    public fun action_increase_tvl_cap() : u8 {
        4
    }

    public fun action_register_protocol() : u8 {
        1
    }

    public fun action_set_ema_alpha() : u8 {
        6
    }

    public fun action_set_fee_recipient() : u8 {
        8
    }

    public fun action_update_config() : u8 {
        2
    }

    public fun action_update_fee() : u8 {
        3
    }

    public fun borrow_treasury_balance_mut<T0>(arg0: &mut GovernanceVault<T0>) : &mut 0x2::balance::Balance<T0> {
        &mut arg0.treasury_balance
    }

    public fun burn_admin_cap_via_governance<T0>(arg0: &Proposal<T0>, arg1: &GovernanceVault<T0>, arg2: 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::AdminCap) {
        assert!(arg0.action_type == 7, 1011);
        assert!(arg0.executed, 1005);
        assert!(arg0.yes_votes > arg0.no_votes, 1010);
        let v0 = arg0.yes_votes + arg0.no_votes;
        assert!(v0 > 0 && arg0.total_eligible > 0, 1010);
        assert!(v0 >= arg0.total_eligible * arg1.quorum_bps / 10000, 1010);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::burn_admin_cap(arg2);
        let v1 = AdminCapBurnedByGovernanceEvent{burned_by_proposal: arg0.proposal_id};
        0x2::event::emit<AdminCapBurnedByGovernanceEvent>(v1);
    }

    public fun create_governance_vault<T0>(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceVault<T0>{
            id                  : 0x2::object::new(arg0),
            treasury_balance    : 0x2::balance::zero<T0>(),
            min_propose_balance : 100000000,
            proposal_deposit    : 50000000,
            voting_period_ms    : 604800000,
            quorum_bps          : 3300,
            proposal_count      : 0,
        };
        0x2::transfer::share_object<GovernanceVault<T0>>(v0);
    }

    public fun create_proposal<T0>(arg0: &mut GovernanceVault<T0>, arg1: &0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::Vault<T0>, arg2: &0x2::token::Token<0xa4ffc4778b541f2c962c1548a80eebb21e884061ac7f5efea419c9aa8dd9a484::receipt::RECEIPT>, arg3: u8, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::token::value<0xa4ffc4778b541f2c962c1548a80eebb21e884061ac7f5efea419c9aa8dd9a484::receipt::RECEIPT>(arg2) >= arg0.min_propose_balance, 1000);
        assert!(arg3 >= 1 && arg3 <= 8, 1007);
        assert!(0x2::coin::value<T0>(&arg5) >= arg0.proposal_deposit, 1001);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        arg0.proposal_count = arg0.proposal_count + 1;
        let v2 = Proposal<T0>{
            id             : 0x2::object::new(arg7),
            proposal_id    : arg0.proposal_count,
            proposer       : v0,
            action_type    : arg3,
            payload        : arg4,
            total_eligible : 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::total_receipts<T0>(arg1),
            yes_votes      : 0,
            no_votes       : 0,
            voters         : 0x2::table::new<address, bool>(arg7),
            created_ms     : v1,
            voting_end_ms  : v1 + arg0.voting_period_ms,
            executed       : false,
            deposit        : 0x2::coin::into_balance<T0>(arg5),
        };
        let v3 = ProposalCreatedEvent{
            proposal_id   : arg0.proposal_count,
            proposer      : v0,
            action_type   : arg3,
            voting_end_ms : v1 + arg0.voting_period_ms,
        };
        0x2::event::emit<ProposalCreatedEvent>(v3);
        0x2::transfer::share_object<Proposal<T0>>(v2);
    }

    public fun deposit_to_treasury<T0>(arg0: &mut GovernanceVault<T0>, arg1: 0x2::coin::Coin<T0>) {
        0x2::balance::join<T0>(&mut arg0.treasury_balance, 0x2::coin::into_balance<T0>(arg1));
        let v0 = TreasuryDepositEvent{amount: 0x2::coin::value<T0>(&arg1)};
        0x2::event::emit<TreasuryDepositEvent>(v0);
    }

    fun dispatch_action<T0>(arg0: &Proposal<T0>, arg1: &mut GovernanceVault<T0>, arg2: &mut 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::Vault<T0>, arg3: &0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.action_type;
        if (v0 == 3) {
            let v1 = 0x2::bcs::new(arg0.payload);
            let v2 = 0x2::bcs::peel_u64(&mut v1);
            0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::floors::assert_rewards_fee(v2);
            0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::update_performance_fee<T0>(arg2, arg3, v2);
        } else if (v0 == 4) {
            let v3 = 0x2::bcs::new(arg0.payload);
            let v4 = 0x2::bcs::peel_u64(&mut v3);
            assert!(v4 >= 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::max_tvl_cap<T0>(arg2), 1008);
            0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::update_tvl_cap<T0>(arg2, arg3, v4);
        } else if (v0 == 5) {
            let v5 = 0x2::bcs::new(arg0.payload);
            let v6 = 0x2::bcs::peel_u64(&mut v5);
            let v7 = 0x2::bcs::peel_address(&mut v5);
            assert!(0x2::balance::value<T0>(&arg1.treasury_balance) >= v6, 1009);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury_balance, v6), arg5), v7);
            let v8 = GrantPayoutEvent{
                proposal_id : arg0.proposal_id,
                recipient   : v7,
                amount      : v6,
            };
            0x2::event::emit<GrantPayoutEvent>(v8);
        } else if (v0 == 8) {
            let v9 = 0x2::bcs::new(arg0.payload);
            0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::update_fee_recipient<T0>(arg2, arg3, 0x2::bcs::peel_address(&mut v9));
        };
    }

    public fun execute_proposal<T0>(arg0: &mut Proposal<T0>, arg1: &mut GovernanceVault<T0>, arg2: &mut 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::Vault<T0>, arg3: &0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) > arg0.voting_end_ms, 1002);
        assert!(!arg0.executed, 1005);
        let v0 = arg0.yes_votes + arg0.no_votes >= arg0.total_eligible * arg1.quorum_bps / 10000;
        let v1 = arg0.yes_votes > arg0.no_votes;
        if (v0 && v1) {
            dispatch_action<T0>(arg0, arg1, arg2, arg3, arg4, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.deposit), arg5), arg0.proposer);
        } else {
            0x2::balance::join<T0>(&mut arg1.treasury_balance, 0x2::balance::withdraw_all<T0>(&mut arg0.deposit));
        };
        arg0.executed = true;
        let v2 = v0 && v1;
        let v3 = ProposalExecutedEvent{
            proposal_id : arg0.proposal_id,
            action_type : arg0.action_type,
            yes_votes   : arg0.yes_votes,
            no_votes    : arg0.no_votes,
            passed      : v2,
        };
        0x2::event::emit<ProposalExecutedEvent>(v3);
    }

    public fun has_voted<T0>(arg0: &Proposal<T0>, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.voters, arg1)
    }

    public fun min_propose_balance<T0>(arg0: &GovernanceVault<T0>) : u64 {
        arg0.min_propose_balance
    }

    public fun proposal_count<T0>(arg0: &GovernanceVault<T0>) : u64 {
        arg0.proposal_count
    }

    public fun proposal_deposit_amount<T0>(arg0: &GovernanceVault<T0>) : u64 {
        arg0.proposal_deposit
    }

    public fun proposal_info<T0>(arg0: &Proposal<T0>) : (u64, u8, u64, u64, u64, bool) {
        (arg0.proposal_id, arg0.action_type, arg0.yes_votes, arg0.no_votes, arg0.voting_end_ms, arg0.executed)
    }

    public fun proposal_proposer<T0>(arg0: &Proposal<T0>) : address {
        arg0.proposer
    }

    public fun quorum_bps<T0>(arg0: &GovernanceVault<T0>) : u64 {
        arg0.quorum_bps
    }

    public fun treasury_balance<T0>(arg0: &GovernanceVault<T0>) : u64 {
        0x2::balance::value<T0>(&arg0.treasury_balance)
    }

    public fun vote<T0>(arg0: &mut Proposal<T0>, arg1: &mut 0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::Vault<T0>, arg2: &0x2::token::Token<0xa4ffc4778b541f2c962c1548a80eebb21e884061ac7f5efea419c9aa8dd9a484::receipt::RECEIPT>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg0.voting_end_ms, 1003);
        assert!(!arg0.executed, 1005);
        assert!(!0x2::table::contains<address, bool>(&arg0.voters, v0), 1004);
        let v1 = 0x2::token::value<0xa4ffc4778b541f2c962c1548a80eebb21e884061ac7f5efea419c9aa8dd9a484::receipt::RECEIPT>(arg2);
        assert!(v1 > 0, 1006);
        if (arg3) {
            arg0.yes_votes = arg0.yes_votes + v1;
        } else {
            arg0.no_votes = arg0.no_votes + v1;
        };
        0x2::table::add<address, bool>(&mut arg0.voters, v0, arg3);
        0x75ecf86d06f900ceaa979339965b5f9fa4e8a43a60816e58cbbfa37762bba5b7::vault::set_vote_lock<T0>(arg1, v0, arg0.voting_end_ms, arg4);
        let v2 = VoteEvent{
            proposal_id : arg0.proposal_id,
            voter       : v0,
            approve     : arg3,
            weight      : v1,
        };
        0x2::event::emit<VoteEvent>(v2);
    }

    public fun voting_period_ms<T0>(arg0: &GovernanceVault<T0>) : u64 {
        arg0.voting_period_ms
    }

    // decompiled from Move bytecode v6
}

