module 0x5cfd5b58f17b1716017250dc5c919e540d8723713ca080e19ff9878712f388ad::governance {
    struct GovernanceVault has key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>,
        min_propose_balance: u64,
        proposal_deposit: u64,
        voting_period_ms: u64,
        quorum_bps: u64,
        proposal_count: u64,
    }

    struct Proposal has key {
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
        deposit: 0x2::balance::Balance<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>,
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

    public fun borrow_treasury_balance_mut(arg0: &mut GovernanceVault) : &mut 0x2::balance::Balance<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC> {
        &mut arg0.treasury_balance
    }

    public fun burn_admin_cap_via_governance(arg0: &Proposal, arg1: &GovernanceVault, arg2: 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap) {
        assert!(arg0.action_type == 7, 1011);
        assert!(arg0.executed, 1005);
        assert!(arg0.yes_votes > arg0.no_votes, 1010);
        let v0 = arg0.yes_votes + arg0.no_votes;
        assert!(v0 > 0 && arg0.total_eligible > 0, 1010);
        assert!(v0 >= arg0.total_eligible * arg1.quorum_bps / 10000, 1010);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::burn_admin_cap(arg2);
        let v1 = AdminCapBurnedByGovernanceEvent{burned_by_proposal: arg0.proposal_id};
        0x2::event::emit<AdminCapBurnedByGovernanceEvent>(v1);
    }

    public fun create_governance_vault(arg0: &mut 0x2::tx_context::TxContext) {
        let v0 = GovernanceVault{
            id                  : 0x2::object::new(arg0),
            treasury_balance    : 0x2::balance::zero<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(),
            min_propose_balance : 100000000,
            proposal_deposit    : 50000000,
            voting_period_ms    : 604800000,
            quorum_bps          : 3300,
            proposal_count      : 0,
        };
        0x2::transfer::share_object<GovernanceVault>(v0);
    }

    public fun create_proposal(arg0: &mut GovernanceVault, arg1: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg2: &0x2::token::Token<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>, arg3: u8, arg4: vector<u8>, arg5: 0x2::coin::Coin<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0x2::token::value<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>(arg2) >= arg0.min_propose_balance, 1000);
        assert!(arg3 >= 1 && arg3 <= 8, 1007);
        assert!(0x2::coin::value<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&arg5) >= arg0.proposal_deposit, 1001);
        let v1 = 0x2::clock::timestamp_ms(arg6);
        arg0.proposal_count = arg0.proposal_count + 1;
        let v2 = Proposal{
            id             : 0x2::object::new(arg7),
            proposal_id    : arg0.proposal_count,
            proposer       : v0,
            action_type    : arg3,
            payload        : arg4,
            total_eligible : 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::total_receipts(arg1),
            yes_votes      : 0,
            no_votes       : 0,
            voters         : 0x2::table::new<address, bool>(arg7),
            created_ms     : v1,
            voting_end_ms  : v1 + arg0.voting_period_ms,
            executed       : false,
            deposit        : 0x2::coin::into_balance<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(arg5),
        };
        let v3 = ProposalCreatedEvent{
            proposal_id   : arg0.proposal_count,
            proposer      : v0,
            action_type   : arg3,
            voting_end_ms : v1 + arg0.voting_period_ms,
        };
        0x2::event::emit<ProposalCreatedEvent>(v3);
        0x2::transfer::share_object<Proposal>(v2);
    }

    public fun deposit_to_treasury(arg0: &mut GovernanceVault, arg1: 0x2::coin::Coin<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>) {
        0x2::balance::join<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&mut arg0.treasury_balance, 0x2::coin::into_balance<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(arg1));
        let v0 = TreasuryDepositEvent{amount: 0x2::coin::value<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&arg1)};
        0x2::event::emit<TreasuryDepositEvent>(v0);
    }

    fun dispatch_action(arg0: &Proposal, arg1: &mut GovernanceVault, arg2: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg3: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        let v0 = arg0.action_type;
        if (v0 == 3) {
            let v1 = 0x2::bcs::new(arg0.payload);
            let v2 = 0x2::bcs::peel_u64(&mut v1);
            0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::floors::assert_rewards_fee(v2);
            0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::update_performance_fee(arg2, arg3, v2);
        } else if (v0 == 4) {
            let v3 = 0x2::bcs::new(arg0.payload);
            let v4 = 0x2::bcs::peel_u64(&mut v3);
            assert!(v4 >= 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::max_tvl_cap(arg2), 1008);
            0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::update_tvl_cap(arg2, arg3, v4);
        } else if (v0 == 5) {
            let v5 = 0x2::bcs::new(arg0.payload);
            let v6 = 0x2::bcs::peel_u64(&mut v5);
            let v7 = 0x2::bcs::peel_address(&mut v5);
            assert!(0x2::balance::value<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&arg1.treasury_balance) >= v6, 1009);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>>(0x2::coin::from_balance<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(0x2::balance::split<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&mut arg1.treasury_balance, v6), arg5), v7);
            let v8 = GrantPayoutEvent{
                proposal_id : arg0.proposal_id,
                recipient   : v7,
                amount      : v6,
            };
            0x2::event::emit<GrantPayoutEvent>(v8);
        } else if (v0 == 8) {
            let v9 = 0x2::bcs::new(arg0.payload);
            0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::update_fee_recipient(arg2, arg3, 0x2::bcs::peel_address(&mut v9));
        };
    }

    public fun execute_proposal(arg0: &mut Proposal, arg1: &mut GovernanceVault, arg2: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg3: &0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::AdminCap, arg4: &0x2::clock::Clock, arg5: &mut 0x2::tx_context::TxContext) {
        assert!(0x2::clock::timestamp_ms(arg4) > arg0.voting_end_ms, 1002);
        assert!(!arg0.executed, 1005);
        let v0 = arg0.yes_votes + arg0.no_votes >= arg0.total_eligible * arg1.quorum_bps / 10000;
        let v1 = arg0.yes_votes > arg0.no_votes;
        if (v0 && v1) {
            dispatch_action(arg0, arg1, arg2, arg3, arg4, arg5);
            0x2::transfer::public_transfer<0x2::coin::Coin<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>>(0x2::coin::from_balance<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(0x2::balance::withdraw_all<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&mut arg0.deposit), arg5), arg0.proposer);
        } else {
            0x2::balance::join<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&mut arg1.treasury_balance, 0x2::balance::withdraw_all<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&mut arg0.deposit));
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

    public fun has_voted(arg0: &Proposal, arg1: address) : bool {
        0x2::table::contains<address, bool>(&arg0.voters, arg1)
    }

    public fun min_propose_balance(arg0: &GovernanceVault) : u64 {
        arg0.min_propose_balance
    }

    public fun proposal_count(arg0: &GovernanceVault) : u64 {
        arg0.proposal_count
    }

    public fun proposal_deposit_amount(arg0: &GovernanceVault) : u64 {
        arg0.proposal_deposit
    }

    public fun proposal_info(arg0: &Proposal) : (u64, u8, u64, u64, u64, bool) {
        (arg0.proposal_id, arg0.action_type, arg0.yes_votes, arg0.no_votes, arg0.voting_end_ms, arg0.executed)
    }

    public fun proposal_proposer(arg0: &Proposal) : address {
        arg0.proposer
    }

    public fun quorum_bps(arg0: &GovernanceVault) : u64 {
        arg0.quorum_bps
    }

    public fun treasury_balance(arg0: &GovernanceVault) : u64 {
        0x2::balance::value<0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::USDC>(&arg0.treasury_balance)
    }

    public fun vote(arg0: &mut Proposal, arg1: &mut 0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::Vault, arg2: &0x2::token::Token<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>, arg3: bool, arg4: &0x2::clock::Clock, arg5: &0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg5);
        assert!(0x2::clock::timestamp_ms(arg4) <= arg0.voting_end_ms, 1003);
        assert!(!arg0.executed, 1005);
        assert!(!0x2::table::contains<address, bool>(&arg0.voters, v0), 1004);
        let v1 = 0x2::token::value<0x20ff0009c2d82f0ccaa8f570972d1633ffc9ebe2d43d7e9809d43056c018cfb8::receipt::RECEIPT>(arg2);
        assert!(v1 > 0, 1006);
        if (arg3) {
            arg0.yes_votes = arg0.yes_votes + v1;
        } else {
            arg0.no_votes = arg0.no_votes + v1;
        };
        0x2::table::add<address, bool>(&mut arg0.voters, v0, arg3);
        0xc8b07577c7390e9f8749d031f980676d060e22d819c3577b02573018959e68dd::vault::set_vote_lock(arg1, v0, arg0.voting_end_ms, arg4);
        let v2 = VoteEvent{
            proposal_id : arg0.proposal_id,
            voter       : v0,
            approve     : arg3,
            weight      : v1,
        };
        0x2::event::emit<VoteEvent>(v2);
    }

    public fun voting_period_ms(arg0: &GovernanceVault) : u64 {
        arg0.voting_period_ms
    }

    // decompiled from Move bytecode v6
}

