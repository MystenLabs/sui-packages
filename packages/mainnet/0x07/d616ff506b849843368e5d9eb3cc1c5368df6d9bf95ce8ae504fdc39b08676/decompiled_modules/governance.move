module 0x7d616ff506b849843368e5d9eb3cc1c5368df6d9bf95ce8ae504fdc39b08676::governance {
    struct GovernanceVault<phantom T0> has key {
        id: 0x2::object::UID,
        treasury_balance: 0x2::balance::Balance<T0>,
        min_propose_balance: u64,
        proposal_deposit: u64,
        voting_period_ms: u64,
        quorum_bps: u64,
        proposal_count: u64,
        dao_admin_cap: 0x1::option::Option<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>,
        founder_admin_cap: 0x1::option::Option<0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap>,
    }

    struct Proposal<phantom T0> has key {
        id: 0x2::object::UID,
        proposal_id: u64,
        proposer: address,
        action_type: u8,
        payload: vector<u8>,
        total_eligible: u64,
        snapshot_epoch: u64,
        yes_votes: u64,
        no_votes: u64,
        voters: 0x2::table::Table<address, bool>,
        created_ms: u64,
        voting_end_ms: u64,
        end_epoch: u64,
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

    public fun burn_admin_cap_via_governance<T0>(arg0: &Proposal<T0>, arg1: &mut GovernanceVault<T0>) {
        assert!(arg0.action_type == 7, 1011);
        assert!(arg0.executed, 1005);
        assert!(arg0.yes_votes > arg0.no_votes, 1010);
        let v0 = arg0.yes_votes + arg0.no_votes;
        assert!(v0 > 0 && arg0.total_eligible > 0, 1010);
        assert!(v0 >= arg0.total_eligible * arg1.quorum_bps / 10000, 1010);
        0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::burn_admin_cap(0x1::option::extract<0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap>(&mut arg1.founder_admin_cap));
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
            dao_admin_cap       : 0x1::option::none<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(),
            founder_admin_cap   : 0x1::option::none<0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap>(),
        };
        0x2::transfer::share_object<GovernanceVault<T0>>(v0);
    }

    public fun create_proposal<T0>(arg0: &mut GovernanceVault<T0>, arg1: &0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg2: &0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::AqReceipt, arg3: u8, arg4: vector<u8>, arg5: 0x2::coin::Coin<T0>, arg6: &0x2::clock::Clock, arg7: &mut 0x2::tx_context::TxContext) {
        let v0 = 0x2::tx_context::sender(arg7);
        assert!(0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::receipt_amount(arg2) >= arg0.min_propose_balance, 1000);
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
            total_eligible : 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::total_receipts<T0>(arg1),
            snapshot_epoch : 0x2::tx_context::epoch(arg7),
            yes_votes      : 0,
            no_votes       : 0,
            voters         : 0x2::table::new<address, bool>(arg7),
            created_ms     : v1,
            voting_end_ms  : v1 + arg0.voting_period_ms,
            end_epoch      : 0x2::tx_context::epoch(arg7) + arg0.voting_period_ms / 86400000 + 2,
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

    fun dispatch_action<T0>(arg0: &Proposal<T0>, arg1: &mut GovernanceVault<T0>, arg2: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload> {
        let v0 = arg0.action_type;
        let v1 = arg0.payload;
        if (v0 == 3) {
            let v2 = 0x2::bcs::new(v1);
            0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::floors::assert_rewards_fee(0x2::bcs::peel_u64(&mut v2));
            return 0x1::option::some<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>(0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::create_gov_action_payload(0x1::option::borrow<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(&arg1.dao_admin_cap), 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_fee(), v1))
        };
        if (v0 == 4) {
            let v3 = 0x2::bcs::new(v1);
            assert!(0x2::bcs::peel_u64(&mut v3) >= 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::max_tvl_cap<T0>(arg2), 1008);
            return 0x1::option::some<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>(0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::create_gov_action_payload(0x1::option::borrow<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(&arg1.dao_admin_cap), 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_tvl_cap(), v1))
        };
        if (v0 == 5) {
            let v4 = 0x2::bcs::new(v1);
            let v5 = 0x2::bcs::peel_u64(&mut v4);
            let v6 = 0x2::bcs::peel_address(&mut v4);
            assert!(0x2::balance::value<T0>(&arg1.treasury_balance) >= v5, 1009);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::split<T0>(&mut arg1.treasury_balance, v5), arg4), v6);
            let v7 = GrantPayoutEvent{
                proposal_id : arg0.proposal_id,
                recipient   : v6,
                amount      : v5,
            };
            0x2::event::emit<GrantPayoutEvent>(v7);
        } else {
            if (v0 == 8) {
                return 0x1::option::some<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>(0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::create_gov_action_payload(0x1::option::borrow<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(&arg1.dao_admin_cap), 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_set_fee_recipient(), v1))
            };
            if (v0 == 7) {
            } else {
                if (v0 == 1) {
                    return 0x1::option::some<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>(0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::create_gov_action_payload(0x1::option::borrow<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(&arg1.dao_admin_cap), 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_register_protocol(), v1))
                };
                if (v0 == 2) {
                    return 0x1::option::some<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>(0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::create_gov_action_payload(0x1::option::borrow<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(&arg1.dao_admin_cap), 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::timelock::action_update_crank_config(), v1))
                };
                if (v0 == 6) {
                    return 0x1::option::some<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>(0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::create_gov_action_payload(0x1::option::borrow<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(&arg1.dao_admin_cap), 20, v1))
                };
            };
        };
        0x1::option::none<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>()
    }

    public fun equip_dao_admin_cap<T0>(arg0: &mut GovernanceVault<T0>, arg1: 0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap) {
        assert!(0x1::option::is_none<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(&arg0.dao_admin_cap), 1099);
        0x1::option::fill<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::DaoAdminCap>(&mut arg0.dao_admin_cap, arg1);
    }

    public fun equip_founder_admin_cap<T0>(arg0: &mut GovernanceVault<T0>, arg1: 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap) {
        assert!(0x1::option::is_none<0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap>(&arg0.founder_admin_cap), 1099);
        0x1::option::fill<0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::AdminCap>(&mut arg0.founder_admin_cap, arg1);
    }

    public fun execute_proposal<T0>(arg0: &mut Proposal<T0>, arg1: &mut GovernanceVault<T0>, arg2: &mut 0x4760190f3d43f84cabf71d9809afd17805a7780b0ede3a40afe66150f7d43b77::vault::Vault<T0>, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) : 0x1::option::Option<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload> {
        assert!(0x2::clock::timestamp_ms(arg3) > arg0.voting_end_ms, 1002);
        assert!(!arg0.executed, 1005);
        let v0 = arg0.yes_votes + arg0.no_votes >= arg0.total_eligible * arg1.quorum_bps / 10000;
        let v1 = arg0.yes_votes > arg0.no_votes;
        let v2 = if (v0 && v1) {
            let v3 = dispatch_action<T0>(arg0, arg1, arg2, arg3, arg4);
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.deposit), arg4), arg0.proposer);
            v3
        } else if (v0 && !v1) {
            0x2::balance::join<T0>(&mut arg1.treasury_balance, 0x2::balance::withdraw_all<T0>(&mut arg0.deposit));
            0x1::option::none<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>()
        } else {
            0x2::transfer::public_transfer<0x2::coin::Coin<T0>>(0x2::coin::from_balance<T0>(0x2::balance::withdraw_all<T0>(&mut arg0.deposit), arg4), arg0.proposer);
            0x1::option::none<0xc632a08776992b086741e38f5ca80b837c528de237949292483440506fb689da::admin::GovernanceActionPayload>()
        };
        arg0.executed = true;
        let v4 = v0 && v1;
        let v5 = ProposalExecutedEvent{
            proposal_id : arg0.proposal_id,
            action_type : arg0.action_type,
            yes_votes   : arg0.yes_votes,
            no_votes    : arg0.no_votes,
            passed      : v4,
        };
        0x2::event::emit<ProposalExecutedEvent>(v5);
        v2
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

    public fun proposal_end_epoch<T0>(arg0: &Proposal<T0>) : u64 {
        arg0.end_epoch
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

    public fun vote<T0>(arg0: &mut Proposal<T0>, arg1: &mut 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::AqReceipt, arg2: bool, arg3: &0x2::clock::Clock, arg4: &mut 0x2::tx_context::TxContext) {
        0x2::tx_context::sender(arg4);
        assert!(arg0.snapshot_epoch > 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::deposit_epoch(arg1), 1012);
        assert!(0x2::clock::timestamp_ms(arg3) <= arg0.voting_end_ms, 1003);
        assert!(!arg0.executed, 1005);
        let v0 = 0x2::object::id<0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::AqReceipt>(arg1);
        let v1 = 0x2::object::id_to_address(&v0);
        assert!(!0x2::table::contains<address, bool>(&arg0.voters, v1), 1004);
        let v2 = 0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::receipt_amount(arg1);
        assert!(v2 > 0, 1006);
        0xd32c31d0e1e5d5ab839f68a192a8bcf196cf200536fe0ecede3be100cab721f8::receipt::lock_receipt(arg1, arg0.end_epoch, arg4);
        if (arg2) {
            arg0.yes_votes = arg0.yes_votes + v2;
        } else {
            arg0.no_votes = arg0.no_votes + v2;
        };
        0x2::table::add<address, bool>(&mut arg0.voters, v1, arg2);
        let v3 = VoteEvent{
            proposal_id : arg0.proposal_id,
            voter       : v1,
            approve     : arg2,
            weight      : v2,
        };
        0x2::event::emit<VoteEvent>(v3);
    }

    public fun voting_period_ms<T0>(arg0: &GovernanceVault<T0>) : u64 {
        arg0.voting_period_ms
    }

    // decompiled from Move bytecode v6
}

